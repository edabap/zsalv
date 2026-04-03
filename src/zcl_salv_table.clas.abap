class ZCL_SALV_TABLE definition
  public
  create public .

public section.

  constants CV_DOUBLE_CLICK type SALV_DE_FUNCTION value '&IC1' ##NO_TEXT.
  constants:
    BEGIN OF cs_standart_tb_profile,
        minimum     TYPE zsalv_standart_tb_profile VALUE '0',
        default     TYPE zsalv_standart_tb_profile VALUE '4',
        with_export TYPE zsalv_standart_tb_profile VALUE '5',
        maximum     TYPE zsalv_standart_tb_profile VALUE '9',
      END OF cs_standart_tb_profile .
  constants:
    BEGIN OF cs_edit_tb_profile,
        none         TYPE zsalv_editing_tb_profile VALUE '0',
        minimum      TYPE zsalv_editing_tb_profile VALUE '1',
        minimum_text TYPE zsalv_editing_tb_profile VALUE '2',
        default      TYPE zsalv_editing_tb_profile VALUE '3',
        default_text TYPE zsalv_editing_tb_profile VALUE '4',
        maximum      TYPE zsalv_editing_tb_profile VALUE '5',
        maximum_text TYPE zsalv_editing_tb_profile VALUE '6',
      END OF cs_edit_tb_profile .

  events USER_COMMAND_RECEIVED
    exporting
      value(E_USER_COMMAND) type SALV_DE_FUNCTION optional
      value(ET_ROW) type SALV_T_ROW optional
      value(ET_COLUMN) type SALV_T_COLUMN optional .
  events DATA_CHANGED_RECEIVED
    exporting
      value(EO_DATA_CHANGED) type ref to CL_ALV_CHANGED_DATA_PROTOCOL .
  events F4_RECEIVED
    exporting
      value(E_FIELDNAME) type LVC_FNAME optional
      value(E_FIELDVALUE) type LVC_VALUE optional
      value(ES_ROW_NO) type LVC_S_ROID optional
      value(ER_EVENT_DATA) type ref to CL_ALV_EVENT_DATA optional
      value(ET_BAD_CELLS) type LVC_T_MODI optional
      value(E_DISPLAY) type CHAR01 optional .

  methods GET_SELECTED_ROWS
    returning
      value(RT_ROWS) type SALV_T_ROW .
  methods CHECK_CHANGED_DATA .
  methods FREE .
  methods REFRESH .
  methods DISPLAY
    raising
      ZCX_SALV .
  methods INITIALIZE
    importing
      !IO_CONTAINER type ref to CL_GUI_CONTAINER optional
      !IV_CONTAINER_NAME type STRING optional
      !IV_LIST type SAP_BOOL default IF_SALV_C_BOOL_SAP=>FALSE
      !IO_DATA type ref to DATA
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_AGGREGATIONS
    importing
      !IT_AGGREGATION type ZSALV_TT_AGGREGATION
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_COLUMNS
    importing
      !IT_COLUMN type ZSALV_TT_COLUMN optional
      !IT_TECHNICAL type ZSALV_TT_TECHNICAL optional
      !IV_COLOR_COLUMN type LVC_FNAME optional
      !IV_STYLE_COLUMN type LVC_FNAME optional
      !IV_OPTIMIZE_WIDTH type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_CUSTOM_FUNCTIONS
    importing
      !IT_USER_COMMAND type ZSALV_TT_USER_COMMAND
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_DISPLAY_SETTINGS
    importing
      !IV_TITLE type LVC_TITLE default ''
      !IV_ZEBRA type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_FILTERS
    importing
      !IT_FILTER type ZSALV_TT_FILTER
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_HANDLERS
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_HYPERLINKS
    importing
      !IT_HYPERLINK type ZSALV_TT_HYPERLINK
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_LAYOUT
    importing
      !IV_VARIANT type SLIS_VARI default ''
      !IV_DEFAULT type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_RESTRICTION type SALV_DE_LAYOUT_RESTRICTION default IF_SALV_C_LAYOUT=>RESTRICT_NONE
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_PF_STATUS
    importing
      !IV_PFSTATUS type SYPFKEY
      !IV_REPORT type SYREPID default SY-CPROG
      !IV_FUNCTIONS type SALV_DE_CONSTANT default CL_SALV_MODEL_BASE=>C_FUNCTIONS_ALL
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_POPUP
    importing
      !IV_START_COLUMN type I default 5
      !IV_START_LINE type I default 5
      !IV_END_COLUMN type I default 100
      !IV_END_LINE type I default 20
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_SELECTIONS
    importing
      !IV_MODE type I default IF_SALV_C_SELECTION_MODE=>ROW_COLUMN
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_SORTS
    importing
      !IT_SORT type ZSALV_TT_SORT
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_SPECIFIC_GROUPS
    importing
      !IT_SPECIFIC_GROUP type ZSALV_TT_SPECIFIC_GROUP
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_STANDARD_TOOLBAR
    importing
      !IV_PROFILE type ZSALV_STANDART_TB_PROFILE
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_TOOLTIPS
    importing
      !IT_TOOLTIP type ZSALV_TT_TOOLTIP
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_TOP_OF_PAGE
    importing
      !IO_HEADER type ref to ZCL_SALV_HEADER
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_DROPDOWNS
    importing
      !IT_DROPDOWN type ZSALV_TT_DROPDOWN
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_EDITABLE
    importing
      !IV_EDIT_MODE type SAP_BOOL
      !IV_PROFILE type ZSALV_EDITING_TB_PROFILE
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
  methods SET_END_OF_PAGE
    importing
      !IO_FOOTER type ref to ZCL_SALV_HEADER
    returning
      value(RO_SALV) type ref to ZCL_SALV_TABLE
    raising
      ZCX_SALV .
protected section.

  data MO_ALV type ref to CL_SALV_TABLE .
