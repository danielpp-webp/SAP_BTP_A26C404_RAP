CLASS zcl_insert_data_0230 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_insert_data_0230 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lt_orderstatus TYPE TABLE OF zorderstatu_0230.

    lt_orderstatus = VALUE #(
        ( language = 'E' orderstatus = '0' text = 'Open' )
        ( language = 'E' orderstatus = '1' text = 'Processing' )
        ( language = 'E' orderstatus = '2' text = 'Shipped' )
        ( language = 'E' orderstatus = '3' text = 'Delivered' )
    ).

    DELETE FROM zorderstatu_0230.
    MODIFY zorderstatu_0230 FROM TABLE @lt_orderstatus.

    IF sy-subrc = 0.
      out->write( 'Data inserted successfully (zorderstatu_0230)' ).
    ELSE.
      out->write( 'Error inserting data (zorderstatu_0230)' ).
    ENDIF.


    DATA lt_orders TYPE TABLE OF zorders_0230.

    TRY.
        lt_orders = VALUE #(

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10001'
            email = 'john.smith@example.com' firstname = 'John' lastname = 'Smith' country = 'US'
            createdon = '20260501' deliverydate = '20260505' orderstatus = 1 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10002'
            email = 'emma.jones@example.com' firstname = 'Emma' lastname = 'Jones' country = 'CA'
            createdon = '20260502' deliverydate = '20260507' orderstatus = 2 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10003'
            email = 'li.wei@example.com' firstname = 'Li' lastname = 'Wei' country = 'CN'
            createdon = '20260503' deliverydate = '20260509' orderstatus = 0 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10004'
            email = 'sofia.garcia@example.com' firstname = 'Sofia' lastname = 'Garcia' country = 'ES'
            createdon = '20260504' deliverydate = '20260510' orderstatus = 3 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10005'
            email = 'michael.brown@example.com' firstname = 'Michael' lastname = 'Brown' country = 'US'
            createdon = '20260505' deliverydate = '20260512' orderstatus = 1 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10006'
            email = 'olivia.martin@example.com' firstname = 'Olivia' lastname = 'Martin' country = 'FR'
            createdon = '20260506' deliverydate = '20260513' orderstatus = 2 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10007'
            email = 'noah.kim@example.com' firstname = 'Noah' lastname = 'Kim' country = 'KR'
            createdon = '20260507' deliverydate = '20260514' orderstatus = 3 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10008'
            email = 'ava.lee@example.com' firstname = 'Ava' lastname = 'Lee' country = 'GB'
            createdon = '20260508' deliverydate = '20260515' orderstatus = 0 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10009'
            email = 'lucas.miller@example.com' firstname = 'Lucas' lastname = 'Miller' country = 'DE'
            createdon = '20260509' deliverydate = '20260516' orderstatus = 1 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10010'
            email = 'mia.davis@example.com' firstname = 'Mia' lastname = 'Davis' country = 'US'
            createdon = '20260510' deliverydate = '20260517' orderstatus = 2 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10011'
            email = 'ethan.wilson@example.com' firstname = 'Ethan' lastname = 'Wilson' country = 'US'
            createdon = '20260511' deliverydate = '20260518' orderstatus = 3 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10012'
            email = 'isabella.moore@example.com' firstname = 'Isabella' lastname = 'Moore' country = 'IT'
            createdon = '20260512' deliverydate = '20260519' orderstatus = 0 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10013'
            email = 'james.taylor@example.com' firstname = 'James' lastname = 'Taylor' country = 'US'
            createdon = '20260513' deliverydate = '20260520' orderstatus = 1 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10014'
            email = 'amelia.anderson@example.com' firstname = 'Amelia' lastname = 'Anderson' country = 'SE'
            createdon = '20260514' deliverydate = '20260521' orderstatus = 2 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10015'
            email = 'benjamin.thomas@example.com' firstname = 'Benjamin' lastname = 'Thomas' country = 'US'
            createdon = '20260515' deliverydate = '20260522' orderstatus = 3 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10016'
            email = 'charlotte.jackson@example.com' firstname = 'Charlotte' lastname = 'Jackson' country = 'AU'
            createdon = '20260516' deliverydate = '20260523' orderstatus = 0 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10017'
            email = 'henry.white@example.com' firstname = 'Henry' lastname = 'White' country = 'US'
            createdon = '20260517' deliverydate = '20260524' orderstatus = 1 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10018'
            email = 'evelyn.harris@example.com' firstname = 'Evelyn' lastname = 'Harris' country = 'FR'
            createdon = '20260518' deliverydate = '20260525' orderstatus = 2 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10019'
            email = 'jack.clark@example.com' firstname = 'Jack' lastname = 'Clark' country = 'US'
            createdon = '20260519' deliverydate = '20260526' orderstatus = 3 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

          ( orderuuid = cl_system_uuid=>create_uuid_x16_static( ) orderid = '10020'
            email = 'harper.robinson@example.com' firstname = 'Harper' lastname = 'Robinson' country = 'GB'
            createdon = '20260520' deliverydate = '20260527' orderstatus = 1 imageurl = 'https://academy.logaligroup.com/pluginfile.php/1/core_admin/logo/0x200/1775826080/logo_logali_academy.png' )

        ).
      CATCH cx_uuid_error.
        out->write( 'Error inserting data (zorders_0230)' ).
        RETURN.
    ENDTRY.

    DELETE FROM zorders_d_0230.
    DELETE FROM zorders_0230.
    MODIFY zorders_0230 FROM TABLE @lt_orders.

    IF sy-subrc = 0.
      out->write( 'Data inserted successfully (zorders_0230)' ).
    ELSE.
      out->write( 'Error inserting data (zorders_0230)' ).
    ENDIF.

    DATA lt_items TYPE TABLE OF zitems_0230.

    TRY.
        lt_items = VALUE #(
          " ============================
          " Order 10001 — 3 items
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10001' ]-orderuuid
            name = 'Laptop' description = '15-inch laptop'
            releasedate = '20250310'
            price = '999.99' height = '2.0' width = '35.0' depth = '25.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '2'
            orderuuid = lt_orders[ orderid = '10001' ]-orderuuid
            name = 'Mouse' description = 'Wireless mouse'
            releasedate = '20250315'
            price = '29.99' height = '4.0' width = '6.0' depth = '3.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '3'
            orderuuid = lt_orders[ orderid = '10001' ]-orderuuid
            name = 'Keyboard' description = 'Mechanical keyboard'
            releasedate = '20250320'
            price = '79.99' height = '3.0' width = '45.0' depth = '15.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10002 — 1 item
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10002' ]-orderuuid
            name = 'Smartphone' description = '6.5-inch display'
            releasedate = '20250401'
            price = '699.00' height = '1.0' width = '15.0' depth = '8.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10003 — 0 items
          " ============================

          " ============================
          " Order 10004 — 5 items
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10004' ]-orderuuid
            name = 'Headphones' description = 'Noise-cancelling'
            releasedate = '20250301'
            price = '199.99' height = '20.0' width = '18.0' depth = '10.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '2'
            orderuuid = lt_orders[ orderid = '10004' ]-orderuuid
            name = 'Charger' description = 'USB-C fast charger'
            releasedate = '20250305'
            price = '39.99' height = '3.0' width = '5.0' depth = '3.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '3'
            orderuuid = lt_orders[ orderid = '10004' ]-orderuuid
            name = 'Cable' description = 'USB-C cable'
            releasedate = '20250306'
            price = '9.99' height = '2.0' width = '10.0' depth = '2.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '4'
            orderuuid = lt_orders[ orderid = '10004' ]-orderuuid
            name = 'Bluetooth Speaker' description = 'Portable speaker'
            releasedate = '20250310'
            price = '59.99' height = '10.0' width = '12.0' depth = '8.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '5'
            orderuuid = lt_orders[ orderid = '10004' ]-orderuuid
            name = 'Webcam' description = '1080p webcam'
            releasedate = '20250312'
            price = '49.99' height = '4.0' width = '8.0' depth = '4.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10005 — 2 items
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10005' ]-orderuuid
            name = 'Tablet' description = '10-inch tablet'
            releasedate = '20250318'
            price = '399.99' height = '1.0' width = '25.0' depth = '17.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '2'
            orderuuid = lt_orders[ orderid = '10005' ]-orderuuid
            name = 'Stylus Pen' description = 'Digital stylus'
            releasedate = '20250320'
            price = '29.99' height = '1.0' width = '14.0' depth = '1.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10006 — 4 items
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10006' ]-orderuuid
            name = 'Monitor' description = '27-inch monitor'
            releasedate = '20250301'
            price = '249.99' height = '40.0' width = '60.0' depth = '20.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '2'
            orderuuid = lt_orders[ orderid = '10006' ]-orderuuid
            name = 'HDMI Cable' description = '2m HDMI cable'
            releasedate = '20250302'
            price = '14.99' height = '2.0' width = '10.0' depth = '2.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '3'
            orderuuid = lt_orders[ orderid = '10006' ]-orderuuid
            name = 'Desk Lamp' description = 'LED lamp'
            releasedate = '20250305'
            price = '24.99' height = '30.0' width = '12.0' depth = '12.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '4'
            orderuuid = lt_orders[ orderid = '10006' ]-orderuuid
            name = 'USB Hub' description = '4-port USB hub'
            releasedate = '20250308'
            price = '19.99' height = '3.0' width = '10.0' depth = '5.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10007 — 0 items
          " ============================

          " ============================
          " Order 10008 — 3 items
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10008' ]-orderuuid
            name = 'Router' description = 'WiFi 6 router'
            releasedate = '20250301'
            price = '129.99' height = '5.0' width = '20.0' depth = '15.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '2'
            orderuuid = lt_orders[ orderid = '10008' ]-orderuuid
            name = 'Ethernet Cable' description = '5m cable'
            releasedate = '20250302'
            price = '9.99' height = '2.0' width = '10.0' depth = '2.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '3'
            orderuuid = lt_orders[ orderid = '10008' ]-orderuuid
            name = 'Network Switch' description = '5-port switch'
            releasedate = '20250305'
            price = '39.99' height = '3.0' width = '12.0' depth = '8.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10009 — 5 items
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10009' ]-orderuuid
            name = 'Camera' description = 'Digital camera'
            releasedate = '20250301'
            price = '499.99' height = '10.0' width = '15.0' depth = '10.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '2'
            orderuuid = lt_orders[ orderid = '10009' ]-orderuuid
            name = 'Tripod' description = 'Aluminum tripod'
            releasedate = '20250303'
            price = '59.99' height = '50.0' width = '10.0' depth = '10.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '3'
            orderuuid = lt_orders[ orderid = '10009' ]-orderuuid
            name = 'SD Card' description = '128GB SD card'
            releasedate = '20250304'
            price = '19.99' height = '1.0' width = '2.0' depth = '1.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '4'
            orderuuid = lt_orders[ orderid = '10009' ]-orderuuid
            name = 'Camera Bag' description = 'Protective bag'
            releasedate = '20250306'
            price = '39.99' height = '20.0' width = '30.0' depth = '15.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '5'
            orderuuid = lt_orders[ orderid = '10009' ]-orderuuid
            name = 'Lens' description = '50mm lens'
            releasedate = '20250308'
            price = '249.99' height = '8.0' width = '8.0' depth = '8.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10010 — 2 items
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10010' ]-orderuuid
            name = 'Printer' description = 'Laser printer'
            releasedate = '20250301'
            price = '199.99' height = '25.0' width = '40.0' depth = '30.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '2'
            orderuuid = lt_orders[ orderid = '10010' ]-orderuuid
            name = 'Ink Cartridge' description = 'Black cartridge'
            releasedate = '20250302'
            price = '29.99' height = '5.0' width = '10.0' depth = '5.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10011 — 0 items
          " ============================

          " ============================
          " Order 10012 — 4 items
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10012' ]-orderuuid
            name = 'TV' description = '55-inch 4K TV'
            releasedate = '20250301'
            price = '799.99' height = '70.0' width = '120.0' depth = '20.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '2'
            orderuuid = lt_orders[ orderid = '10012' ]-orderuuid
            name = 'Remote Control' description = 'Universal remote'
            releasedate = '20250302'
            price = '19.99' height = '2.0' width = '20.0' depth = '3.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '3'
            orderuuid = lt_orders[ orderid = '10012' ]-orderuuid
            name = 'HDMI Cable' description = '4K HDMI cable'
            releasedate = '20250303'
            price = '14.99' height = '2.0' width = '10.0' depth = '2.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '4'
            orderuuid = lt_orders[ orderid = '10012' ]-orderuuid
            name = 'Wall Mount' description = 'TV wall mount'
            releasedate = '20250305'
            price = '49.99' height = '5.0' width = '40.0' depth = '5.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10013 — 1 item
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10013' ]-orderuuid
            name = 'Smartwatch' description = 'Fitness smartwatch'
            releasedate = '20250301'
            price = '199.99' height = '2.0' width = '4.0' depth = '1.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10014 — 5 items
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10014' ]-orderuuid
            name = 'Gaming Console' description = 'Next-gen console'
            releasedate = '20250301'
            price = '499.99' height = '10.0' width = '30.0' depth = '20.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '2'
            orderuuid = lt_orders[ orderid = '10014' ]-orderuuid
            name = 'Controller' description = 'Wireless controller'
            releasedate = '20250302'
            price = '59.99' height = '5.0' width = '15.0' depth = '10.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '3'
            orderuuid = lt_orders[ orderid = '10014' ]-orderuuid
            name = 'Game Disc' description = 'Action game'
            releasedate = '20250303'
            price = '69.99' height = '1.0' width = '14.0' depth = '14.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '4'
            orderuuid = lt_orders[ orderid = '10014' ]-orderuuid
            name = 'Charging Dock' description = 'Console charging dock'
            releasedate = '20250305'
            price = '39.99' height = '5.0' width = '20.0' depth = '10.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '5'
            orderuuid = lt_orders[ orderid = '10014' ]-orderuuid
            name = 'Headset' description = 'Gaming headset'
            releasedate = '20250307'
            price = '89.99' height = '20.0' width = '18.0' depth = '10.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10015 — 3 items
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10015' ]-orderuuid
            name = 'Drone' description = 'Quadcopter drone'
            releasedate = '20250301'
            price = '299.99' height = '10.0' width = '30.0' depth = '30.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '2'
            orderuuid = lt_orders[ orderid = '10015' ]-orderuuid
            name = 'Drone Battery' description = 'Spare battery'
            releasedate = '20250302'
            price = '49.99' height = '3.0' width = '10.0' depth = '5.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '3'
            orderuuid = lt_orders[ orderid = '10015' ]-orderuuid
            name = 'Propeller Set' description = 'Replacement propellers'
            releasedate = '20250303'
            price = '19.99' height = '2.0' width = '15.0' depth = '2.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10016 — 0 items
          " ============================

          " ============================
          " Order 10017 — 4 items
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10017' ]-orderuuid
            name = 'Coffee Maker' description = 'Automatic coffee machine'
            releasedate = '20250301'
            price = '149.99' height = '30.0' width = '20.0' depth = '25.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '2'
            orderuuid = lt_orders[ orderid = '10017' ]-orderuuid
            name = 'Coffee Beans' description = '1kg premium beans'
            releasedate = '20250302'
            price = '24.99' height = '20.0' width = '10.0' depth = '10.0'
            quantity = '1' unitofmeasure = 'KG' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '3'
            orderuuid = lt_orders[ orderid = '10017' ]-orderuuid
            name = 'Milk Frother' description = 'Electric frother'
            releasedate = '20250303'
            price = '29.99' height = '15.0' width = '8.0' depth = '8.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '4'
            orderuuid = lt_orders[ orderid = '10017' ]-orderuuid
            name = 'Coffee Filters' description = 'Pack of 100'
            releasedate = '20250304'
            price = '9.99' height = '5.0' width = '15.0' depth = '5.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10018 — 2 items
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10018' ]-orderuuid
            name = 'Air Purifier' description = 'HEPA air purifier'
            releasedate = '20250301'
            price = '199.99' height = '40.0' width = '25.0' depth = '25.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '2'
            orderuuid = lt_orders[ orderid = '10018' ]-orderuuid
            name = 'Filter Pack' description = 'Replacement filters'
            releasedate = '20250302'
            price = '39.99' height = '5.0' width = '20.0' depth = '5.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10019 — 5 items
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10019' ]-orderuuid
            name = 'Vacuum Cleaner' description = 'Bagless vacuum'
            releasedate = '20250301'
            price = '149.99' height = '80.0' width = '30.0' depth = '30.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '2'
            orderuuid = lt_orders[ orderid = '10019' ]-orderuuid
            name = 'Dust Bags' description = 'Pack of 5'
            releasedate = '20250302'
            price = '14.99' height = '10.0' width = '20.0' depth = '5.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '3'
            orderuuid = lt_orders[ orderid = '10019' ]-orderuuid
            name = 'Brush Roll' description = 'Replacement brush'
            releasedate = '20250303'
            price = '19.99' height = '5.0' width = '25.0' depth = '5.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '4'
            orderuuid = lt_orders[ orderid = '10019' ]-orderuuid
            name = 'Crevice Tool' description = 'Vacuum accessory'
            releasedate = '20250304'
            price = '9.99' height = '3.0' width = '20.0' depth = '3.0'
            quantity = '1' unitofmeasure = 'EA' )

          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '5'
            orderuuid = lt_orders[ orderid = '10019' ]-orderuuid
            name = 'HEPA Filter' description = 'Replacement filter'
            releasedate = '20250305'
            price = '24.99' height = '5.0' width = '15.0' depth = '5.0'
            quantity = '1' unitofmeasure = 'EA' )

          " ============================
          " Order 10020 — 1 item
          " ============================
          ( itemuuid = cl_system_uuid=>create_uuid_x16_static( ) itemid = '1'
            orderuuid = lt_orders[ orderid = '10020' ]-orderuuid
            name = 'Smart Light' description = 'WiFi smart bulb'
            releasedate = '20250301'
            price = '14.99' height = '10.0' width = '6.0' depth = '6.0'
            quantity = '1' unitofmeasure = 'EA' )

        ).
      CATCH cx_uuid_error.
        out->write( 'Error inserting data (zitems_0230)' ).
        RETURN.
    ENDTRY.

    DELETE FROM zitems_d_0230.
    DELETE FROM zitems_0230.
    MODIFY zitems_0230 FROM TABLE @lt_items.

    IF sy-subrc = 0.
      out->write( 'Data inserted successfully (zitems_d_0230)' ).
    ELSE.
      out->write( 'Error inserting data (zitems_d_0230)' ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
