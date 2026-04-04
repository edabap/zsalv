INTERFACE zif_salv_table_model
  PUBLIC.

  CONSTANTS cv_double_click TYPE salv_de_function VALUE '&IC1' ##NO_TEXT.
  CONSTANTS:
    BEGIN OF cs_standart_tb_profile,
      minimum     TYPE zsalv_d_standart_tb_profile VALUE '0',
      default     TYPE zsalv_d_standart_tb_profile VALUE '4',
      with_export TYPE zsalv_d_standart_tb_profile VALUE '5',
      maximum     TYPE zsalv_d_standart_tb_profile VALUE '9',
    END OF cs_standart_tb_profile.
  CONSTANTS:
    BEGIN OF cs_edit_tb_profile,
      none         TYPE zsalv_d_editing_tb_profile VALUE '0',
      minimum      TYPE zsalv_d_editing_tb_profile VALUE '1',
      minimum_text TYPE zsalv_d_editing_tb_profile VALUE '2',
      min_add      TYPE zsalv_d_editing_tb_profile VALUE '3',
      min_add_text TYPE zsalv_d_editing_tb_profile VALUE '4',
      default      TYPE zsalv_d_editing_tb_profile VALUE '5',
      default_text TYPE zsalv_d_editing_tb_profile VALUE '6',
      def_add      TYPE zsalv_d_editing_tb_profile VALUE '7',
      def_add_text TYPE zsalv_d_editing_tb_profile VALUE '8',
      maximum      TYPE zsalv_d_editing_tb_profile VALUE '9',
      maximum_text TYPE zsalv_d_editing_tb_profile VALUE 'A',
    END OF cs_edit_tb_profile.

  EVENTS user_command_received
    EXPORTING
      VALUE(e_user_command) TYPE salv_de_function OPTIONAL
      VALUE(et_row)         TYPE salv_t_row OPTIONAL
      VALUE(et_column)      TYPE salv_t_column OPTIONAL.
  EVENTS data_changed_received
    EXPORTING
      VALUE(eo_data_changed) TYPE REF TO cl_alv_changed_data_protocol.
  EVENTS f4_received
    EXPORTING
      VALUE(e_fieldname)   TYPE lvc_fname OPTIONAL
      VALUE(e_fieldvalue)  TYPE lvc_value OPTIONAL
      VALUE(es_row_no)     TYPE lvc_s_roid OPTIONAL
      VALUE(er_event_data) TYPE REF TO cl_alv_event_data OPTIONAL
      VALUE(et_bad_cells)  TYPE lvc_t_modi OPTIONAL
      VALUE(e_display)     TYPE char01 OPTIONAL.

  METHODS fill_aggregations DEFAULT IGNORE
    RETURNING
      VALUE(rt_aggregation) TYPE zsalv_tt_aggregation
    RAISING
      zcx_salv.
  METHODS fill_columns DEFAULT IGNORE
    RETURNING
      VALUE(rt_column) TYPE zsalv_tt_column
    RAISING
      zcx_salv.
  METHODS fill_custom_functions DEFAULT IGNORE
    RETURNING
      VALUE(rt_user_command) TYPE zsalv_tt_user_command
    RAISING
      zcx_salv.
  METHODS fill_data DEFAULT IGNORE
    RETURNING
      VALUE(ro_data) TYPE REF TO data.
  METHODS fill_dropdowns DEFAULT IGNORE
    RETURNING
      VALUE(rt_dropdown) TYPE zsalv_tt_dropdown
    RAISING
      zcx_salv.
  METHODS fill_technical_columns DEFAULT IGNORE
    RETURNING
      VALUE(rt_technical) TYPE zsalv_tt_technical.
  METHODS fill_end_of_page DEFAULT IGNORE
    RETURNING
      VALUE(ro_footer) TYPE REF TO zcl_salv_header
    RAISING
      zcx_salv.
  METHODS fill_filters DEFAULT IGNORE
    RETURNING
      VALUE(rt_filter) TYPE zsalv_tt_filter
    RAISING
      zcx_salv.
  METHODS fill_hyperlinks DEFAULT IGNORE
    RETURNING
      VALUE(rt_hyperlink) TYPE zsalv_tt_hyperlink
    RAISING
      zcx_salv.
  METHODS fill_sorts DEFAULT IGNORE
    RETURNING
      VALUE(rt_sort) TYPE zsalv_tt_sort
    RAISING
      zcx_salv.
  METHODS fill_specific_groups DEFAULT IGNORE
    RETURNING
      VALUE(rt_specific_group) TYPE zsalv_tt_specific_group
    RAISING
      zcx_salv.
  METHODS fill_tooltips DEFAULT IGNORE
    RETURNING
      VALUE(rt_tooltip) TYPE zsalv_tt_tooltip
    RAISING
      zcx_salv.
  METHODS fill_top_of_page DEFAULT IGNORE
    RETURNING
      VALUE(ro_header) TYPE REF TO zcl_salv_header
    RAISING
      zcx_salv.

ENDINTERFACE.
