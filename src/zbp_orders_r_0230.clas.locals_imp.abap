CLASS lhc_Orders DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      ac_message_class            TYPE c LENGTH 20 VALUE 'ZMC_SALESORDERS_0230',
      ac_id_state_area            TYPE c LENGTH 12 VALUE 'VALIDATE_ID',
      ac_email_state_area         TYPE c LENGTH 14 VALUE 'VALIDATE_EMAIL',
      ac_delivery_date_state_area TYPE c LENGTH 22 VALUE 'VALIDATE_DELIVERY_DATE'.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Orders RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Orders RESULT result.

    METHODS setInitData FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Orders~setInitData.

    METHODS setEmailToLower FOR DETERMINE ON SAVE
      IMPORTING keys FOR Orders~setEmailToLower.

    METHODS validateID FOR VALIDATE ON SAVE
      IMPORTING keys FOR Orders~validateID.

    METHODS validateEmail FOR VALIDATE ON SAVE
      IMPORTING keys FOR Orders~validateEmail.

    METHODS validateDeliveryDate FOR VALIDATE ON SAVE
      IMPORTING keys FOR Orders~validateDeliveryDate.

ENDCLASS.

CLASS lhc_Orders IMPLEMENTATION.

  METHOD get_global_authorizations.
    " Allow only for my user
*    DATA(lv_auth) = SWITCH #( cl_abap_context_info=>get_user_technical_name( )
*                        WHEN 'CB9980000230' THEN if_abap_behv=>auth-allowed
*                        ELSE if_abap_behv=>auth-unauthorized ).
    DATA(lv_auth) = if_abap_behv=>auth-allowed.

    result-%create = lv_auth.
    result-%update = lv_auth.
    result-%delete = lv_auth.
  ENDMETHOD.

  METHOD get_instance_features.
    TYPES:
      BEGIN OF order_uuid,
        order_uuid TYPE sysuuid_x16,
      END OF order_uuid.

    DATA:
      lr_order_uuid  TYPE RANGE OF sysuuid_x16,
      ht_order_uuids TYPE HASHED TABLE OF order_uuid WITH UNIQUE KEY order_uuid.

    READ ENTITIES OF zorders_r_0230 IN LOCAL MODE
        ENTITY Orders
        FIELDS ( OrderUUID OrderStatus )
        WITH CORRESPONDING #( keys )
        RESULT DATA(orders).

    lr_order_uuid = VALUE #( FOR lw_order IN orders
                    ( sign = 'I' option = 'EQ' low = lw_order-OrderUUID ) ).

    " Validate if order is being created
    SELECT DISTINCT
            OrderUUID
        FROM zorders_0230
        WHERE orderuuid IN @lr_order_uuid
        INTO TABLE @ht_order_uuids.

    result = VALUE #( FOR order IN orders
*                      " Disable editing when the order is Delivered
*                      LET lv_op_ctrl = SWITCH #( order-OrderStatus
*                                           WHEN '3' THEN if_abap_behv=>fc-o-disabled " 3 -> Delivered
*                                           ELSE if_abap_behv=>fc-o-enabled )
                      " Disable OrderStatus field when the order is being created
                      LET lv_field_ctrl = COND #( WHEN NOT line_exists( ht_order_uuids[ order_uuid = order-OrderUUID ] ) THEN if_abap_behv=>fc-f-read_only
                                        ELSE if_abap_behv=>fc-f-unrestricted )
