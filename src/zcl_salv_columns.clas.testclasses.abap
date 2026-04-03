CLASS ltc_salv_columns DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA mo_cut TYPE REF TO zcl_salv_columns.

    METHODS setup.
    METHODS builds_column_metadata FOR TESTING.
    METHODS keeps_single_entry_per_column FOR TESTING.

ENDCLASS.



CLASS ltc_salv_columns IMPLEMENTATION.


  METHOD setup.

    mo_cut = zcl_salv_columns=>initialize( ).

  ENDMETHOD.


  METHOD builds_column_metadata.
    DATA lt_columns TYPE zsalv_tt_column.

    mo_cut->set_column( iv_columnname = 'FIELD1' )
      ->editable( )
      ->short_text( i_text = 'Flag' )
      ->as_checkbox( )
      ->optimize( )
      ->column_position( iv_position = 3 ).

    lt_columns = mo_cut->receive( ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_columns )
      exp = 1 ).

    READ TABLE lt_columns ASSIGNING FIELD-SYMBOL(<ls_column>) INDEX 1.
    cl_abap_unit_assert=>assert_subrc(
      act = sy-subrc
      exp = 0 ).

    cl_abap_unit_assert=>assert_equals(
      act = <ls_column>-columnname
      exp = 'FIELD1' ).
    cl_abap_unit_assert=>assert_equals(
      act = <ls_column>-edit
      exp = if_salv_c_bool_sap=>true ).
    cl_abap_unit_assert=>assert_equals(
      act = <ls_column>-short_text
      exp = 'Flag' ).
    cl_abap_unit_assert=>assert_equals(
      act = <ls_column>-type
      exp = if_salv_c_cell_type=>checkbox ).
    cl_abap_unit_assert=>assert_equals(
      act = <ls_column>-optimize
      exp = if_salv_c_bool_sap=>true ).
    cl_abap_unit_assert=>assert_equals(
      act = <ls_column>-column_position
      exp = 3 ).
  ENDMETHOD.


  METHOD keeps_single_entry_per_column.
    DATA lt_columns TYPE zsalv_tt_column.

    mo_cut->set_column( iv_columnname = 'FIELD1' )
      ->short_text( i_text = 'ID' ).

    mo_cut->set_column( iv_columnname = 'FIELD1' )
      ->long_text( i_text = 'Document ID' )
      ->hide( ).

    lt_columns = mo_cut->receive( ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_columns )
      exp = 1 ).

    READ TABLE lt_columns ASSIGNING FIELD-SYMBOL(<ls_column>) INDEX 1.
    cl_abap_unit_assert=>assert_subrc(
      act = sy-subrc
      exp = 0 ).

    cl_abap_unit_assert=>assert_equals(
      act = <ls_column>-short_text
      exp = 'ID' ).
    cl_abap_unit_assert=>assert_equals(
      act = <ls_column>-long_text
      exp = 'Document ID' ).
    cl_abap_unit_assert=>assert_equals(
      act = <ls_column>-hide
      exp = if_salv_c_bool_sap=>true ).
  ENDMETHOD.


ENDCLASS.