private section.

  data MO_AGGREGATIONS type ref to CL_SALV_AGGREGATIONS .
  data MO_COLUMN type ref to CL_SALV_COLUMN_TABLE .
  data MO_COLUMNS type ref to CL_SALV_COLUMNS_TABLE .
  data MO_CONTAINER type ref to CL_GUI_CONTAINER .
  data MO_DISPLAY_SETTINGS type ref to CL_SALV_DISPLAY_SETTINGS .
  data MO_DROPDOWNS type ref to CL_SALV_DROPDOWNS .
  data MO_ERROR type ref to CX_SALV_MSG .
  data MO_EVENTS type ref to CL_SALV_EVENTS_TABLE .
  data MO_EXCEPTION type ref to ZCX_SALV .
  data MO_FILTERS type ref to CL_SALV_FILTERS .
  data MO_FUNCTIONAL_SETTINGS type ref to CL_SALV_FUNCTIONAL_SETTINGS .
  data MO_FUNCTIONS type ref to CL_SALV_FUNCTIONS_LIST .
  data MO_HYPERLINKS type ref to CL_SALV_HYPERLINKS .
  data MO_LAYOUT type ref to CL_SALV_LAYOUT .
  data MO_SELECTIONS type ref to CL_SALV_SELECTIONS .
  data MO_SORTS type ref to CL_SALV_SORTS .
  data MO_SPECIFIC_GROUPS type ref to CL_SALV_SPECIFIC_GROUPS .
  data MO_TOOLTIPS type ref to CL_SALV_TOOLTIPS .
  data MO_EDITING type ref to ZIF_SALV_EDITING .
  data MV_EDIT_MODE type SAP_BOOL .
  data MV_EDITABLE type SAP_BOOL .
  data MT_EDITED_FIELDS type ZSALV_TT_TECHNICAL .
  data MT_EDITED_F4 type ZSALV_TT_TECHNICAL .
  data MO_TOOLBAR type ref to ZIF_SALV_TOOLBAR .
  data MO_DATA type ref to DATA .
  data MV_REFRESH type SAP_BOOL value IF_SALV_C_BOOL_SAP=>FALSE ##NO_TEXT.

  methods SET_PARAMETERS_EDITING
    importing
      !IV_GROUP_COPYPAST type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_ROW_CHECK type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_ROW_APPEND type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_ROW_INSERT type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_ROW_DELETE type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_ROW_COPY type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_SHOW_TEXT type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE .
  methods SET_TOOLBAR
    importing
      !IV_ABC_ANALYSIS type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_AGGREGATION_AVERAGE type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_AGGREGATION_COUNT type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_AGGREGATION_MAXIMUM type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_AGGREGATION_MINIMUM type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_AGGREGATION_TOTAL type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_DEFAULT type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_DETAIL type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_EXPORT_FOLDER type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_EXPORT_HTML type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_EXPORT_LOCALFILE type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_EXPORT_MAIL type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_EXPORT_SEND type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_EXPORT_SPREADSHEET type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_EXPORT_WORDPROCESSOR type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_EXPORT_XML type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_FILTER type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_FILTER_DELETE type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_FIND type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_FIND_MORE type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_GRAPHICS type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_GROUP_AGGREGATION type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_GROUP_EXPORT type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_GROUP_FILTER type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_GROUP_LAYOUT type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_GROUP_SORT type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_GROUP_SUBTOTAL type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_GROUP_VIEW type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_LAYOUT_CHANGE type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_LAYOUT_LOAD type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_LAYOUT_MAINTAIN type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_LAYOUT_SAVE type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_PRINT type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_PRINT_PREVIEW type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_SORT_ASC type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_SORT_DESC type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_SUBTOTALS type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_SUBTOTALS_OUTLINE type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_VIEW_CRYSTAL type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_VIEW_EXCEL type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_VIEW_GRID type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_VIEW_LOTUS type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE .
  methods ADD_AGGREGATION
    importing
      !IV_COLUMNNAME type LVC_FNAME
      !IV_AGGREGATION type SALV_DE_AGGREGATION default IF_SALV_C_AGGREGATION=>TOTAL
      !IV_TOP type SAP_BOOL default IF_SALV_C_BOOL_SAP=>FALSE
    raising
      ZCX_SALV .
  methods ADD_COLUMN
    importing
      !IV_COLUMNNAME type LVC_FNAME
      !IV_TYPE type SALV_DE_CELLTYPE optional
      !IV_EXCEPTION type SAP_BOOL default IF_SALV_C_BOOL_SAP=>FALSE
      !IV_SUBTOTAL type SAP_BOOL default IF_SALV_C_BOOL_SAP=>FALSE
      !IV_LONG_TEXT type SCRTEXT_L optional
      !IV_MEDIUM_TEXT type SCRTEXT_M optional
      !IV_SHORT_TEXT type SCRTEXT_S optional
      !IV_OUTPUT_LENGTH type LVC_OUTLEN optional
      !IV_COLOR type LVC_S_COLO optional
      !IV_SPECIFIC_GROUP type LVC_SPGRP optional
      !IV_FIX type SAP_BOOL default IF_SALV_C_BOOL_SAP=>FALSE
      !IV_HIDE type SAP_BOOL default IF_SALV_C_BOOL_SAP=>TRUE
      !IV_TOOLTIP type LVC_TIP optional
      !IV_ICON type SAP_BOOL default IF_SALV_C_BOOL_SAP=>FALSE
      !IV_NO_F4 type SAP_BOOL optional
      !IV_F4 type SAP_BOOL optional
      !IV_F4_REFERENCE type SALV_S_DDIC_REFERENCE optional
      !IV_ENTRY_COLUMN type LVC_FNAME optional
      !IV_EXCEPTION_GROUP type CHAR1 optional
      !IV_OPTIMIZE type SAP_BOOL optional
      !IV_COLUMN_POSITION type LVC_COLPOS optional
    raising
      ZCX_SALV .
  methods ADD_COLUMN_COLOR
    importing
      !IV_COLUMNNAME type LVC_FNAME optional
    raising
      ZCX_SALV .
  methods ADD_COLUMN_STYLE
    importing
      !IV_COLUMNNAME type LVC_FNAME optional
    raising
      ZCX_SALV .
  methods ADD_COLUMN_TECHNICAL
    importing
      !IV_COLUMNNAME type LVC_FNAME optional
    raising
      ZCX_SALV .
  methods ADD_DROPDOWN
    importing
      !IV_HANDLE type SALV_DE_HYPERLINK_HANDLE
      !IT_VALUES type SALV_T_VALUE
    raising
      ZCX_SALV .
  methods ADD_FILTER
    importing
      !IV_COLUMNNAME type LVC_FNAME
      !IV_SIGN type SALV_DE_SELOPT_SIGN default 'I'
      !IV_OPTION type SALV_DE_SELOPT_OPTION default 'EQ'
      !IV_LOW type SALV_DE_SELOPT_LOW optional
      !IV_HIGH type SALV_DE_SELOPT_HIGH optional
    raising
      ZCX_SALV .
  methods ADD_FUNCTION
    importing
      !IV_FUNCTION type SALV_DE_FUNCTION
      !IV_ICON type STRING optional
      !IV_TEXT type STRING optional
      !IV_TOOLTIP type STRING
    raising
      ZCX_SALV .
  methods ADD_HYPERLINK
    importing
      !IV_HANDLE type SALV_DE_HYPERLINK_HANDLE
      !IV_HYPERLINK type SERVICE_RL
    raising
      ZCX_SALV .
  methods ADD_SORT
    importing
      !IV_COLUMNNAME type LVC_FNAME
      !IV_POSITION type I optional
      !IV_DESCENDING type SAP_BOOL default IF_SALV_C_BOOL_SAP=>FALSE
      !IV_SUBTOTAL type SAP_BOOL default IF_SALV_C_BOOL_SAP=>FALSE
      !IV_GROUP type SALV_DE_SORT_GROUP default IF_SALV_C_SORT=>GROUP_NONE
      !IV_OBLIGATORY type SAP_BOOL default IF_SALV_C_BOOL_SAP=>FALSE
    raising
      ZCX_SALV .
  methods ADD_SPECIFIC_GROUP
    importing
      !IV_ID type LVC_SPGRP
      !IV_TEXT type LVC_TEXT
    raising
      ZCX_SALV .
  methods ADD_TOOLTIP
    importing
      !IV_TYPE type SALV_DE_CONSTANT default CL_SALV_TOOLTIP=>C_TYPE_ICON
      !IV_VALUE type LVC_VALUE
      !IV_TOOLTIP type LVC_TIP optional
    raising
      ZCX_SALV .
  methods CREATE_CONTAINER
    importing
      !IV_CONTAINER_NAME type STRING
    returning
      value(RO_CONTAINER) type ref to CL_GUI_CONTAINER
    raising
      ZCX_SALV .
  methods ON_DOUBLE_CLICK
    for event DOUBLE_CLICK of CL_SALV_EVENTS_TABLE
    importing
      !ROW
      !COLUMN .
  methods ON_LINK_CLICK
    for event LINK_CLICK of CL_SALV_EVENTS_TABLE
    importing
      !ROW
      !COLUMN .
  methods ON_USER_COMMAND
    for event ADDED_FUNCTION of CL_SALV_EVENTS
    importing
      !E_SALV_FUNCTION .
  methods ON_DATA_CHANGED
    for event DATA_CHANGED of ZCL_SALV_MODEL
    importing
      !EO_DATA_CHANGED .
  methods ON_F4
    for event F4 of ZCL_SALV_MODEL
    importing
      !E_FIELDNAME
      !E_FIELDVALUE
      !ES_ROW_NO
      !ER_EVENT_DATA
      !ET_BAD_CELLS
      !E_DISPLAY .
ENDCLASS.



CLASS ZCL_SALV_TABLE IMPLEMENTATION.


METHOD add_aggregation.
  DATA lo_exception TYPE REF TO cx_salv_error.

  TRY.
      mo_aggregations->remove_aggregation( columnname  = iv_columnname ).

      mo_aggregations->add_aggregation( columnname  = iv_columnname
                                        aggregation = iv_aggregation ). "if_salv_c_aggregation=>maximum
      IF iv_top EQ if_salv_c_bool_sap=>true.
        mo_aggregations->set_aggregation_before_items( ).
      ENDIF.

    CATCH cx_salv_data_error
          cx_salv_not_found
          cx_salv_existing INTO lo_exception.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          error_text = |{ lo_exception->get_text( ) }|
          textid     = zcx_salv=>aggregation_error.
  ENDTRY.

ENDMETHOD.