*                      IN %update            = lv_op_ctrl
*                         %action-Edit       = lv_op_ctrl
                      IN  %field-OrderStatus = lv_field_ctrl
                      ( %tky = order-%tky ) ).
  ENDMETHOD.

  METHOD setInitData.
    READ ENTITIES OF zorders_r_0230 IN LOCAL MODE
        ENTITY Orders
        FIELDS ( OrderID CreatedOn OrderStatus )
        WITH CORRESPONDING #( keys )
        RESULT DATA(orders).

    DELETE orders WHERE OrderID IS NOT INITIAL.

    CHECK orders IS NOT INITIAL.

    " Fetch max existing ID
    " Query table ZORDERS_0230
    SELECT MAX( CAST( orderid AS INT4 ) )
        FROM zorders_0230
        INTO @DATA(lv_persisted_max_id).

    " Query table ZORDERS_D_0230
    SELECT MAX( CAST( orderid AS INT4 ) )
        FROM zorders_d_0230
        INTO @DATA(lv_draft_max_id).

    DATA(lv_next_id) = nmax( val1 = lv_persisted_max_id val2 = lv_draft_max_id ).

    MODIFY ENTITIES OF zorders_r_0230 IN LOCAL MODE
        ENTITY Orders
        UPDATE FIELDS ( OrderID CreatedOn OrderStatus )
        WITH VALUE #( FOR order IN orders INDEX INTO lv_index
                      ( %tky = order-%tky
                        " Set ID
                        OrderID = CONV zde_id_0230( |{ lv_next_id + lv_index }| )
                        " Set current date
                        CreatedOn = cl_abap_context_info=>get_system_date( )
                        " Set initial status 0 -> Open
                        OrderStatus = 0 ) ).
  ENDMETHOD.

  METHOD setEmailToLower.
    READ ENTITIES OF zorders_r_0230 IN LOCAL MODE
        ENTITY Orders
        FIELDS ( Email )
        WITH CORRESPONDING #( keys )
        RESULT DATA(orders).

    DATA lt_updates TYPE TABLE FOR UPDATE zorders_r_0230.

    LOOP AT orders INTO DATA(order).
      DATA(lv_email) = to_lower( order-Email ).

      " Only update if different -> prevents infinite loop
      IF order-Email NE lv_email.
        APPEND VALUE #(
          %tky  = order-%tky
          Email = lv_email " Set lower case email
        ) TO lt_updates.
      ENDIF.
    ENDLOOP.

    " Apply updates
    IF lt_updates IS NOT INITIAL.
      MODIFY ENTITIES OF zorders_r_0230 IN LOCAL MODE
        ENTITY Orders
        UPDATE FIELDS ( Email )
        WITH lt_updates.
    ENDIF.
  ENDMETHOD.

  METHOD validateID.
    READ ENTITIES OF zorders_r_0230 IN LOCAL MODE
        ENTITY Orders
        FIELDS ( OrderID )
        WITH CORRESPONDING #( keys )
        RESULT DATA(orders).

    CHECK orders IS NOT INITIAL.

    TYPES:
      BEGIN OF order_id,
        order_id TYPE zde_id_0230,
      END OF order_id.

    DATA:
      lr_order_id   TYPE RANGE OF zde_id_0230,
      lr_order_uuid TYPE RANGE OF sysuuid_x16,
      ht_order_ids  TYPE HASHED TABLE OF order_id WITH UNIQUE KEY order_id.

    lr_order_id = VALUE #( FOR lw_order IN orders
              ( sign = 'I' option = 'EQ' low = to_upper( lw_order-OrderID ) ) ).

    lr_order_uuid = VALUE #( FOR lw_order IN orders
              ( sign = 'I' option = 'EQ' low = lw_order-OrderUUID ) ).

    " Fetch already registered IDs
    " Query table ZORDERS_0230
    SELECT DISTINCT upper( orderid )
        FROM zorders_0230
        WHERE upper( orderid ) IN @lr_order_id
            AND orderuuid NOT IN @lr_order_uuid " Exclude self
        INTO TABLE @ht_order_ids.

    LOOP AT orders INTO DATA(order).
      DATA(lv_ORDER_ID) = to_upper( order-OrderID ).

      " Reset messages
      APPEND VALUE #( %tky = order-%tky
                      %state_area = ac_ID_state_area ) TO reported-Orders.

      " Validate OrderID is not empty
      IF lv_ORDER_ID IS INITIAL.
        APPEND VALUE #( %tky = order-%tky ) TO failed-Orders.
        APPEND VALUE #( %tky = order-%tky
                        %state_area = ac_ID_state_area
                        %msg = new_message( id = ac_message_class number = 006 severity = if_abap_behv_message=>severity-error )
                        %element-OrderID = if_abap_behv=>mk-on ) TO reported-Orders.
        CONTINUE.
      ENDIF.

      " Validate OrderID is not already registered
      IF line_exists( ht_order_ids[ order_id = lv_ORDER_ID ] ).
        APPEND VALUE #( %tky = order-%tky ) TO failed-Orders.
        APPEND VALUE #( %tky = order-%tky
                        %state_area = ac_ID_state_area
                        %msg = new_message( id = ac_message_class number = 007 severity = if_abap_behv_message=>severity-error )
                        %element-OrderID = if_abap_behv=>mk-on ) TO reported-Orders.
