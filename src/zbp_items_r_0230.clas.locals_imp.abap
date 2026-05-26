CLASS lhc_items DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    CONSTANTS:
      ac_message_class        TYPE c LENGTH 20 VALUE 'ZMC_SALESORDERS_0230',
      ac_id_state_area        TYPE c LENGTH 12 VALUE 'VALIDATE_ID',
      ac_disc_date_state_area TYPE c LENGTH 26 VALUE 'VALIDATE_DISCONTINUED_DATE'.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Items RESULT result.

    METHODS setItemID FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Items~setItemID.

    METHODS validateID FOR VALIDATE ON SAVE
      IMPORTING keys FOR Items~validateID.

    METHODS validateDiscontinuedDate FOR VALIDATE ON SAVE
      IMPORTING keys FOR Items~validateDiscontinuedDate.

ENDCLASS.

CLASS lhc_items IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD setItemID.
    READ ENTITIES OF zorders_r_0230 IN LOCAL MODE
        ENTITY Items
        FIELDS ( OrderUUID ItemID )
        WITH CORRESPONDING #( keys )
        RESULT DATA(items).

    DELETE items WHERE ItemID IS NOT INITIAL.

    CHECK items IS NOT INITIAL.

    TYPES:
      BEGIN OF max_id,
        order_uuid TYPE sysuuid_x16,
        max_id     TYPE int4,
      END OF max_id.

    DATA:
      lt_updates           TYPE TABLE FOR UPDATE zitems_r_0230,
      lr_order_uuid        TYPE RANGE OF sysuuid_x16,
      ht_persisted_max_ids TYPE HASHED TABLE OF max_id WITH UNIQUE KEY order_uuid,
      ht_draft_max_ids     TYPE HASHED TABLE OF max_id WITH UNIQUE KEY order_uuid.

    lr_order_uuid = VALUE #( FOR lw_item IN items
                            ( sign = 'I' option = 'EQ' low = lw_item-OrderUUID ) ).

    " Fetch max existing item ID of each order
    " Query table ZORDERS_0230
    SELECT orderuuid, MAX( CAST( itemid AS INT4 ) ) AS max_id
        FROM zitems_0230
        WHERE orderuuid IN @lr_order_uuid
        GROUP BY orderuuid
        INTO TABLE @ht_persisted_max_ids.

    " Query table ZORDERS_D_0230
    SELECT orderuuid, MAX( CAST( itemid AS INT4 ) ) AS max_id
        FROM zitems_d_0230
        WHERE orderuuid IN @lr_order_uuid
        GROUP BY orderuuid
        INTO TABLE @ht_draft_max_ids.

    LOOP AT items INTO DATA(item)
        GROUP BY item-%data-OrderUUID INTO DATA(order_uuid).

      " Get the max existing item ID for this order
      DATA(lv_persisted_max_id) = VALUE #( ht_persisted_max_ids[ order_uuid = order_uuid ]-max_id
                        DEFAULT VALUE #( ) ).
      DATA(lv_DRAFT_max_id) = VALUE #( ht_draft_max_ids[ order_uuid = order_uuid ]-max_id
                        DEFAULT VALUE #( ) ).
      DATA(lv_NEXT_id) = nmax( val1 = lv_persisted_max_id val2 = lv_draft_max_id ).

      DATA(lv_index) = 0.

      " Loop items inside this group
      LOOP AT GROUP order_uuid INTO DATA(order_item).
        lv_index += 1.

        APPEND VALUE #(
          %tky   = order_item-%tky
          ItemID = CONV zde_id_0230( |{ lv_NEXT_id + lv_index }| )
        ) TO lt_updates.
      ENDLOOP.
    ENDLOOP.

    " Apply updates
    IF lt_updates IS NOT INITIAL.
      MODIFY ENTITIES OF zorders_r_0230 IN LOCAL MODE
        ENTITY Items
        UPDATE FIELDS ( ItemID )
        WITH lt_updates.
    ENDIF.
  ENDMETHOD.

  METHOD validateID.
    READ ENTITIES OF zorders_r_0230 IN LOCAL MODE
    ENTITY Items
    FIELDS ( OrderUUID ItemUUID ItemID )
    WITH CORRESPONDING #( keys )
    RESULT DATA(items).

    READ ENTITIES OF zorders_r_0230 IN LOCAL MODE
        ENTITY Items BY \_Orders
        FROM CORRESPONDING #( items )
        LINK DATA(orders_items).
    CHECK items IS NOT INITIAL.

    TYPES:
      BEGIN OF item_id,
        order_uuid TYPE sysuuid_x16,
        item_id    TYPE zde_id_0230,
      END OF item_id.

    DATA:
      lr_order_uuid TYPE RANGE OF sysuuid_x16,
      lr_item_uuid  TYPE RANGE OF sysuuid_x16,
      ht_items_id   TYPE HASHED TABLE OF item_id WITH UNIQUE KEY order_uuid item_id.

    lr_order_uuid = VALUE #( FOR lw_item IN items
                            ( sign = 'I' option = 'EQ' low = lw_item-OrderUUID ) ).
    lr_item_uuid = VALUE #( FOR lw_item IN items
                            ( sign = 'I' option = 'EQ' low = lw_item-ItemUUID ) ).

    " Fetch already registered IDs of each order
    " Query table ZITEMS_0230
    SELECT DISTINCT
            OrderUUID, upper( itemID )
        FROM zitems_0230
        WHERE orderuuid IN @lr_order_uuid
            AND itemuuid NOT IN @lr_item_uuid " Exclude self
        INTO TABLE @ht_items_id.

    LOOP AT items INTO DATA(item)
        GROUP BY item-OrderUUID INTO DATA(order_uuid).

      DATA(lt_seen) = VALUE string_table( ).

      LOOP AT GROUP order_uuid INTO DATA(order_item).

        DATA(lv_item_ID) = to_upper( order_item-ItemID ).

        " Reset messages
        APPEND VALUE #( %tky = order_item-%tky
                        %state_area = ac_ID_state_area ) TO reported-Items.

        " Validate itemID is not empty
        IF lv_item_ID IS INITIAL.
          APPEND VALUE #( %tky = order_item-%tky ) TO failed-Items.
          APPEND VALUE #( %tky = order_item-%tky
                            %path = VALUE #( Orders-%tky = orders_items[ KEY id source-%tky = order_item-%tky ]-target-%tky )
                            %state_area = ac_ID_state_area
                            %msg = new_message( id = ac_message_class number = 006 severity = if_abap_behv_message=>severity-error )
                            %element-ItemID = if_abap_behv=>mk-on ) TO reported-Items.
          CONTINUE.
        ENDIF.

        " Validate ItemID is not already registered
        IF line_exists( ht_items_id[ order_uuid = order_item-OrderUUID item_id = lv_item_ID ] ).
          APPEND VALUE #( %tky = order_item-%tky ) TO failed-Items.
          APPEND VALUE #( %tky = order_item-%tky
                            %path = VALUE #( Orders-%tky = orders_items[ KEY id source-%tky = order_item-%tky ]-target-%tky )
                            %state_area = ac_ID_state_area
                            %msg = new_message( id = ac_message_class number = 007 severity = if_abap_behv_message=>severity-error )
                            %element-ItemID = if_abap_behv=>mk-on ) TO reported-Items.