METHOD add_column.
  DATA lo_exception TYPE REF TO cx_salv_error.

  TRY.

      IF iv_exception IS NOT INITIAL.
        mo_columns->set_exception_column( value = iv_columnname
                                          group = iv_exception_group ).
        RETURN.
      ENDIF.

      IF iv_entry_column IS NOT INITIAL.
        IF iv_type EQ if_salv_c_cell_type=>dropdown.
          mo_columns->set_dropdown_entry_column( iv_entry_column ).
        ELSEIF iv_type EQ if_salv_c_cell_type=>link.
          mo_columns->set_hyperlink_entry_column( iv_entry_column ).
        ENDIF.
      ENDIF.

      IF iv_column_position IS NOT INITIAL.
        mo_columns->set_column_position( columnname = iv_columnname
                                         position   = iv_column_position ).
      ENDIF.

      mo_column ?= mo_columns->get_column( iv_columnname ).
      mo_column->set_cell_type( iv_type ).

      IF iv_hide IS NOT INITIAL.
        mo_column->set_visible( if_salv_c_bool_sap=>false ).
      ENDIF.

      IF iv_fix IS NOT INITIAL.
        mo_columns->set_key_fixation( if_salv_c_bool_sap=>true ).
        mo_column->set_key( if_salv_c_bool_sap=>true ).
      ENDIF.

      IF iv_subtotal IS NOT INITIAL.
        mo_aggregations = mo_alv->get_aggregations( ).
        add_aggregation( iv_columnname ).
      ENDIF.

      IF iv_long_text IS NOT INITIAL.
        mo_column->set_long_text( iv_long_text ).
      ENDIF.

      IF iv_medium_text IS NOT INITIAL.
        mo_column->set_medium_text( iv_medium_text ).
      ENDIF.

      IF iv_short_text IS NOT INITIAL.
        mo_column->set_short_text( iv_short_text ).
      ENDIF.

      IF iv_tooltip IS NOT INITIAL.
        mo_column->set_tooltip( iv_tooltip ).
      ENDIF.

      IF iv_output_length IS NOT INITIAL.
        mo_column->set_output_length( iv_output_length ).
      ENDIF.

      IF iv_color IS NOT INITIAL.
        mo_column->set_color( iv_color ).
      ENDIF.

      IF iv_specific_group IS NOT INITIAL.
        mo_column->set_specific_group( iv_specific_group ).
      ENDIF.

      IF iv_icon IS NOT INITIAL.
        mo_column->set_icon( iv_icon ).
      ENDIF.

      IF iv_f4_reference IS NOT INITIAL.
        mo_column->set_ddic_reference( iv_f4_reference ).
      ENDIF.

      CASE abap_true.
        WHEN iv_f4.
          mo_column->set_f4( if_salv_c_bool_sap=>true ).
        WHEN iv_no_f4.
          mo_column->set_f4( if_salv_c_bool_sap=>false ).
      ENDCASE.

      IF iv_optimize IS NOT INITIAL.
        mo_column->set_optimized( if_salv_c_bool_sap=>true ).
      ENDIF.

    CATCH cx_salv_not_found
          cx_salv_data_error
          cx_salv_existing INTO lo_exception.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          error_text = |{ lo_exception->get_text( ) }|
          textid     = zcx_salv=>column_error.
  ENDTRY.

ENDMETHOD.


METHOD ADD_COLUMN_COLOR.
  DATA lo_exception TYPE REF TO cx_salv_error.

  CHECK iv_columnname IS NOT INITIAL.

  TRY.
      mo_columns->set_color_column( iv_columnname ).

    CATCH cx_salv_not_found
          cx_salv_data_error
          cx_salv_existing INTO lo_exception.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          error_text = |{ lo_exception->get_text( ) }|
          textid     = zcx_salv=>column_color_error.
  ENDTRY.

ENDMETHOD.


METHOD ADD_COLUMN_STYLE.
  DATA lo_exception TYPE REF TO cx_salv_error.

  CHECK iv_columnname IS NOT INITIAL.

  TRY.
      mo_columns->set_cell_type_column( iv_columnname ).

    CATCH cx_salv_not_found
          cx_salv_data_error
          cx_salv_existing INTO lo_exception.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          error_text = |{ lo_exception->get_text( ) }|
          textid     = zcx_salv=>column_style_error.
  ENDTRY.

ENDMETHOD.


METHOD ADD_COLUMN_TECHNICAL.
  DATA lo_exception TYPE REF TO cx_salv_error.

  TRY.
      mo_column ?= mo_columns->get_column( iv_columnname ).
      mo_column->set_technical( if_salv_c_bool_sap=>true ).

    CATCH cx_salv_not_found
          cx_salv_data_error
          cx_salv_existing INTO lo_exception.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          error_text = |{ lo_exception->get_text( ) }|
          textid     = zcx_salv=>technical_error.
  ENDTRY.

ENDMETHOD.


METHOD ADD_DROPDOWN.
  DATA lo_exception TYPE REF TO cx_salv_error.

  TRY.
      mo_dropdowns->remove_dropdown( handle   = iv_handle ).

      mo_dropdowns->add_dropdown( handle   = iv_handle
                                  t_values = it_values ).

    CATCH cx_salv_not_found
          cx_salv_existing
          cx_salv_data_error INTO lo_exception.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          error_text = |{ lo_exception->get_text( ) }|
          textid     = zcx_salv=>dropdown_error.
  ENDTRY.

ENDMETHOD.


METHOD ADD_FILTER.
  DATA lo_exception TYPE REF TO cx_salv_error.

  TRY.
      mo_filters->remove_filter( columnname = iv_columnname ).

      mo_filters->add_filter( columnname = iv_columnname
                              sign       = iv_sign
                              option     = iv_option
                              low        = iv_low
                              high       = iv_high ).

    CATCH cx_salv_not_found
          cx_salv_data_error
          cx_salv_existing INTO lo_exception.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          error_text = |{ lo_exception->get_text( ) }|
          textid     = zcx_salv=>filter_error.
  ENDTRY.

ENDMETHOD.


METHOD add_function.
  DATA lo_exception TYPE REF TO cx_salv_error.

  TRY.
      mo_functions = mo_alv->get_functions( ).

      IF mo_functions->is_item( iv_function ) EQ if_salv_c_bool_sap=>false.
        mo_functions->add_function( name     = iv_function
                                    icon     = iv_icon
                                    text     = iv_text
                                    tooltip  = iv_tooltip
                                    position = if_salv_c_function_position=>right_of_salv_functions ).
      ENDIF.

    CATCH cx_salv_wrong_call
          cx_salv_existing INTO lo_exception.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          error_text = |{ lo_exception->get_text( ) }|
          textid     = zcx_salv=>function_error.
  ENDTRY.

ENDMETHOD.


METHOD ADD_HYPERLINK.
  DATA lo_exception TYPE REF TO cx_salv_error.

  TRY.
      mo_hyperlinks->add_hyperlink( handle    = iv_handle
                                    hyperlink = iv_hyperlink ).

    CATCH cx_salv_not_found
          cx_salv_existing
          cx_salv_data_error INTO lo_exception.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          error_text = |{ lo_exception->get_text( ) }|
          textid     = zcx_salv=>hyperlink_error.
  ENDTRY.

ENDMETHOD.


METHOD add_sort.
  DATA lo_exception TYPE REF TO cx_salv_error.
  DATA lv_sequence TYPE salv_de_sort_sequence.

  IF iv_descending = if_salv_c_bool_sap=>true.
    lv_sequence = if_salv_c_sort=>sort_down.
  ELSE.
    lv_sequence = if_salv_c_sort=>sort_up.
  ENDIF.

  TRY.
      mo_sorts->remove_sort( columnname = iv_columnname ).

      mo_sorts->add_sort( columnname = iv_columnname
                          position   = iv_position
                          sequence   = lv_sequence
                          subtotal   = iv_subtotal
                          group      = iv_group
                          obligatory = iv_obligatory ).

    CATCH cx_salv_not_found
          cx_salv_existing
          cx_salv_data_error INTO lo_exception.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          error_text = |{ lo_exception->get_text( ) }|
          textid     = zcx_salv=>sort_error.
  ENDTRY.

ENDMETHOD.


