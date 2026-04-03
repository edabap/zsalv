CLASS zcl_salv_columns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    CLASS-METHODS class_constructor.
    CLASS-METHODS initialize
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS set_column
      IMPORTING
        !iv_columnname TYPE lvc_fname
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS editable
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS as_hotspot
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS as_text
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS as_dropdown
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS as_link
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS as_checkbox
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS as_button
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS subtotal
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS fix
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS hide
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS icon
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS exception
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS long_text
      IMPORTING
        !i_text TYPE scrtext_l
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS medium_text
      IMPORTING
        !i_text TYPE scrtext_m
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS short_text
      IMPORTING
        !i_text TYPE scrtext_s
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS length
      IMPORTING
        !i_length TYPE lvc_outlen
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS color
      IMPORTING
        !i_color TYPE lvc_s_colo
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS group
      IMPORTING
        !i_group TYPE lvc_spgrp
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS tooltip
      IMPORTING
        !i_tooltip TYPE lvc_tip
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS entry_column
      IMPORTING
        !i_entry TYPE lvc_fname
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS exception_group
      IMPORTING
        !i_group TYPE char1
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS f4_reference
      IMPORTING
        !i_field TYPE lvc_fname
        !i_table TYPE lvc_tname
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS no_f4
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS f4
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS receive
      RETURNING
        VALUE(rt_columns) TYPE zsalv_tt_column.
    METHODS optimize
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.
    METHODS column_position
      IMPORTING
        !iv_position TYPE lvc_colpos
      RETURNING
        VALUE(ro_columns) TYPE REF TO zcl_salv_columns.

  PROTECTED SECTION.

  PRIVATE SECTION.

    CLASS-DATA mt_data       TYPE zsalv_tt_column.
    CLASS-DATA mv_columnname TYPE lvc_fname.
    CLASS-DATA mo_columns    TYPE REF TO zcl_salv_columns.

ENDCLASS.



CLASS zcl_salv_columns IMPLEMENTATION.


  METHOD as_button.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-type = if_salv_c_cell_type=>button.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD as_checkbox.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-type = if_salv_c_cell_type=>checkbox.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD as_dropdown.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-type = if_salv_c_cell_type=>dropdown.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD as_hotspot.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-type = if_salv_c_cell_type=>hotspot.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD as_link.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-type = if_salv_c_cell_type=>link.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD as_text.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-type = if_salv_c_cell_type=>text.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD class_constructor.

    CREATE OBJECT mo_columns.

  ENDMETHOD.


  METHOD color.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-color = i_color.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD column_position.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-column_position = iv_position.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD editable.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-edit = if_salv_c_bool_sap=>true.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD entry_column.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-entry_column = i_entry.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD exception.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-exception = if_salv_c_bool_sap=>true.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD exception_group.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-exception_group = i_group.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD f4.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-f4 = if_salv_c_bool_sap=>true.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD f4_reference.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      ASSIGN <ls_data>-f4_reference TO FIELD-SYMBOL(<ls_reference>).
      <ls_reference>-field = i_field.
      <ls_reference>-table = i_table.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD fix.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-fix = if_salv_c_bool_sap=>true.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD group.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-specific_group = i_group.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD hide.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-hide = if_salv_c_bool_sap=>true.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD icon.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-icon = if_salv_c_bool_sap=>true.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD initialize.

    ro_columns = mo_columns.
    CLEAR: mt_data, mv_columnname.

  ENDMETHOD.


  METHOD length.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-output_length = i_length.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD long_text.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-long_text = i_text.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD medium_text.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-medium_text = i_text.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD no_f4.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-no_f4 = if_salv_c_bool_sap=>true.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD optimize.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-optimize = if_salv_c_bool_sap=>true.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD receive.

    rt_columns = mt_data.

  ENDMETHOD.


  METHOD set_column.

    CHECK iv_columnname IS NOT INITIAL.

    mv_columnname = iv_columnname.

    IF NOT line_exists( mt_data[ columnname = iv_columnname ] ).
      APPEND INITIAL LINE TO mt_data ASSIGNING FIELD-SYMBOL(<ls_data>).
      <ls_data>-columnname = iv_columnname.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD short_text.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-short_text = i_text.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD subtotal.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-subtotal = if_salv_c_bool_sap=>true.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


  METHOD tooltip.

    CHECK mv_columnname IS NOT INITIAL.

    READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data>) WITH KEY columnname = mv_columnname.
    IF sy-subrc = 0.
      <ls_data>-tooltip = i_tooltip.
    ENDIF.

    ro_columns = me.

  ENDMETHOD.


ENDCLASS.
