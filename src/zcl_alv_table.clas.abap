CLASS zcl_alv_table DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES mtt_fields TYPE SORTED TABLE OF name_komp WITH UNIQUE KEY table_line.
    TYPES mtv_mode_name TYPE char20.
    TYPES:
      BEGIN OF mts_mode,
        mode_name   TYPE mtv_mode_name,
        pfstatus    TYPE sypfkey,
        title       TYPE gui_title,
        edit_fields TYPE mtt_fields,
      END OF mts_mode.
    TYPES mtt_modes TYPE TABLE OF mts_mode.

    DATA mref_dtab TYPE REF TO data.

    METHODS constructor
      IMPORTING
        !iref_dtab TYPE REF TO data OPTIONAL.
    METHODS create_alv
      IMPORTING
        !iv_container_name TYPE c DEFAULT ''
        !it_modes          TYPE mtt_modes OPTIONAL
        !it_exttab         TYPE ui_functions OPTIONAL
      RAISING
        cx_salv_msg.
    METHODS set_alv_mode
      IMPORTING
        !iv_mode_name TYPE mtv_mode_name DEFAULT ''.
    METHODS get_alv_mode
      RETURNING
        VALUE(rs_mode) TYPE mts_mode.
    METHODS free_alv.

  PROTECTED SECTION.

    DATA mo_alv          TYPE REF TO cl_gui_alv_grid.
    DATA mt_modes        TYPE mtt_modes.
    DATA mt_fieldcatalog TYPE lvc_t_fcat.

    METHODS handle_user_command
      FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING
        !e_ucomm.
    METHODS handle_double_click
      FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING
        !e_row
        !e_column
        !es_row_no.
    METHODS handle_data_changed
      FOR EVENT data_changed OF cl_gui_alv_grid
      IMPORTING
        !er_data_changed
        !e_onf4
        !e_onf4_before
        !e_onf4_after
        !e_ucomm.
    METHODS build_fieldcatalog
      IMPORTING
        !iv_structure_name TYPE tabname OPTIONAL.

  PRIVATE SECTION.

    DATA mv_current_mode_ind TYPE sytabix.
    DATA mo_container        TYPE REF TO cl_gui_container.

ENDCLASS.



