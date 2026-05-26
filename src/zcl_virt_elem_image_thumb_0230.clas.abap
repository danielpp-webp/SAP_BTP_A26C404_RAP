CLASS zcl_virt_elem_image_thumb_0230 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_virt_elem_image_thumb_0230 IMPLEMENTATION.

  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA lt_original_data TYPE TABLE OF zORDERS_c_0230 WITH DEFAULT KEY.

    lt_original_data = CORRESPONDING #( it_original_data ).

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
      <fs_original_data>-ImageThumb = <fs_original_data>-ImageURL.
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_original_data ).
  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
    CASE iv_entity.
      WHEN 'ZORDERS_C_0230'.
        LOOP AT it_requested_calc_elements INTO DATA(ls_calc_elem).
          IF ls_calc_elem = 'IMAGETHUMB'.
            APPEND 'IMAGEURL' TO et_requested_orig_elements.
          ENDIF.
        ENDLOOP.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