METHOD ADD_SPECIFIC_GROUP.
  DATA lo_exception TYPE REF TO cx_salv_error.

  TRY.
      mo_specific_groups->add_specific_group( id   = iv_id
                                              text = iv_text ).

    CATCH cx_salv_not_found
          cx_salv_existing
          cx_salv_data_error INTO lo_exception.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          error_text = |{ lo_exception->get_text( ) }|
          textid     = zcx_salv=>specific_group_error.
  ENDTRY.

ENDMETHOD.


METHOD add_tooltip.
  DATA lo_exception TYPE REF TO cx_salv_error.

  TRY.
      mo_tooltips->remove_tooltip( type  = iv_type
                                   value = iv_value ).

      mo_tooltips->add_tooltip( type    = iv_type
                                value   = iv_value
                                tooltip = iv_tooltip ).

    CATCH cx_salv_not_found
          cx_salv_existing
          cx_salv_data_error INTO lo_exception.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          error_text = |{ lo_exception->get_text( ) }|
          textid     = zcx_salv=>tooltip_error.
  ENDTRY.

ENDMETHOD.


METHOD CHECK_CHANGED_DATA.

  IF mo_alv IS BOUND.
    zcl_salv_model=>get_reference( )->check_changed_data( mo_alv ).
  ENDIF.

ENDMETHOD.


METHOD create_container.

  CHECK iv_container_name IS NOT INITIAL.

  IF cl_salv_table=>is_offline( ) EQ if_salv_c_bool_sap=>false.
    ro_container = NEW cl_gui_custom_container( container_name = |{ iv_container_name }| ).

  ENDIF.

ENDMETHOD.


METHOD display.
  DATA ls_stable_refresh TYPE lvc_s_stbl.
  DATA lo_model TYPE REF TO zcl_salv_model.

  CASE mv_refresh.
    WHEN if_salv_c_bool_sap=>false.
      mo_alv->display( ).

    WHEN if_salv_c_bool_sap=>true.
      ls_stable_refresh-row = if_salv_c_bool_sap=>true.
      ls_stable_refresh-col = if_salv_c_bool_sap=>true.

      mo_alv->refresh( s_stable = ls_stable_refresh refresh_mode = if_salv_c_refresh=>full ).
  ENDCASE.
  cl_gui_cfw=>flush( ).

  IF mv_editable EQ if_salv_c_bool_sap=>true.
    lo_model = zcl_salv_model=>get_reference( ).

    lo_model->mo_data                = mo_data.
    lo_model->mo_parameters          = mo_editing.
    lo_model->mt_edited_fields       = mt_edited_fields.
    lo_model->mt_edited_f4           = mt_edited_f4.

    SET HANDLER on_data_changed FOR lo_model.
    SET HANDLER on_f4           FOR lo_model.

    lo_model->set_editable( io_salv     = mo_alv
                            i_edit_mode = mv_edit_mode ).
  ENDIF.

ENDMETHOD.


METHOD FREE.

  FREE: mo_data
        , mo_aggregations
        , mo_alv
        , mo_column
        , mo_columns
        , mo_container
        , mo_display_settings
        , mo_dropdowns
        , mo_error
        , mo_events
        , mo_exception
        , mo_filters
        , mo_functional_settings
        , mo_functions
        , mo_hyperlinks
        , mo_layout
        , mo_selections
        , mo_sorts
        , mo_specific_groups
        , mo_tooltips
        , mo_editing
        , mo_toolbar
        , mt_edited_fields
        , mt_edited_f4.

ENDMETHOD.


METHOD get_selected_rows.

  CHECK mo_alv IS BOUND.

  mo_selections = mo_alv->get_selections( ).
  mo_alv->get_metadata( ).

  rt_rows = mo_selections->get_selected_rows( ).

ENDMETHOD.


METHOD initialize.
  DATA lo_exception TYPE REF TO cx_salv_error.
  FIELD-SYMBOLS <ft_data> TYPE ANY TABLE.

  IF io_data IS NOT BOUND.
    RAISE EXCEPTION TYPE zcx_salv
      EXPORTING
        textid = zcx_salv=>data_error.
  ENDIF.

  mo_data = io_data.
  ASSIGN mo_data->* TO <ft_data>.
  IF <ft_data> IS NOT ASSIGNED.
    RAISE EXCEPTION TYPE zcx_salv
      EXPORTING
        textid = zcx_salv=>data_error.
  ENDIF.

  IF mo_alv IS NOT BOUND.
    IF io_container IS BOUND.
      mo_container = io_container.
    ELSEIF io_container IS NOT BOUND.
      mo_container = create_container( iv_container_name ).
    ENDIF.

    TRY.
        IF mo_container IS BOUND.
          cl_salv_table=>factory( EXPORTING r_container  = mo_container
                                            list_display = iv_list
                                  IMPORTING r_salv_table = mo_alv
                                  CHANGING  t_table      = <ft_data> ).
        ELSE.
          cl_salv_table=>factory( EXPORTING list_display = iv_list
                                  IMPORTING r_salv_table = mo_alv
                                  CHANGING  t_table      = <ft_data> ).
        ENDIF.

      CATCH cx_salv_msg INTO lo_exception.
        RAISE EXCEPTION TYPE zcx_salv
          EXPORTING
            error_text = |{ lo_exception->get_text( ) }|
            textid     = zcx_salv=>alv_error.
    ENDTRY.

    mv_refresh = if_salv_c_bool_sap=>false.
  ELSE.

    mv_refresh = if_salv_c_bool_sap=>true.
  ENDIF.

  ro_salv = me.

ENDMETHOD.


METHOD on_data_changed.

  RAISE EVENT data_changed_received
    EXPORTING
      eo_data_changed = eo_data_changed.

ENDMETHOD.


METHOD ON_DOUBLE_CLICK.
  DATA: lt_rows   TYPE salv_t_row,
        lt_cols   TYPE salv_t_column.

  IF row IS NOT INITIAL.
    APPEND row    TO lt_rows.
  ENDIF.
  IF column IS NOT INITIAL.
    APPEND column TO lt_cols.
  ENDIF.

  RAISE EVENT user_command_received
    EXPORTING e_user_command = cv_double_click
              et_row         = lt_rows
              et_column      = lt_cols.

ENDMETHOD.


METHOD on_f4.

  RAISE EVENT f4_received
    EXPORTING
      e_fieldname   = e_fieldname
      e_fieldvalue  = e_fieldvalue
      es_row_no     = es_row_no
      er_event_data = er_event_data
      et_bad_cells  = et_bad_cells
      e_display     = e_display.

ENDMETHOD.


METHOD ON_LINK_CLICK.
  DATA: lt_rows   TYPE salv_t_row,
        lt_cols   TYPE salv_t_column.

  IF row IS NOT INITIAL.
    APPEND row    TO lt_rows.
  ENDIF.
  IF column IS NOT INITIAL.
    APPEND column TO lt_cols.
  ENDIF.

  RAISE EVENT user_command_received
    EXPORTING e_user_command = cv_double_click
              et_row         = lt_rows
              et_column      = lt_cols.

ENDMETHOD.


METHOD on_user_command.
  DATA: lt_rows TYPE salv_t_row,
        lt_cols TYPE salv_t_column.

  mo_selections = mo_alv->get_selections( ).
  lt_rows = mo_selections->get_selected_rows( ).
  lt_cols = mo_selections->get_selected_columns( ).

  RAISE EVENT user_command_received
    EXPORTING e_user_command = e_salv_function
              et_row         = lt_rows
              et_column      = lt_cols.

ENDMETHOD.


METHOD refresh.
  DATA ls_stable_refresh TYPE lvc_s_stbl.

  CHECK mo_alv IS BOUND.

  ls_stable_refresh-row = if_salv_c_bool_sap=>true.
  ls_stable_refresh-col = if_salv_c_bool_sap=>true.

  mo_alv->refresh( s_stable = ls_stable_refresh ).

ENDMETHOD.


