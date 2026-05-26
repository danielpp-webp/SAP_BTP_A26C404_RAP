@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption entity - Sales order items'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZITEMS_C_0230
  as projection on ZITEMS_R_0230
{
  key ItemUUID,
      ItemID,
      OrderUUID,
      Name,
      Description,
      ReleaseDate,
      DiscontinuedDate,
      Price,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
      Height,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
      Width,
      Depth,
      Quantity,
      @Consumption.valueHelpDefinition: [{ entity.name: 'I_UnitOfMeasure',
                                           entity.element: 'UnitOfMeasure',
                                           useForValidation: true }]
      UnitOfMeasure,
      // Local ETAg field --> OData Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      /* Associations */
      _Orders : redirected to parent ZORDERS_C_0230
}
