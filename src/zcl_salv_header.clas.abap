CLASS zcl_salv_header DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor.
    METHODS set_text
      IMPORTING
        !iv_row    TYPE i
        !iv_column TYPE i
        !iv_value  TYPE any
        !iv_bold   TYPE abap_bool DEFAULT abap_false.
    METHODS get_result
      RETURNING
        VALUE(result) TYPE REF TO cl_salv_form_layout_grid.
    CLASS-METHODS range_to_string
      IMPORTING
        !ir_data TYPE STANDARD TABLE
      RETURNING
        VALUE(result) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA mo_header TYPE REF TO cl_salv_form_layout_grid.
    DATA mo_label  TYPE REF TO cl_salv_form_label.
    DATA mo_flow   TYPE REF TO cl_salv_form_layout_flow.

ENDCLASS.



CLASS zcl_salv_header IMPLEMENTATION.


  METHOD constructor.

    mo_header = NEW #( ).

  ENDMETHOD.


  METHOD get_result.

    result = mo_header.

  ENDMETHOD.


  METHOD range_to_string.

    LOOP AT ir_data ASSIGNING FIELD-SYMBOL(<ls_data>).
      ASSIGN COMPONENT 'SIGN' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_sign>).
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      ASSIGN COMPONENT 'LOW' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_low>).
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      ASSIGN COMPONENT 'HIGH' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_high>).
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      IF result IS NOT INITIAL.
        result = |{ result }, |.
      ENDIF.

      IF <lv_sign> = 'E'.
        result = |{ result }Excl. |.
      ENDIF.

      result = |{ result }{ <lv_low> }|.

      IF <lv_high> IS NOT INITIAL.
        result = |{ result } - { <lv_high> }|.
      ENDIF.
    ENDLOOP.

    CONDENSE result.

  ENDMETHOD.


  METHOD set_text.

    CASE iv_bold.
      WHEN abap_true.
        mo_label = mo_header->create_label(
          row    = iv_row
          column = iv_column ).
        mo_label->set_text( iv_value ).

      WHEN abap_false.
        mo_flow = mo_header->create_flow(
          row    = iv_row
          column = iv_column ).
        mo_flow->create_text( text = iv_value ).
    ENDCASE.

  ENDMETHOD.


ENDCLASS.
