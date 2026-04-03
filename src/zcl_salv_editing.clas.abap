CLASS zcl_salv_editing DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES zif_salv_editing.

    CLASS-METHODS class_constructor.
    CLASS-METHODS get_reference
      RETURNING
        VALUE(result) TYPE REF TO zif_salv_editing.

  PROTECTED SECTION.

  PRIVATE SECTION.

    ALIASES group_copypast FOR zif_salv_editing~group_copypast.
    ALIASES row_append     FOR zif_salv_editing~row_append.
    ALIASES row_check      FOR zif_salv_editing~row_check.
    ALIASES row_copy       FOR zif_salv_editing~row_copy.
    ALIASES row_delete     FOR zif_salv_editing~row_delete.
    ALIASES row_insert     FOR zif_salv_editing~row_insert.
    ALIASES show_text      FOR zif_salv_editing~show_text.

    CLASS-DATA mo_salv_editing TYPE REF TO zcl_salv_editing.

ENDCLASS.



CLASS zcl_salv_editing IMPLEMENTATION.


  METHOD class_constructor.

    CREATE OBJECT mo_salv_editing TYPE zcl_salv_editing.

  ENDMETHOD.


  METHOD get_reference.

    result = mo_salv_editing.

  ENDMETHOD.


ENDCLASS.
