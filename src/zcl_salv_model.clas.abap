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

    CHECK io_salv IS BOUND.

    IF mo_grid IS BOUND.
      mo_grid->check_changed_data( ).
    ENDIF.

  ENDMETHOD.


  METHOD class_constructor.

    CREATE OBJECT mo_model.

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
    DATA:
      ls_row_id TYPE lvc_s_row,
      ls_col_id TYPE lvc_s_col,
      ls_row_no TYPE lvc_s_roid.
    FIELD-SYMBOLS <lt_data> TYPE STANDARD TABLE.

    CHECK mo_grid IS BOUND.
    CHECK mo_data IS BOUND.

    ASSIGN mo_data->* TO <lt_data>.
    IF <lt_data> IS NOT ASSIGNED.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          textid = zcx_salv=>data_error.
    ENDIF.

    IF er_data_changed->mt_mod_cells IS NOT INITIAL
       OR er_data_changed->mt_inserted_rows IS NOT INITIAL.
      mo_grid->get_current_cell(
        IMPORTING
          es_row_id = ls_row_id
          es_col_id = ls_col_id
          es_row_no = ls_row_no ).

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
    DATA ls_stable_refresh TYPE lvc_s_stbl.

    RAISE EVENT f4
      EXPORTING
        e_fieldname   = e_fieldname
        e_fieldvalue  = e_fieldvalue
        es_row_no     = es_row_no
        er_event_data = er_event_data
        et_bad_cells  = et_bad_cells
        e_display     = e_display.

    CHECK mo_grid IS BOUND.

    ls_stable_refresh-row = if_salv_c_bool_sap=>true.
    ls_stable_refresh-col = if_salv_c_bool_sap=>true.
    mo_grid->refresh_table_display( is_stable = ls_stable_refresh ).

  ENDMETHOD.


  METHOD on_toolbar.
    CONSTANTS lc_separator_function TYPE ui_func VALUE '&&SEP'.
    DATA lv_separator_index TYPE n LENGTH 2 VALUE 0.
    DATA lt_toolbar TYPE ttb_button.
    DATA ls_toolbar LIKE LINE OF lt_toolbar.

    DEFINE add_button.
      CLEAR ls_toolbar.
      ls_toolbar-function  = &1.
      ls_toolbar-quickinfo = &2.
      ls_toolbar-icon      = &3.
      IF mo_parameters->show_text = if_salv_c_bool_sap=>true.
        ls_toolbar-text = &2.
      ENDIF.
      APPEND ls_toolbar TO lt_toolbar.
    END-OF-DEFINITION.

    DEFINE add_separator.
      ADD 1 TO lv_separator_index.
      CLEAR ls_toolbar.
      ls_toolbar-function  = |{ lc_separator_function }{ lv_separator_index }|.
      ls_toolbar-butn_type = 3.
      APPEND ls_toolbar TO lt_toolbar.
    END-OF-DEFINITION.

    CHECK mo_grid IS BOUND.
    CHECK mo_parameters IS BOUND.
    CHECK mo_grid->is_ready_for_input( ) = zif_salv=>gc_ready_for_input_true.

    IF mo_parameters->row_check = if_salv_c_bool_sap=>true.
      add_separator.
      add_button cl_gui_alv_grid=>mc_fc_check             text-001 icon_check.
    ENDIF.

    IF mo_parameters->group_copypast = if_salv_c_bool_sap=>true.
      add_separator.
      add_button cl_gui_alv_grid=>mc_fc_loc_cut           text-002 icon_system_cut.
      add_button cl_gui_alv_grid=>mc_fc_loc_copy          text-003 icon_system_copy.
      add_button cl_gui_alv_grid=>mc_fc_loc_paste         text-004 icon_system_paste.
      add_button cl_gui_alv_grid=>mc_fc_loc_paste_new_row text-005 icon_system_paste.
      add_button cl_gui_alv_grid=>mc_fc_loc_undo          text-006 icon_system_undo.
    ENDIF.

    add_separator.

    IF mo_parameters->row_append = if_salv_c_bool_sap=>true.
      add_button cl_gui_alv_grid=>mc_fc_loc_append_row text-007 icon_create.
    ENDIF.

    IF mo_parameters->row_insert = if_salv_c_bool_sap=>true.
      add_button cl_gui_alv_grid=>mc_fc_loc_insert_row text-008 icon_insert_row.
    ENDIF.

    IF mo_parameters->row_delete = if_salv_c_bool_sap=>true.
      add_button cl_gui_alv_grid=>mc_fc_loc_delete_row text-009 icon_delete_row.
    ENDIF.

    IF mo_parameters->row_copy = if_salv_c_bool_sap=>true.
      add_button cl_gui_alv_grid=>mc_fc_loc_copy_row text-010 icon_copy_object.
    ENDIF.

    APPEND LINES OF lt_toolbar TO e_object->mt_toolbar.

  ENDMETHOD.


  METHOD set_editable.
    DATA lo_exception TYPE REF TO cx_salv_error.
    DATA ls_layout TYPE lvc_s_layo.
    DATA lt_fcat TYPE lvc_t_fcat.
    DATA lt_f4 TYPE lvc_t_f4.
    DATA ls_stable_refresh TYPE lvc_s_stbl.
    DATA ls_f4 TYPE lvc_s_f4.
    DATA lv_ready_for_input TYPE int4.
    FIELD-SYMBOLS <fs_edited_fields> LIKE LINE OF mt_edited_fields.
    FIELD-SYMBOLS <fs_edited_f4> LIKE LINE OF mt_edited_f4.
    FIELD-SYMBOLS <fs_fcat> LIKE LINE OF lt_fcat.

    ls_stable_refresh-row = if_salv_c_bool_sap=>true.
    ls_stable_refresh-col = if_salv_c_bool_sap=>true.

    IF i_edit_mode = if_salv_c_bool_sap=>true.
      lv_ready_for_input = zif_salv=>gc_ready_for_input_true.
    ELSE.
      lv_ready_for_input = zif_salv=>gc_ready_for_input_false.
    ENDIF.

    TRY.
        CHECK io_salv IS BOUND.
        CHECK mo_grid IS BOUND.

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
            mo_grid->get_frontend_fieldcatalog( IMPORTING et_fieldcatalog = lt_fcat ).
            LOOP AT mt_edited_fields ASSIGNING <fs_edited_fields>.
              READ TABLE lt_fcat ASSIGNING <fs_fcat> WITH KEY fieldname = <fs_edited_fields>-columnname.
              CHECK sy-subrc = 0.
              <fs_fcat>-edit = if_salv_c_bool_sap=>true.
            ENDLOOP.
            mo_grid->set_frontend_fieldcatalog( lt_fcat ).
        ENDCASE.

        IF mt_edited_f4 IS NOT INITIAL.
          LOOP AT mt_edited_f4 ASSIGNING <fs_edited_f4>.
            CLEAR ls_f4.
            ls_f4-fieldname = <fs_edited_f4>-columnname.
            ls_f4-register  = if_salv_c_bool_sap=>true.
            APPEND ls_f4 TO lt_f4.
          ENDLOOP.
          mo_grid->register_f4_for_fields( lt_f4 ).
        ENDIF.

        mo_grid->register_edit_event( cl_gui_alv_grid=>mc_evt_enter ).
        mo_grid->register_edit_event( cl_gui_alv_grid=>mc_evt_modified ).
        mo_grid->set_ready_for_input( lv_ready_for_input ).
        mo_grid->refresh_table_display( is_stable = ls_stable_refresh ).

      CATCH cx_salv_error INTO lo_exception.
        RAISE EXCEPTION TYPE zcx_salv
          EXPORTING
            error_text = |{ lo_exception->get_text( ) }|
            textid     = zcx_salv=>model_error.
    ENDTRY.

  ENDMETHOD.


ENDCLASS.