*          CONTINUE.
        ENDIF.

        " Validate there are not repeated elements on the initial array
        IF line_exists( lt_seen[ table_line = lv_item_ID ] ).
          " Duplicate found
          APPEND VALUE #( %tky = order_item-%tky ) TO failed-Items.
          APPEND VALUE #( %tky = order_item-%tky
                            %path = VALUE #( Orders-%tky = orders_items[ KEY id source-%tky = order_item-%tky ]-target-%tky )
                            %state_area = ac_ID_state_area
                            %msg = new_message( id = ac_message_class number = 008 severity = if_abap_behv_message=>severity-error )
                            %element-ItemID = if_abap_behv=>mk-on ) TO reported-Items.
*          CONTINUE.
        ELSE.
          APPEND lv_item_ID TO lt_seen.
        ENDIF.
      ENDLOOP.

      CLEAR lt_seen.
    ENDLOOP.

  ENDMETHOD.

  METHOD validateDiscontinuedDate.
    READ ENTITIES OF zorders_r_0230 IN LOCAL MODE
        ENTITY Items
        FIELDS ( ReleaseDate DiscontinuedDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(items).

    READ ENTITIES OF zorders_r_0230 IN LOCAL MODE
        ENTITY Items BY \_Orders
        FROM CORRESPONDING #( items )
        LINK DATA(orders_items).

    LOOP AT items INTO DATA(item).
      " Reset messages
      APPEND VALUE #( %tky = item-%tky
                      %state_area = ac_disc_date_state_area ) TO reported-Items.

      " Validate only if date is not initial
      IF item-DiscontinuedDate IS NOT INITIAL.
        " Validate discontinued date doesn't precede the release date
        IF item-DiscontinuedDate < item-ReleaseDate.
          APPEND VALUE #( %tky = item-%tky ) TO failed-Items.
          APPEND VALUE #( %tky = item-%tky
                          %path = VALUE #( Orders-%tky = orders_items[ KEY id source-%tky = item-%tky ]-target-%tky )
                          %state_area = ac_disc_date_state_area
                          %msg = new_message( id = ac_message_class number = 005 severity = if_abap_behv_message=>severity-error )
                          %element-DiscontinuedDate = if_abap_behv=>mk-on ) TO reported-Items.
*         CONTINUE.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

