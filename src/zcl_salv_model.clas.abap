CLASS zcl_salv_model DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    DATA mo_data          TYPE REF TO data.
    DATA mo_data_copy     TYPE REF TO data.
    DATA mo_parameters    TYPE REF TO zif_salv_editing.
    DATA mt_edited_fields TYPE zsalv_tt_technical.
    DATA mt_edited_f4     TYPE zsalv_tt_technical.

    EVENTS data_changed
      EXPORTING
        VALUE(eo_data_changed) TYPE REF TO cl_alv_changed_data_protocol.
    EVENTS f4
      EXPORTING
        VALUE(e_fieldname)   TYPE lvc_fname OPTIONAL
        VALUE(e_fieldvalue)  TYPE lvc_value OPTIONAL
        VALUE(es_row_no)     TYPE lvc_s_roid OPTIONAL
        VALUE(er_event_data) TYPE REF TO cl_alv_event_data OPTIONAL
        VALUE(et_bad_cells)  TYPE lvc_t_modi OPTIONAL
        VALUE(e_display)     TYPE char01 OPTIONAL.

    CLASS-METHODS class_constructor.
    CLASS-METHODS get_reference
      RETURNING
        VALUE(result) TYPE REF TO zcl_salv_model.
    METHODS check_changed_data
      IMPORTING
        !io_salv TYPE REF TO cl_salv_table.
    METHODS set_editable
      IMPORTING
        !io_salv     TYPE REF TO cl_salv_table
        !i_edit_mode TYPE sap_bool
      RAISING
        zcx_salv.

  PROTECTED SECTION.

  PRIVATE SECTION.

    CLASS-DATA mo_model TYPE REF TO zcl_salv_model.
    DATA mo_grid TYPE REF TO cl_gui_alv_grid.

    METHODS get_grid
      IMPORTING
        !io_salv_model TYPE REF TO cl_salv_model
      RETURNING
        VALUE(ro_grid) TYPE REF TO cl_gui_alv_grid
      RAISING
        cx_salv_error.
    METHODS get_tree
      IMPORTING
        !io_salv_model TYPE REF TO cl_salv_model
      RETURNING
        VALUE(ro_tree) TYPE REF TO cl_gui_alv_tree
      RAISING
        cx_salv_error.
    METHODS on_changed_finished
      FOR EVENT data_changed_finished OF cl_gui_alv_grid
      IMPORTING
        !e_modified
        !et_good_cells.
    METHODS on_data_changed
      FOR EVENT data_changed OF cl_gui_alv_grid
      IMPORTING
        !er_data_changed.
    METHODS on_toolbar
      FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING
        !e_object
        !e_interactive.
    METHODS on_f4
      FOR EVENT onf4 OF cl_gui_alv_grid
      IMPORTING
        !e_fieldname
        !e_fieldvalue
        !es_row_no
        !er_event_data
        !et_bad_cells
        !e_display.

ENDCLASS.