METHOD set_aggregations.
  DATA ls_aggregation LIKE LINE OF it_aggregation.

  IF mv_refresh EQ if_salv_c_bool_sap=>false.

    mo_aggregations = mo_alv->get_aggregations( ).

    LOOP AT it_aggregation INTO ls_aggregation.
      IF ls_aggregation-aggregation IS INITIAL.
        ls_aggregation-aggregation = if_salv_c_aggregation=>total.
      ENDIF.

      add_aggregation( iv_columnname  = ls_aggregation-columnname
                       iv_aggregation = ls_aggregation-aggregation
                       iv_top         = ls_aggregation-top ).
    ENDLOOP.

  ENDIF.

  ro_salv = me.

ENDMETHOD.


METHOD set_columns.
  FIELD-SYMBOLS <fs_column> LIKE LINE OF it_column.
  FIELD-SYMBOLS <fs_technical> LIKE LINE OF it_technical.
  FIELD-SYMBOLS <fs_edited_fields> LIKE LINE OF mt_edited_fields.
  FIELD-SYMBOLS <fs_edited_f4> LIKE LINE OF mt_edited_f4.

  mo_columns = mo_alv->get_columns( ).
  mo_columns->set_optimize( iv_optimize_width ).

  IF iv_color_column IS NOT INITIAL.
    add_column_color( iv_color_column ).
  ENDIF.

  IF iv_style_column IS NOT INITIAL.
    add_column_style( iv_style_column ).
  ENDIF.

  LOOP AT it_technical ASSIGNING <fs_technical>.
    add_column_technical( iv_columnname = <fs_technical>-columnname ).
  ENDLOOP.

  CLEAR: mt_edited_fields,
         mt_edited_f4.

  LOOP AT it_column ASSIGNING <fs_column>.
    add_column(
      iv_columnname      = <fs_column>-columnname
      iv_type            = <fs_column>-type
      iv_exception       = <fs_column>-exception
      iv_subtotal        = <fs_column>-subtotal
      iv_long_text       = <fs_column>-long_text
      iv_medium_text     = <fs_column>-medium_text
      iv_short_text      = <fs_column>-short_text
      iv_output_length   = <fs_column>-output_length
      iv_color           = <fs_column>-color
      iv_specific_group  = <fs_column>-specific_group
      iv_hide            = <fs_column>-hide
      iv_fix             = <fs_column>-fix
      iv_tooltip         = <fs_column>-tooltip
      iv_icon            = <fs_column>-icon
      iv_f4_reference    = <fs_column>-f4_reference
      iv_entry_column    = <fs_column>-entry_column
      iv_exception_group = <fs_column>-exception_group
      iv_optimize        = <fs_column>-optimize
      iv_column_position = <fs_column>-column_position ).

    IF <fs_column>-edit EQ if_salv_c_bool_sap=>true.
      APPEND INITIAL LINE TO mt_edited_fields ASSIGNING <fs_edited_fields>.
      MOVE-CORRESPONDING <fs_column> TO <fs_edited_fields>.

      IF <fs_column>-f4 EQ if_salv_c_bool_sap=>true.
        APPEND INITIAL LINE TO mt_edited_f4 ASSIGNING <fs_edited_f4>.
        MOVE-CORRESPONDING <fs_column> TO <fs_edited_f4>.
      ENDIF.
    ENDIF.
  ENDLOOP.

  ro_salv = me.

ENDMETHOD.


METHOD set_custom_functions.
  FIELD-SYMBOLS: <fs_user_command> LIKE LINE OF it_user_command.

  IF mv_refresh = if_salv_c_bool_sap=>false.

    LOOP AT it_user_command ASSIGNING <fs_user_command>.
      add_function( iv_function = <fs_user_command>-function
                    iv_icon     = |{ <fs_user_command>-icon }|
                    iv_text     = |{ <fs_user_command>-text }|
                    iv_tooltip  = |{ <fs_user_command>-quickinfo }| ).
    ENDLOOP.

  ENDIF.

  ro_salv = me.

ENDMETHOD.


METHOD set_display_settings.
  IF mv_refresh EQ if_salv_c_bool_sap=>false.

    mo_display_settings = mo_alv->get_display_settings( ).

    mo_display_settings->set_list_header( iv_title ).
    mo_display_settings->set_striped_pattern( iv_zebra ).

  ENDIF.

  ro_salv = me.

ENDMETHOD.


METHOD SET_DROPDOWNS.
  FIELD-SYMBOLS <fs_dropdown> LIKE LINE OF it_dropdown.

  CHECK it_dropdown[] IS NOT INITIAL.

  mo_functional_settings = mo_alv->get_functional_settings( ).
  mo_dropdowns = mo_functional_settings->get_dropdowns( ).

  LOOP AT it_dropdown ASSIGNING <fs_dropdown>.
    add_dropdown( iv_handle  = <fs_dropdown>-handle
                  it_values = <fs_dropdown>-values[] ).
  ENDLOOP.

  ro_salv = me.

ENDMETHOD.


METHOD set_editable.

  mv_editable            = if_salv_c_bool_sap=>true.
  mv_edit_mode           = iv_edit_mode.

  CASE iv_profile.
    WHEN cs_edit_tb_profile-none.
      set_parameters_editing(
        iv_group_copypast = if_salv_c_bool_sap=>false
        iv_row_check      = if_salv_c_bool_sap=>false
        iv_row_append     = if_salv_c_bool_sap=>false
        iv_row_insert     = if_salv_c_bool_sap=>false
        iv_row_delete     = if_salv_c_bool_sap=>false
        iv_row_copy       = if_salv_c_bool_sap=>false
        iv_show_text      = if_salv_c_bool_sap=>false
        ).
    WHEN cs_edit_tb_profile-minimum.
      set_parameters_editing(
        iv_group_copypast = if_salv_c_bool_sap=>false
        iv_row_check      = if_salv_c_bool_sap=>false
        iv_row_append     = if_salv_c_bool_sap=>false
        iv_row_insert     = if_salv_c_bool_sap=>true
        iv_row_delete     = if_salv_c_bool_sap=>true
        iv_row_copy       = if_salv_c_bool_sap=>false
        iv_show_text      = if_salv_c_bool_sap=>false
        ).
    WHEN cs_edit_tb_profile-minimum_text.
      set_parameters_editing(
        iv_group_copypast = if_salv_c_bool_sap=>false
        iv_row_check      = if_salv_c_bool_sap=>false
        iv_row_append     = if_salv_c_bool_sap=>true
        iv_row_insert     = if_salv_c_bool_sap=>true
        iv_row_delete     = if_salv_c_bool_sap=>true
        iv_row_copy       = if_salv_c_bool_sap=>false
        iv_show_text      = if_salv_c_bool_sap=>true
        ).
    WHEN cs_edit_tb_profile-default.
      set_parameters_editing(
        iv_group_copypast = if_salv_c_bool_sap=>true
        iv_row_check      = if_salv_c_bool_sap=>false
        iv_row_append     = if_salv_c_bool_sap=>true
        iv_row_insert     = if_salv_c_bool_sap=>true
        iv_row_delete     = if_salv_c_bool_sap=>true
        iv_row_copy       = if_salv_c_bool_sap=>false
        iv_show_text      = if_salv_c_bool_sap=>false
        ).
    WHEN cs_edit_tb_profile-default_text.
      set_parameters_editing(
        iv_group_copypast = if_salv_c_bool_sap=>true
        iv_row_check      = if_salv_c_bool_sap=>false
        iv_row_append     = if_salv_c_bool_sap=>true
        iv_row_insert     = if_salv_c_bool_sap=>true
        iv_row_delete     = if_salv_c_bool_sap=>true
        iv_row_copy       = if_salv_c_bool_sap=>false
        iv_show_text      = if_salv_c_bool_sap=>false
        ).
    WHEN cs_edit_tb_profile-maximum.
      set_parameters_editing(
        iv_group_copypast = if_salv_c_bool_sap=>true
        iv_row_check      = if_salv_c_bool_sap=>true
        iv_row_append     = if_salv_c_bool_sap=>true
        iv_row_insert     = if_salv_c_bool_sap=>true
        iv_row_delete     = if_salv_c_bool_sap=>true
        iv_row_copy       = if_salv_c_bool_sap=>true
        iv_show_text      = if_salv_c_bool_sap=>false
        ).
    WHEN cs_edit_tb_profile-maximum_text.
      set_parameters_editing(
        iv_group_copypast = if_salv_c_bool_sap=>true
        iv_row_check      = if_salv_c_bool_sap=>true
        iv_row_append     = if_salv_c_bool_sap=>true
        iv_row_insert     = if_salv_c_bool_sap=>true
        iv_row_delete     = if_salv_c_bool_sap=>true
        iv_row_copy       = if_salv_c_bool_sap=>true
        iv_show_text      = if_salv_c_bool_sap=>true
        ).
  ENDCASE.

  ro_salv = me.

