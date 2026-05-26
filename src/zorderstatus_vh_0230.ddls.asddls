@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help - Order status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZORDERSTATUS_VH_0230
  as select from zorderstatu_0230
{
      @ObjectModel.text.element: ['Text']
      @UI.hidden: true
  key orderstatus as Orderstatus,
      @Semantics.language: true
      @UI.hidden: true
  key language    as Language,
      @Semantics.text: true
      text        as Text
}