CLASS zcl_salv_model IMPLEMENTATION.


  METHOD check_changed_data.

    IF io_salv IS NOT BOUND.
      RETURN.
    ENDIF.

    IF mo_grid IS BOUND.
      mo_grid->check_changed_data( ).
    ENDIF.

  ENDMETHOD.


  METHOD class_constructor.

    mo_model = NEW #( ).

  ENDMETHOD.


  METHOD get_grid.

    IF io_salv_model->model <> if_salv_c_model=>table.
      RAISE EXCEPTION TYPE cx_salv_msg
        EXPORTING
          msgid = '00'
          msgno = '001'
          msgty = 'E'
          msgv1 = 'Incorrect SALV Type'.
    ENDIF.

    ro_grid = lcl_salv_model_list=>get_grid( io_salv_model ).

  ENDMETHOD.


  METHOD get_reference.

    result = mo_model.

  ENDMETHOD.


  METHOD get_tree.

    IF io_salv_model->model <> if_salv_c_model=>tree.
      RAISE EXCEPTION TYPE cx_salv_msg
        EXPORTING
          msgid = '00'
          msgno = '001'
          msgty = 'E'
          msgv1 = 'Incorrect SALV Type'.
    ENDIF.

    ro_tree = lcl_salv_model_list=>get_tree( io_salv_model ).

  ENDMETHOD.


  METHOD on_changed_finished.
  ENDMETHOD.


  METHOD on_data_changed.

    IF mo_grid IS NOT BOUND OR mo_data IS NOT BOUND.
      RETURN.
    ENDIF.

    ASSIGN mo_data->* TO FIELD-SYMBOL(<lt_data>).
    IF <lt_data> IS NOT ASSIGNED.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          textid = zcx_salv=>data_error.
    ENDIF.

    IF er_data_changed->mt_mod_cells IS NOT INITIAL
       OR er_data_changed->mt_inserted_rows IS NOT INITIAL.
      mo_grid->get_current_cell(
        IMPORTING
          es_row_id = DATA(ls_row_id)
          es_col_id = DATA(ls_col_id)
          es_row_no = DATA(ls_row_no) ).

      ls_row_id-index  = ls_row_id-index + 1.
      ls_row_no-row_id = ls_row_no-row_id + 1.

      IF ls_row_id-index <= lines( <lt_data> ).
        mo_grid->set_current_cell_via_id(
          is_row_id    = ls_row_id
          is_column_id = ls_col_id
          is_row_no    = ls_row_no ).
      ENDIF.
    ENDIF.

    RAISE EVENT data_changed
      EXPORTING
        eo_data_changed = er_data_changed.

  ENDMETHOD.


  METHOD on_f4.

    RAISE EVENT f4
      EXPORTING
        e_fieldname   = e_fieldname
        e_fieldvalue  = e_fieldvalue
        es_row_no     = es_row_no
        er_event_data = er_event_data
        et_bad_cells  = et_bad_cells
        e_display     = e_display.

    IF mo_grid IS NOT BOUND.
      RETURN.
    ENDIF.

    DATA(ls_stable_refresh) = VALUE lvc_s_stbl( row = if_salv_c_bool_sap=>true
                                                 col = if_salv_c_bool_sap=>true ).
    mo_grid->refresh_table_display( is_stable = ls_stable_refresh ).

  ENDMETHOD.


  METHOD on_toolbar.
    CONSTANTS lc_separator_function TYPE ui_func VALUE '&&SEP'.
    DATA lv_separator_index TYPE n LENGTH 2 VALUE 0.
    DATA lt_toolbar TYPE ttb_button.

    IF mo_grid IS NOT BOUND OR mo_parameters IS NOT BOUND.
      RETURN.
    ENDIF.

    IF mo_grid->is_ready_for_input( ) <> zif_salv=>gc_ready_for_input_true.
      RETURN.
    ENDIF.

    IF mo_parameters->row_check = if_salv_c_bool_sap=>true.
      lv_separator_index = lv_separator_index + 1.
      APPEND VALUE #( function = |{ lc_separator_function }{ lv_separator_index }| butn_type = 3 ) TO lt_toolbar.
      APPEND VALUE #( function = cl_gui_alv_grid=>mc_fc_check quickinfo = text-001 icon = icon_check
                       text = COND #( WHEN mo_parameters->show_text = if_salv_c_bool_sap=>true THEN text-001 ) ) TO lt_toolbar.
    ENDIF.

    IF mo_parameters->group_copypast = if_salv_c_bool_sap=>true.
      lv_separator_index = lv_separator_index + 1.
      APPEND VALUE #( function = |{ lc_separator_function }{ lv_separator_index }| butn_type = 3 ) TO lt_toolbar.
      APPEND VALUE #( function = cl_gui_alv_grid=>mc_fc_loc_cut quickinfo = text-002 icon = icon_system_cut
                       text = COND #( WHEN mo_parameters->show_text = if_salv_c_bool_sap=>true THEN text-002 ) ) TO lt_toolbar.
      APPEND VALUE #( function = cl_gui_alv_grid=>mc_fc_loc_copy quickinfo = text-003 icon = icon_system_copy
                       text = COND #( WHEN mo_parameters->show_text = if_salv_c_bool_sap=>true THEN text-003 ) ) TO lt_toolbar.
      APPEND VALUE #( function = cl_gui_alv_grid=>mc_fc_loc_paste quickinfo = text-004 icon = icon_system_paste
                       text = COND #( WHEN mo_parameters->show_text = if_salv_c_bool_sap=>true THEN text-004 ) ) TO lt_toolbar.
      APPEND VALUE #( function = cl_gui_alv_grid=>mc_fc_loc_paste_new_row quickinfo = text-005 icon = icon_system_paste
                       text = COND #( WHEN mo_parameters->show_text = if_salv_c_bool_sap=>true THEN text-005 ) ) TO lt_toolbar.
      APPEND VALUE #( function = cl_gui_alv_grid=>mc_fc_loc_undo quickinfo = text-006 icon = icon_system_undo
                       text = COND #( WHEN mo_parameters->show_text = if_salv_c_bool_sap=>true THEN text-006 ) ) TO lt_toolbar.
    ENDIF.

    lv_separator_index = lv_separator_index + 1.
    APPEND VALUE #( function = |{ lc_separator_function }{ lv_separator_index }| butn_type = 3 ) TO lt_toolbar.

    IF mo_parameters->row_append = if_salv_c_bool_sap=>true.
      APPEND VALUE #( function = cl_gui_alv_grid=>mc_fc_loc_append_row quickinfo = text-007 icon = icon_create
                       text = COND #( WHEN mo_parameters->show_text = if_salv_c_bool_sap=>true THEN text-007 ) ) TO lt_toolbar.
    ENDIF.

    IF mo_parameters->row_insert = if_salv_c_bool_sap=>true.
      APPEND VALUE #( function = cl_gui_alv_grid=>mc_fc_loc_insert_row quickinfo = text-008 icon = icon_insert_row
                       text = COND #( WHEN mo_parameters->show_text = if_salv_c_bool_sap=>true THEN text-008 ) ) TO lt_toolbar.
    ENDIF.

    IF mo_parameters->row_delete = if_salv_c_bool_sap=>true.
      APPEND VALUE #( function = cl_gui_alv_grid=>mc_fc_loc_delete_row quickinfo = text-009 icon = icon_delete_row
                       text = COND #( WHEN mo_parameters->show_text = if_salv_c_bool_sap=>true THEN text-009 ) ) TO lt_toolbar.
    ENDIF.

    IF mo_parameters->row_copy = if_salv_c_bool_sap=>true.
      APPEND VALUE #( function = cl_gui_alv_grid=>mc_fc_loc_copy_row quickinfo = text-010 icon = icon_copy_object
                       text = COND #( WHEN mo_parameters->show_text = if_salv_c_bool_sap=>true THEN text-010 ) ) TO lt_toolbar.
    ENDIF.

    APPEND LINES OF lt_toolbar TO e_object->mt_toolbar.

  ENDMETHOD.


  METHOD set_editable.
    DATA ls_layout TYPE lvc_s_layo.
    DATA lt_f4 TYPE lvc_t_f4.

    DATA(ls_stable_refresh) = VALUE lvc_s_stbl( row = if_salv_c_bool_sap=>true
                                                 col = if_salv_c_bool_sap=>true ).

    DATA(lv_ready_for_input) = COND int4( WHEN i_edit_mode = if_salv_c_bool_sap=>true
                                           THEN zif_salv=>gc_ready_for_input_true
                                           ELSE zif_salv=>gc_ready_for_input_false ).

    TRY.
        IF io_salv IS NOT BOUND OR mo_grid IS NOT BOUND.
          RETURN.
        ENDIF.

        IF io_salv->get_display_object( ) = 3.
          SET HANDLER on_toolbar          FOR mo_grid.
          SET HANDLER on_data_changed     FOR mo_grid.
          SET HANDLER on_changed_finished FOR mo_grid.
          SET HANDLER on_f4               FOR mo_grid.
        ENDIF.

        IF mo_parameters->row_delete = if_salv_c_bool_sap=>false.
          ls_layout-no_rowins = if_salv_c_bool_sap=>true.
          mo_grid->set_frontend_layout( ls_layout ).
        ENDIF.

        CASE lines( mt_edited_fields ).
          WHEN 0.
            ls_layout-edit = if_salv_c_bool_sap=>true.
            mo_grid->set_frontend_layout( ls_layout ).

          WHEN OTHERS.
            mo_grid->get_frontend_fieldcatalog( IMPORTING et_fieldcatalog = DATA(lt_fcat) ).
            LOOP AT mt_edited_fields ASSIGNING FIELD-SYMBOL(<fs_edited_fields>).
              ASSIGN lt_fcat[ fieldname = <fs_edited_fields>-columnname ] TO FIELD-SYMBOL(<fs_fcat>).
              IF sy-subrc = 0.
                <fs_fcat>-edit = if_salv_c_bool_sap=>true.
              ENDIF.
            ENDLOOP.
            mo_grid->set_frontend_fieldcatalog( lt_fcat ).
        ENDCASE.

        IF mt_edited_f4 IS NOT INITIAL.
          LOOP AT mt_edited_f4 ASSIGNING FIELD-SYMBOL(<fs_edited_f4>).
            APPEND VALUE lvc_s_f4( fieldname = <fs_edited_f4>-columnname
                                   register  = if_salv_c_bool_sap=>true ) TO lt_f4.
          ENDLOOP.
          mo_grid->register_f4_for_fields( lt_f4 ).
        ENDIF.

        mo_grid->register_edit_event( cl_gui_alv_grid=>mc_evt_enter ).
        mo_grid->register_edit_event( cl_gui_alv_grid=>mc_evt_modified ).
        mo_grid->set_ready_for_input( lv_ready_for_input ).
        mo_grid->refresh_table_display( is_stable = ls_stable_refresh ).

      CATCH cx_salv_error INTO DATA(lo_exception).
        RAISE EXCEPTION TYPE zcx_salv
          EXPORTING
            error_text = |{ lo_exception->get_text( ) }|
            textid     = zcx_salv=>model_error.
    ENDTRY.

  ENDMETHOD.


ENDCLASS.
