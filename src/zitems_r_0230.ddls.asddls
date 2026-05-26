@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root entity - Sales order items'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZITEMS_R_0230
  as select from zitems_0230 as Items
  association to parent ZORDERS_R_0230 as _Orders on $projection.OrderUUID = _Orders.OrderUUID
{
  key itemuuid           as ItemUUID,
      itemid             as ItemID,
      orderuuid          as OrderUUID,
      name               as Name,
      description        as Description,
      releasedate        as ReleaseDate,
      discontinueddate   as DiscontinuedDate,
      price              as Price,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
      height             as Height,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
      width              as Width,
      depth              as Depth,
      quantity           as Quantity,
      unitofmeasure      as UnitOfMeasure,
      // Local ETAg field --> OData Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat as LocalLastChangedAt,
      _Orders
}
