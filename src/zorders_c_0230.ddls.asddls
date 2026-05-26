@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption entity - Sales orders'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZORDERS_C_0230
  provider contract transactional_query
  as projection on ZORDERS_R_0230
{
  key OrderUUID,
      OrderID,
      Email,
      FirstName,
      LastName,
      @ObjectModel.text.element: [ 'CountryName' ]
      @Consumption.valueHelpDefinition: [{ entity.name: 'I_CountryVH',
                                           entity.element: 'Country',
                                           useForValidation: true }]
      Country,
      _Country.Description as CountryName,
      CreatedOn,
      DeliveryDate,
      @ObjectModel.text.element: [ 'OrderStatusText' ]
      @Consumption.valueHelpDefinition: [{ entity.name: 'ZORDERSTATUS_VH_0230',
                                           entity.element: 'Orderstatus' }]
      OrderStatus,
      _OrderStatus.Text    as OrderStatusText : localized,
      ImageURL,
      @EndUserText.label: 'Image'
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIRT_ELEM_IMAGE_THUMB_0230'
      @Semantics.imageUrl: true
      virtual ImageThumb : zde_imageurl_0230,
      @Semantics.user.createdBy: true
      LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      LocalLastChangedBy,
      // Total ETag Field
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      // Local ETAg field --> OData Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      /* Associations */
      _Country,
      _Items : redirected to composition child ZITEMS_C_0230,
      _OrderStatus
}
