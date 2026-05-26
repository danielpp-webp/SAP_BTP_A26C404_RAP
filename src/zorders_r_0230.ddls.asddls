@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root entity - Sales orders'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZORDERS_R_0230
  as select from zorders_0230 as Orders
  composition [0..*] of ZITEMS_R_0230        as _Items
  association [1..1] to I_CountryVH          as _Country     on _Country.Country = $projection.Country
  association [1..*] to ZORDERSTATUS_VH_0230 as _OrderStatus on _OrderStatus.Orderstatus = $projection.OrderStatus
{
  key orderuuid          as OrderUUID,
      orderid            as OrderID,
      email              as Email,
      firstname          as FirstName,
      lastname           as LastName,
      country            as Country,
      createdon          as CreatedOn,
      deliverydate       as DeliveryDate,
      orderstatus        as OrderStatus,
      imageurl           as ImageURL,
      @Semantics.user.createdBy: true
      localcreatedby     as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      localcreatedat     as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      locallastchangedby as LocalLastChangedBy,
      // Total ETag Field
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat      as LastChangedAt,
      // Local ETAg field --> OData Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat as LocalLastChangedAt,
      _Items,
      _Country,
      _OrderStatus
}