CLASS zcl_alv_table IMPLEMENTATION.


  METHOD build_fieldcatalog.

    CLEAR mt_fieldcatalog.

    IF iv_structure_name IS NOT INITIAL.
      CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
        EXPORTING
          i_structure_name       = iv_structure_name
          i_internal_tabname     = '<LT_DTAB>'
        CHANGING
          ct_fieldcat            = mt_fieldcatalog
        EXCEPTIONS
          inconsistent_interface = 1
          program_error          = 2
          OTHERS                 = 3.
    ELSE.
      ASSIGN mref_dtab->* TO FIELD-SYMBOL(<lt_table>).
      DATA(lo_line) = NEW data LIKE LINE OF <lt_table>.
      DATA(lo_tabdescr) = CAST cl_abap_structdescr( cl_abap_structdescr=>describe_by_data_ref( lo_line ) ).
      DATA(lt_dfies) = cl_salv_data_descr=>read_structdescr( lo_tabdescr ).

      LOOP AT lt_dfies ASSIGNING FIELD-SYMBOL(<ls_dfies>).
        APPEND CORRESPONDING lvc_s_fcat( <ls_dfies> ) TO mt_fieldcatalog.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD constructor.

    CLEAR: mt_modes, mv_current_mode_ind.
    mref_dtab = iref_dtab.

  ENDMETHOD.


  METHOD create_alv.
    DATA lt_sort TYPE lvc_t_sort.

    IF it_modes IS SUPPLIED.
      mt_modes = it_modes.
    ENDIF.

    ASSIGN mref_dtab->* TO FIELD-SYMBOL(<lt_dtab>).

    IF iv_container_name IS INITIAL.
      mo_container = cl_gui_container=>screen0.
    ELSE.
      mo_container = NEW cl_gui_custom_container( container_name = iv_container_name ).
    ENDIF.

    IF mo_container IS NOT BOUND.
      RETURN.
    ENDIF.

    mo_alv = NEW #( i_parent = mo_container ).
    IF mo_alv IS NOT BOUND.
      RETURN.
    ENDIF.

    build_fieldcatalog( ).

    SET HANDLER me->handle_double_click FOR mo_alv.
    SET HANDLER me->handle_user_command FOR mo_alv.
    SET HANDLER me->handle_data_changed FOR mo_alv.

    mo_alv->register_edit_event(
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified ).

    DATA(ls_layout) = VALUE lvc_s_layo( sel_mode = zif_salv=>gc_layout_sel_mode_a
                                        zebra    = abap_true ).

    DATA(ls_var) = VALUE disvariant( report = sy-repid
                                     handle = zif_salv=>gc_var_handle ).

    mo_alv->set_table_for_first_display(
      EXPORTING
        is_layout            = ls_layout
        it_toolbar_excluding = it_exttab
        is_variant           = ls_var
        i_save               = zif_salv=>gc_display_save_a
      CHANGING
        it_sort              = lt_sort
        it_fieldcatalog      = mt_fieldcatalog
        it_outtab            = <lt_dtab> ).

    set_alv_mode( ).
  ENDMETHOD.


  METHOD free_alv.

    CLEAR mo_alv.

    IF mo_container IS BOUND.
      mo_container->free( ).
    ENDIF.

    CLEAR mo_container.

  ENDMETHOD.


  METHOD get_alv_mode.

    CLEAR rs_mode.
    IF mt_modes IS INITIAL.
      RETURN.
    ENDIF.

    READ TABLE mt_modes ASSIGNING FIELD-SYMBOL(<ls_mode>) INDEX mv_current_mode_ind.
    IF sy-subrc = 0.
      rs_mode = <ls_mode>.
    ENDIF.

  ENDMETHOD.


  METHOD handle_data_changed.
  ENDMETHOD.


  METHOD handle_double_click.
  ENDMETHOD.


  METHOD handle_user_command.
  ENDMETHOD.


  METHOD set_alv_mode.
    DATA lv_fieldcat_changed TYPE abap_bool.
    FIELD-SYMBOLS <ls_mode> TYPE mts_mode.

    IF mt_modes IS INITIAL.
      RETURN.
    ENDIF.

    IF iv_mode_name IS NOT INITIAL.
      READ TABLE mt_modes ASSIGNING <ls_mode> WITH KEY mode_name = iv_mode_name.
      mv_current_mode_ind = sy-tabix.
    ELSE.
      mv_current_mode_ind = mv_current_mode_ind + 1.
      IF mv_current_mode_ind > lines( mt_modes ).
        mv_current_mode_ind = 1.
      ENDIF.

      READ TABLE mt_modes ASSIGNING <ls_mode> INDEX mv_current_mode_ind.
    ENDIF.

    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    lv_fieldcat_changed = abap_false.

    LOOP AT mt_fieldcatalog ASSIGNING FIELD-SYMBOL(<ls_fieldcat>).
      IF line_exists( <ls_mode>-edit_fields[ table_line = <ls_fieldcat>-fieldname ] ).
        IF <ls_fieldcat>-edit <> abap_on.
          lv_fieldcat_changed = abap_true.
          <ls_fieldcat>-edit = abap_on.
        ENDIF.
      ELSEIF <ls_fieldcat>-edit = abap_on.
        lv_fieldcat_changed = abap_true.
        <ls_fieldcat>-edit = abap_off.
      ENDIF.
    ENDLOOP.

    IF lv_fieldcat_changed = abap_true.
      mo_alv->set_frontend_fieldcatalog( mt_fieldcatalog ).
      DATA(ls_stable) = VALUE lvc_s_stbl( row = abap_on col = abap_on ).
      mo_alv->refresh_table_display(
        i_soft_refresh = abap_on
        is_stable      = ls_stable ).
    ENDIF.

    IF <ls_mode>-edit_fields IS NOT INITIAL.
      IF mo_alv->is_ready_for_input( ) <> zif_salv=>gc_ready_for_input_true.
        mo_alv->set_ready_for_input( zif_salv=>gc_ready_for_input_true ).
      ENDIF.
    ELSEIF mo_alv->is_ready_for_input( ) <> zif_salv=>gc_ready_for_input_false.
      mo_alv->set_ready_for_input( zif_salv=>gc_ready_for_input_false ).
    ENDIF.
  ENDMETHOD.


ENDCLASS.