*        CONTINUE.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD validateEmail.
    READ ENTITIES OF zorders_r_0230 IN LOCAL MODE
      ENTITY Orders
      FIELDS ( Email )
      WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    CHECK orders IS NOT INITIAL.

    TYPES:
      BEGIN OF order_email,
        email TYPE zde_email_0230,
      END OF order_email.

    DATA:
      lr_email        TYPE RANGE OF zde_email_0230,
      lr_order_uuid   TYPE RANGE OF sysuuid_x16,
      ht_orders_email TYPE HASHED TABLE OF order_email WITH UNIQUE KEY email,
      lv_pcre         TYPE string.

    lr_email = VALUE #( FOR lw_order IN orders
                            ( sign = 'I' option = 'EQ' low = to_lower( lw_order-Email ) ) ).

    lr_order_uuid = VALUE #( FOR lw_order IN orders
                         ( sign = 'I' option = 'EQ' low = lw_order-OrderUUID ) ).

    " Fetch already registered emails
    " Query table ZORDERS_0230
    SELECT DISTINCT lower( email )
        FROM zorders_0230
        WHERE lower( email ) IN @lr_email
            AND orderuuid NOT IN @lr_order_uuid " Exclude self
        INTO TABLE @ht_orders_email.

    lv_pcre = `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$`.

    LOOP AT orders INTO DATA(order).
      DATA(lv_email) = to_lower( order-Email ).

      " Reset messages
      APPEND VALUE #( %tky = order-%tky
                      %state_area = ac_email_state_area ) TO reported-Orders.

      " Validate email is not empty
      IF lv_email IS INITIAL.
        APPEND VALUE #( %tky = order-%tky ) TO failed-Orders.
        APPEND VALUE #( %tky = order-%tky
                        %state_area = ac_email_state_area
                        %msg = new_message( id = ac_message_class number = 001 severity = if_abap_behv_message=>severity-error )
                        %element-Email = if_abap_behv=>mk-on ) TO reported-Orders.
        CONTINUE.
      ENDIF.

      " Validate email is not already registered
      IF line_exists( ht_orders_email[ email = lv_email ] ).
        APPEND VALUE #( %tky = order-%tky ) TO failed-Orders.
        APPEND VALUE #( %tky = order-%tky
                        %state_area = ac_email_state_area
                        %msg = new_message( id = ac_message_class number = 002 severity = if_abap_behv_message=>severity-error )
                        %element-Email = if_abap_behv=>mk-on ) TO reported-Orders.
        CONTINUE.
      ENDIF.

      " Validate email format
      IF NOT matches( val = lv_email pcre = lv_pcre ).
        APPEND VALUE #( %tky = order-%tky ) TO failed-Orders.
        APPEND VALUE #( %tky = order-%tky
                        %state_area = ac_email_state_area
                        %msg = new_message( id = ac_message_class number = 003 severity = if_abap_behv_message=>severity-error )
                        %element-Email = if_abap_behv=>mk-on ) TO reported-Orders.
*        CONTINUE.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDeliveryDate.
    READ ENTITIES OF zorders_r_0230 IN LOCAL MODE
        ENTITY Orders
        FIELDS ( DeliveryDate CreatedOn )
        WITH CORRESPONDING #( keys )
        RESULT DATA(orders).

    LOOP AT orders INTO DATA(order).
      " Reset messages
      APPEND VALUE #( %tky = order-%tky
                  %state_area = ac_delivery_date_state_area ) TO reported-Orders.

      " Validate only if date is not initial
      IF order-DeliveryDate IS NOT INITIAL.
        " Validate delivery date doesn't precede the creation date
        IF order-DeliveryDate < order-CreatedOn.
          APPEND VALUE #( %tky = order-%tky ) TO failed-Orders.
          APPEND VALUE #( %tky = order-%tky
                          %state_area = ac_delivery_date_state_area
                          %msg = new_message( id = ac_message_class number = 004 severity = if_abap_behv_message=>severity-error )
                          %element-DeliveryDate = if_abap_behv=>mk-on ) TO reported-Orders.
*          CONTINUE.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