ENDMETHOD.


METHOD set_end_of_page.
  DATA lo_footer TYPE REF TO cl_salv_form_layout_grid.

  lo_footer = io_footer->get_result( ).

  mo_alv->set_end_of_list( lo_footer ).
  mo_alv->set_end_of_list_print( lo_footer ).

  ro_salv = me.

ENDMETHOD.


METHOD SET_FILTERS.
  FIELD-SYMBOLS: <fs_filter> LIKE LINE OF it_filter.

  mo_filters = mo_alv->get_filters( ).

  LOOP AT it_filter ASSIGNING <fs_filter>.
    add_filter( iv_columnname = <fs_filter>-columnname
                iv_sign       = <fs_filter>-sign
                iv_option     = <fs_filter>-option
                iv_low        = <fs_filter>-low
                iv_high       = <fs_filter>-high ).
  ENDLOOP.

  ro_salv = me.

ENDMETHOD.


METHOD set_handlers.

  IF mv_refresh EQ if_salv_c_bool_sap=>false.

    mo_events = mo_alv->get_event( ).

    SET HANDLER on_user_command FOR mo_events.
    SET HANDLER on_double_click FOR mo_events.
    SET HANDLER on_link_click   FOR mo_events.

  ENDIF.

  ro_salv = me.

ENDMETHOD.


METHOD SET_HYPERLINKS.
  FIELD-SYMBOLS <fs_hyperlink> LIKE LINE OF it_hyperlink.

  CHECK it_hyperlink[] IS NOT INITIAL.

  mo_functional_settings = mo_alv->get_functional_settings( ).
  mo_hyperlinks = mo_functional_settings->get_hyperlinks( ).

  LOOP AT it_hyperlink ASSIGNING <fs_hyperlink>.
    add_hyperlink( iv_handle    = <fs_hyperlink>-handle
                   iv_hyperlink = <fs_hyperlink>-hyperlink ).
  ENDLOOP.

  ro_salv = me.

ENDMETHOD.


METHOD set_layout.
  DATA layout_key TYPE salv_s_layout_key.

  IF mv_refresh EQ if_salv_c_bool_sap=>false.

    layout_key-report = sy-cprog.

    mo_layout = mo_alv->get_layout( ).
    mo_layout->set_key( layout_key ).
    mo_layout->set_save_restriction( iv_restriction ).
    mo_layout->set_default( iv_default ).

    IF iv_variant IS NOT INITIAL.
      mo_layout->set_initial_layout( iv_variant ).
    ENDIF.

  ENDIF.

  ro_salv = me.

ENDMETHOD.


METHOD SET_PARAMETERS_EDITING.

  mo_editing = zcl_salv_editing=>get_reference( ).

  mo_editing->group_copypast = iv_group_copypast.
  mo_editing->row_check      = iv_row_check.
  mo_editing->row_append     = iv_row_append.
  mo_editing->row_insert     = iv_row_insert.
  mo_editing->row_delete     = iv_row_delete.
  mo_editing->row_copy       = iv_row_copy.
  mo_editing->show_text      = iv_show_text.

ENDMETHOD.


METHOD SET_PF_STATUS.
  DATA lo_exception TYPE REF TO cx_salv_no_check.

  TRY.
      mo_alv->set_screen_status(
        pfstatus      = iv_pfstatus
        report        = iv_report
        set_functions = iv_functions ).

    CATCH cx_salv_method_not_supported
          cx_salv_object_not_found INTO lo_exception.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          error_text = |{ lo_exception->get_text( ) }|
          textid     = zcx_salv=>pfstatus_error.
  ENDTRY.

  ro_salv = me.

ENDMETHOD.


METHOD SET_POPUP.
  DATA lo_exception TYPE REF TO cx_salv_no_check.

  TRY.
      mo_alv->set_screen_popup( start_column = iv_start_column
                                start_line   = iv_start_line
                                end_column   = iv_end_column
                                end_line     = iv_end_line ).

    CATCH cx_salv_method_not_supported INTO lo_exception.
      RAISE EXCEPTION TYPE zcx_salv
        EXPORTING
          error_text = |{ lo_exception->get_text( ) }|
          textid     = zcx_salv=>popup_error.
  ENDTRY.

  ro_salv = me.

ENDMETHOD.


METHOD set_selections.

  IF mv_refresh EQ if_salv_c_bool_sap=>false.

    mo_selections = mo_alv->get_selections( ).
    mo_selections->set_selection_mode( iv_mode ).

  ENDIF.

  ro_salv = me.

ENDMETHOD.


METHOD set_sorts.
  FIELD-SYMBOLS <fs_sort> LIKE LINE OF it_sort.

  IF mv_refresh EQ if_salv_c_bool_sap=>false.

    mo_sorts = mo_alv->get_sorts( ).

    LOOP AT it_sort ASSIGNING <fs_sort>.
      add_sort( iv_columnname = <fs_sort>-columnname
                iv_position   = <fs_sort>-position
                iv_descending = <fs_sort>-descending
                iv_subtotal   = <fs_sort>-subtotal
                iv_group      = <fs_sort>-group
                iv_obligatory = <fs_sort>-obligatory ).
    ENDLOOP.

  ENDIF.

  ro_salv = me.

ENDMETHOD.


METHOD SET_SPECIFIC_GROUPS.
  FIELD-SYMBOLS <fs_specific_group> LIKE LINE OF it_specific_group.

  mo_functional_settings = mo_alv->get_functional_settings( ).
  mo_specific_groups = mo_functional_settings->get_specific_groups( ).

  LOOP AT it_specific_group ASSIGNING <fs_specific_group>.
    add_specific_group( iv_id   = <fs_specific_group>-id
                        iv_text = <fs_specific_group>-text ).
  ENDLOOP.

  ro_salv = me.

ENDMETHOD.


