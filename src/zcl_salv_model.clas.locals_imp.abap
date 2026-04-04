CLASS lcl_salv_model_list DEFINITION INHERITING FROM cl_salv_model_base.

  PUBLIC SECTION.
    CLASS-METHODS get_grid
      IMPORTING
        io_salv_model TYPE REF TO cl_salv_model
      RETURNING
        VALUE(ro_grid) TYPE REF TO cl_gui_alv_grid
      RAISING
        cx_salv_msg.
    CLASS-METHODS get_tree
      IMPORTING
        io_salv_model TYPE REF TO cl_salv_model
      RETURNING
        VALUE(ro_tree) TYPE REF TO cl_gui_alv_tree
      RAISING
        cx_salv_msg.

ENDCLASS.



CLASS lcl_salv_model_list IMPLEMENTATION.


  METHOD get_grid.

    TRY.
        DATA(lo_grid_adapter) = CAST cl_salv_grid_adapter( io_salv_model->r_controller->r_adapter ).
      CATCH cx_root.
        TRY.
            DATA(lo_fullscreen_adapter) = CAST cl_salv_fullscreen_adapter( io_salv_model->r_controller->r_adapter ).
          CATCH cx_root INTO DATA(lo_root).
            RAISE EXCEPTION TYPE cx_salv_msg
              EXPORTING
                previous = lo_root
                msgid    = '00'
                msgno    = '001'
                msgty    = 'E'
                msgv1    = 'Check PREVIOUS exception'.
        ENDTRY.
    ENDTRY.

    IF lo_grid_adapter IS BOUND.
      ro_grid = lo_grid_adapter->get_grid( ).
    ELSEIF lo_fullscreen_adapter IS BOUND.
      ro_grid = lo_fullscreen_adapter->get_grid( ).
    ELSE.
      RAISE EXCEPTION TYPE cx_salv_msg
        EXPORTING
          msgid = '00'
          msgno = '001'
          msgty = 'W'
          msgv1 = 'Adapter is not bound yet'.
    ENDIF.
  ENDMETHOD.


  METHOD get_tree.

    TRY.
        DATA(lo_tree_adapter) = CAST cl_salv_tree_adapter( io_salv_model->r_controller->r_adapter ).
      CATCH cx_root INTO DATA(lo_root).
        RAISE EXCEPTION TYPE cx_salv_msg
          EXPORTING
            previous = lo_root
            msgid    = '00'
            msgno    = '001'
            msgty    = 'E'
            msgv1    = 'Check PREVIOUS exception'.
    ENDTRY.

    IF lo_tree_adapter IS NOT BOUND.
      RAISE EXCEPTION TYPE cx_salv_msg
        EXPORTING
          msgid = '00'
          msgno = '001'
          msgty = 'W'
          msgv1 = 'Adapter is not bound yet'.
    ENDIF.

    ro_tree = lo_tree_adapter->r_tree.
  ENDMETHOD.


ENDCLASS.