METHOD set_standard_toolbar.

  IF mv_refresh EQ if_salv_c_bool_sap=>false.

    CASE iv_profile.
      WHEN cs_standart_tb_profile-minimum.
        set_toolbar(
          iv_abc_analysis         = if_salv_c_bool_sap=>false
          iv_aggregation_average  = if_salv_c_bool_sap=>false
          iv_aggregation_count    = if_salv_c_bool_sap=>false
          iv_aggregation_maximum  = if_salv_c_bool_sap=>false
          iv_aggregation_minimum  = if_salv_c_bool_sap=>false
          iv_aggregation_total    = if_salv_c_bool_sap=>false
          iv_default              = if_salv_c_bool_sap=>false
          iv_detail               = if_salv_c_bool_sap=>false
          iv_export_folder        = if_salv_c_bool_sap=>false
          iv_export_html          = if_salv_c_bool_sap=>false
          iv_export_localfile     = if_salv_c_bool_sap=>false
          iv_export_mail          = if_salv_c_bool_sap=>false
          iv_export_send          = if_salv_c_bool_sap=>false
          iv_export_spreadsheet   = if_salv_c_bool_sap=>false
          iv_export_wordprocessor = if_salv_c_bool_sap=>false
          iv_export_xml           = if_salv_c_bool_sap=>false
          iv_filter               = if_salv_c_bool_sap=>false
          iv_filter_delete        = if_salv_c_bool_sap=>false
          iv_find                 = if_salv_c_bool_sap=>false
          iv_find_more            = if_salv_c_bool_sap=>false
          iv_graphics             = if_salv_c_bool_sap=>false
          iv_group_aggregation    = if_salv_c_bool_sap=>false
          iv_group_export         = if_salv_c_bool_sap=>false
          iv_group_filter         = if_salv_c_bool_sap=>false
          iv_group_layout         = if_salv_c_bool_sap=>false
          iv_group_sort           = if_salv_c_bool_sap=>false
          iv_group_subtotal       = if_salv_c_bool_sap=>false
          iv_group_view           = if_salv_c_bool_sap=>false
          iv_layout_change        = if_salv_c_bool_sap=>false
          iv_layout_load          = if_salv_c_bool_sap=>false
          iv_layout_maintain      = if_salv_c_bool_sap=>false
          iv_layout_save          = if_salv_c_bool_sap=>false
          iv_print                = if_salv_c_bool_sap=>false
          iv_print_preview        = if_salv_c_bool_sap=>false
          iv_sort_asc             = if_salv_c_bool_sap=>true
          iv_sort_desc            = if_salv_c_bool_sap=>true
          iv_subtotals            = if_salv_c_bool_sap=>false
          iv_subtotals_outline    = if_salv_c_bool_sap=>false
          iv_view_crystal         = if_salv_c_bool_sap=>false
          iv_view_excel           = if_salv_c_bool_sap=>false
          iv_view_grid            = if_salv_c_bool_sap=>false
          iv_view_lotus           = if_salv_c_bool_sap=>false
          ).
      WHEN cs_standart_tb_profile-default.
        set_toolbar(
          iv_abc_analysis         = if_salv_c_bool_sap=>false
          iv_aggregation_average  = if_salv_c_bool_sap=>false
          iv_aggregation_count    = if_salv_c_bool_sap=>true
          iv_aggregation_maximum  = if_salv_c_bool_sap=>false
          iv_aggregation_minimum  = if_salv_c_bool_sap=>false
          iv_aggregation_total    = if_salv_c_bool_sap=>true
          iv_default              = if_salv_c_bool_sap=>true
          iv_detail               = if_salv_c_bool_sap=>false
          iv_export_folder        = if_salv_c_bool_sap=>false
          iv_export_html          = if_salv_c_bool_sap=>false
          iv_export_localfile     = if_salv_c_bool_sap=>false
          iv_export_mail          = if_salv_c_bool_sap=>false
          iv_export_send          = if_salv_c_bool_sap=>false
          iv_export_spreadsheet   = if_salv_c_bool_sap=>false
          iv_export_wordprocessor = if_salv_c_bool_sap=>false
          iv_export_xml           = if_salv_c_bool_sap=>false
          iv_filter               = if_salv_c_bool_sap=>true
          iv_filter_delete        = if_salv_c_bool_sap=>true
          iv_find                 = if_salv_c_bool_sap=>true
          iv_find_more            = if_salv_c_bool_sap=>true
          iv_graphics             = if_salv_c_bool_sap=>false
          iv_group_aggregation    = if_salv_c_bool_sap=>true
          iv_group_export         = if_salv_c_bool_sap=>false
          iv_group_filter         = if_salv_c_bool_sap=>true
          iv_group_layout         = if_salv_c_bool_sap=>true
          iv_group_sort           = if_salv_c_bool_sap=>true
          iv_group_subtotal       = if_salv_c_bool_sap=>true
          iv_group_view           = if_salv_c_bool_sap=>false
          iv_layout_change        = if_salv_c_bool_sap=>true
          iv_layout_load          = if_salv_c_bool_sap=>true
          iv_layout_maintain      = if_salv_c_bool_sap=>true
          iv_layout_save          = if_salv_c_bool_sap=>true
          iv_print                = if_salv_c_bool_sap=>false
          iv_print_preview        = if_salv_c_bool_sap=>false
          iv_sort_asc             = if_salv_c_bool_sap=>true
          iv_sort_desc            = if_salv_c_bool_sap=>true
          iv_subtotals            = if_salv_c_bool_sap=>true
          iv_subtotals_outline    = if_salv_c_bool_sap=>true
          iv_view_crystal         = if_salv_c_bool_sap=>false
          iv_view_excel           = if_salv_c_bool_sap=>false
          iv_view_grid            = if_salv_c_bool_sap=>false
          iv_view_lotus           = if_salv_c_bool_sap=>false
          ).
      WHEN cs_standart_tb_profile-with_export.
        set_toolbar(
          iv_abc_analysis         = if_salv_c_bool_sap=>false
          iv_aggregation_average  = if_salv_c_bool_sap=>false
          iv_aggregation_count    = if_salv_c_bool_sap=>true
          iv_aggregation_maximum  = if_salv_c_bool_sap=>false
          iv_aggregation_minimum  = if_salv_c_bool_sap=>false
          iv_aggregation_total    = if_salv_c_bool_sap=>true
          iv_default              = if_salv_c_bool_sap=>true
          iv_detail               = if_salv_c_bool_sap=>false
          iv_export_folder        = if_salv_c_bool_sap=>true
          iv_export_html          = if_salv_c_bool_sap=>true
          iv_export_localfile     = if_salv_c_bool_sap=>true
          iv_export_mail          = if_salv_c_bool_sap=>false
          iv_export_send          = if_salv_c_bool_sap=>false
          iv_export_spreadsheet   = if_salv_c_bool_sap=>true
          iv_export_wordprocessor = if_salv_c_bool_sap=>true
          iv_export_xml           = if_salv_c_bool_sap=>true
          iv_filter               = if_salv_c_bool_sap=>true
          iv_filter_delete        = if_salv_c_bool_sap=>true
          iv_find                 = if_salv_c_bool_sap=>true
          iv_find_more            = if_salv_c_bool_sap=>true
          iv_graphics             = if_salv_c_bool_sap=>false
          iv_group_aggregation    = if_salv_c_bool_sap=>true
          iv_group_export         = if_salv_c_bool_sap=>true
          iv_group_filter         = if_salv_c_bool_sap=>true
          iv_group_layout         = if_salv_c_bool_sap=>true
          iv_group_sort           = if_salv_c_bool_sap=>true
          iv_group_subtotal       = if_salv_c_bool_sap=>true
          iv_group_view           = if_salv_c_bool_sap=>false
          iv_layout_change        = if_salv_c_bool_sap=>true
          iv_layout_load          = if_salv_c_bool_sap=>true
          iv_layout_maintain      = if_salv_c_bool_sap=>true
          iv_layout_save          = if_salv_c_bool_sap=>true
          iv_print                = if_salv_c_bool_sap=>false
          iv_print_preview        = if_salv_c_bool_sap=>false
          iv_sort_asc             = if_salv_c_bool_sap=>true
          iv_sort_desc            = if_salv_c_bool_sap=>true
          iv_subtotals            = if_salv_c_bool_sap=>true
          iv_subtotals_outline    = if_salv_c_bool_sap=>true
          iv_view_crystal         = if_salv_c_bool_sap=>false
          iv_view_excel           = if_salv_c_bool_sap=>false
          iv_view_grid            = if_salv_c_bool_sap=>false
          iv_view_lotus           = if_salv_c_bool_sap=>false
          ).
      WHEN cs_standart_tb_profile-maximum.
        set_toolbar(
          iv_abc_analysis         = if_salv_c_bool_sap=>false
          iv_aggregation_average  = if_salv_c_bool_sap=>true
          iv_aggregation_count    = if_salv_c_bool_sap=>true
          iv_aggregation_maximum  = if_salv_c_bool_sap=>true
          iv_aggregation_minimum  = if_salv_c_bool_sap=>true
          iv_aggregation_total    = if_salv_c_bool_sap=>true
          iv_default              = if_salv_c_bool_sap=>true
          iv_detail               = if_salv_c_bool_sap=>false
          iv_export_folder        = if_salv_c_bool_sap=>true
          iv_export_html          = if_salv_c_bool_sap=>true
          iv_export_localfile     = if_salv_c_bool_sap=>true
          iv_export_mail          = if_salv_c_bool_sap=>false
          iv_export_send          = if_salv_c_bool_sap=>false
          iv_export_spreadsheet   = if_salv_c_bool_sap=>true
          iv_export_wordprocessor = if_salv_c_bool_sap=>true
          iv_export_xml           = if_salv_c_bool_sap=>true
          iv_filter               = if_salv_c_bool_sap=>true
          iv_filter_delete        = if_salv_c_bool_sap=>true
          iv_find                 = if_salv_c_bool_sap=>true
          iv_find_more            = if_salv_c_bool_sap=>true
          iv_graphics             = if_salv_c_bool_sap=>false
          iv_group_aggregation    = if_salv_c_bool_sap=>true
          iv_group_export         = if_salv_c_bool_sap=>true
          iv_group_filter         = if_salv_c_bool_sap=>true
          iv_group_layout         = if_salv_c_bool_sap=>true
          iv_group_sort           = if_salv_c_bool_sap=>true
          iv_group_subtotal       = if_salv_c_bool_sap=>true
          iv_group_view           = if_salv_c_bool_sap=>false
          iv_layout_change        = if_salv_c_bool_sap=>true
          iv_layout_load          = if_salv_c_bool_sap=>true
          iv_layout_maintain      = if_salv_c_bool_sap=>true
          iv_layout_save          = if_salv_c_bool_sap=>true
          iv_print                = if_salv_c_bool_sap=>true
          iv_print_preview        = if_salv_c_bool_sap=>true
          iv_sort_asc             = if_salv_c_bool_sap=>true
          iv_sort_desc            = if_salv_c_bool_sap=>true
          iv_subtotals            = if_salv_c_bool_sap=>true
          iv_subtotals_outline    = if_salv_c_bool_sap=>true
          iv_view_crystal         = if_salv_c_bool_sap=>false
          iv_view_excel           = if_salv_c_bool_sap=>false
          iv_view_grid            = if_salv_c_bool_sap=>false
          iv_view_lotus           = if_salv_c_bool_sap=>false
          ).
    ENDCASE.

    mo_functions = mo_alv->get_functions( ).
    mo_functions->set_default( mo_toolbar->default ).
    mo_functions->set_detail( mo_toolbar->detail ).
    mo_functions->set_abc_analysis( mo_toolbar->abc_analysis ).
    mo_functions->set_aggregation_average( mo_toolbar->aggregation_average ).
    mo_functions->set_aggregation_count( mo_toolbar->aggregation_count ).
    mo_functions->set_aggregation_maximum( mo_toolbar->aggregation_maximum ).
    mo_functions->set_aggregation_minimum( mo_toolbar->aggregation_minimum ).
    mo_functions->set_aggregation_total( mo_toolbar->aggregation_total ).
    mo_functions->set_export_folder( mo_toolbar->export_folder ).
    mo_functions->set_export_html( mo_toolbar->export_html ).
    mo_functions->set_export_localfile( mo_toolbar->export_localfile ).
    mo_functions->set_export_mail( mo_toolbar->export_mail ).
    mo_functions->set_export_send( mo_toolbar->export_send ).
    mo_functions->set_export_spreadsheet( mo_toolbar->export_spreadsheet ).
    mo_functions->set_export_wordprocessor( mo_toolbar->export_wordprocessor ).
    mo_functions->set_export_xml( mo_toolbar->export_xml ).
    mo_functions->set_filter( mo_toolbar->filter ).
    mo_functions->set_filter_delete( mo_toolbar->filter_delete ).
    mo_functions->set_group_aggregation( mo_toolbar->group_aggregation ).
    mo_functions->set_group_export( mo_toolbar->group_export ).
    mo_functions->set_group_filter( mo_toolbar->group_filter ).
    mo_functions->set_group_layout( mo_toolbar->group_layout ).
    mo_functions->set_group_sort( mo_toolbar->group_sort ).
    mo_functions->set_group_subtotal( mo_toolbar->group_subtotal ).
    mo_functions->set_group_view( mo_toolbar->group_view ).
    mo_functions->set_layout_change( mo_toolbar->layout_change ).
    mo_functions->set_layout_load( mo_toolbar->layout_load ).
    mo_functions->set_layout_maintain( mo_toolbar->layout_maintain ).
    mo_functions->set_layout_save( mo_toolbar->layout_save ).
    mo_functions->set_print( mo_toolbar->print ).
    mo_functions->set_print_preview( mo_toolbar->print_preview ).
    mo_functions->set_sort_asc( mo_toolbar->sort_asc ).
    mo_functions->set_sort_desc( mo_toolbar->sort_desc ).
    mo_functions->set_subtotals( mo_toolbar->subtotals ).
    mo_functions->set_subtotals_outline( mo_toolbar->subtotals_outline ).
    mo_functions->set_view_crystal( mo_toolbar->view_crystal ).
    mo_functions->set_view_excel( mo_toolbar->view_excel ).
    mo_functions->set_view_grid( mo_toolbar->view_grid ).
    mo_functions->set_view_lotus( mo_toolbar->view_lotus ).
    mo_functions->set_find( mo_toolbar->find ).
    mo_functions->set_find_more( mo_toolbar->find_more ).
    mo_functions->set_graphics( mo_toolbar->graphics ).

  ENDIF.

  ro_salv = me.

ENDMETHOD.


METHOD SET_TOOLBAR.

  mo_toolbar = zcl_salv_toolbar=>get_reference( ).

  mo_toolbar->abc_analysis         = iv_abc_analysis.
  mo_toolbar->aggregation_average  = iv_aggregation_average.
  mo_toolbar->aggregation_count    = iv_aggregation_count.
  mo_toolbar->aggregation_maximum  = iv_aggregation_maximum.
  mo_toolbar->aggregation_minimum  = iv_aggregation_minimum.
  mo_toolbar->aggregation_total    = iv_aggregation_total.
  mo_toolbar->default              = iv_default.
  mo_toolbar->detail               = iv_detail.
  mo_toolbar->export_folder        = iv_export_folder.
  mo_toolbar->export_html          = iv_export_html.
  mo_toolbar->export_localfile     = iv_export_localfile.
  mo_toolbar->export_mail          = iv_export_mail.
  mo_toolbar->export_send          = iv_export_send.
  mo_toolbar->export_spreadsheet   = iv_export_spreadsheet.
  mo_toolbar->export_wordprocessor = iv_export_wordprocessor.
  mo_toolbar->export_xml           = iv_export_xml.
  mo_toolbar->filter               = iv_filter.
  mo_toolbar->filter_delete        = iv_filter_delete.
  mo_toolbar->find                 = iv_find.
  mo_toolbar->find_more            = iv_find_more.
  mo_toolbar->graphics             = iv_graphics.
  mo_toolbar->group_aggregation    = iv_group_aggregation.
  mo_toolbar->group_export         = iv_group_export.
  mo_toolbar->group_filter         = iv_group_filter.
  mo_toolbar->group_layout         = iv_group_layout.
  mo_toolbar->group_sort           = iv_group_sort.
  mo_toolbar->group_subtotal       = iv_group_subtotal.
  mo_toolbar->group_view           = iv_group_view.
  mo_toolbar->layout_change        = iv_layout_change.
  mo_toolbar->layout_load          = iv_layout_load.
  mo_toolbar->layout_maintain      = iv_layout_maintain.
  mo_toolbar->layout_save          = iv_layout_save.
  mo_toolbar->print                = iv_print.
  mo_toolbar->print_preview        = iv_print_preview.
  mo_toolbar->sort_asc             = iv_sort_asc.
  mo_toolbar->sort_desc            = iv_sort_desc.
  mo_toolbar->subtotals            = iv_subtotals.
  mo_toolbar->subtotals_outline    = iv_subtotals_outline.
  mo_toolbar->view_crystal         = iv_view_crystal.
  mo_toolbar->view_excel           = iv_view_excel.
  mo_toolbar->view_grid            = iv_view_grid.
  mo_toolbar->view_lotus           = iv_view_lotus.

ENDMETHOD.


METHOD SET_TOOLTIPS.
  FIELD-SYMBOLS <fs_tooltip> LIKE LINE OF it_tooltip.

  mo_functional_settings = mo_alv->get_functional_settings( ).
  mo_tooltips = mo_functional_settings->get_tooltips( ).

  LOOP AT it_tooltip ASSIGNING <fs_tooltip>.
    add_tooltip( iv_type    = <fs_tooltip>-type
                 iv_value   = <fs_tooltip>-value
                 iv_tooltip = <fs_tooltip>-tooltip ).
  ENDLOOP.

  ro_salv = me.

ENDMETHOD.


METHOD set_top_of_page.
  DATA lo_header TYPE REF TO cl_salv_form_layout_grid.

  lo_header = io_header->get_result( ).

  mo_alv->set_top_of_list( lo_header ).
  mo_alv->set_top_of_list_print( lo_header ).

  ro_salv = me.

ENDMETHOD.
ENDCLASS.
