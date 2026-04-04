CLASS zcl_salv_toolbar DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES zif_salv_toolbar.

    CLASS-METHODS class_constructor.
    CLASS-METHODS get_reference
      RETURNING
        VALUE(result) TYPE REF TO zif_salv_toolbar.

  PROTECTED SECTION.

  PRIVATE SECTION.

    ALIASES abc_analysis         FOR zif_salv_toolbar~abc_analysis.
    ALIASES aggregation_average  FOR zif_salv_toolbar~aggregation_average.
    ALIASES aggregation_count    FOR zif_salv_toolbar~aggregation_count.
    ALIASES aggregation_maximum  FOR zif_salv_toolbar~aggregation_maximum.
    ALIASES aggregation_minimum  FOR zif_salv_toolbar~aggregation_minimum.
    ALIASES aggregation_total    FOR zif_salv_toolbar~aggregation_total.
    ALIASES default              FOR zif_salv_toolbar~default.
    ALIASES detail               FOR zif_salv_toolbar~detail.
    ALIASES export_folder        FOR zif_salv_toolbar~export_folder.
    ALIASES export_html          FOR zif_salv_toolbar~export_html.
    ALIASES export_localfile     FOR zif_salv_toolbar~export_localfile.
    ALIASES export_mail          FOR zif_salv_toolbar~export_mail.
    ALIASES export_send          FOR zif_salv_toolbar~export_send.
    ALIASES export_spreadsheet   FOR zif_salv_toolbar~export_spreadsheet.
    ALIASES export_wordprocessor FOR zif_salv_toolbar~export_wordprocessor.
    ALIASES export_xml           FOR zif_salv_toolbar~export_xml.
    ALIASES filter               FOR zif_salv_toolbar~filter.
    ALIASES filter_delete        FOR zif_salv_toolbar~filter_delete.
    ALIASES find                 FOR zif_salv_toolbar~find.
    ALIASES find_more            FOR zif_salv_toolbar~find_more.
    ALIASES graphics             FOR zif_salv_toolbar~graphics.
    ALIASES group_aggregation    FOR zif_salv_toolbar~group_aggregation.
    ALIASES group_export         FOR zif_salv_toolbar~group_export.
    ALIASES group_filter         FOR zif_salv_toolbar~group_filter.
    ALIASES group_layout         FOR zif_salv_toolbar~group_layout.
    ALIASES group_sort           FOR zif_salv_toolbar~group_sort.
    ALIASES group_subtotal       FOR zif_salv_toolbar~group_subtotal.
    ALIASES group_view           FOR zif_salv_toolbar~group_view.
    ALIASES layout_change        FOR zif_salv_toolbar~layout_change.
    ALIASES layout_load          FOR zif_salv_toolbar~layout_load.
    ALIASES layout_maintain      FOR zif_salv_toolbar~layout_maintain.
    ALIASES layout_save          FOR zif_salv_toolbar~layout_save.
    ALIASES print                FOR zif_salv_toolbar~print.
    ALIASES print_preview        FOR zif_salv_toolbar~print_preview.
    ALIASES sort_asc             FOR zif_salv_toolbar~sort_asc.
    ALIASES sort_desc            FOR zif_salv_toolbar~sort_desc.
    ALIASES subtotals            FOR zif_salv_toolbar~subtotals.
    ALIASES subtotals_outline    FOR zif_salv_toolbar~subtotals_outline.
    ALIASES view_crystal         FOR zif_salv_toolbar~view_crystal.
    ALIASES view_excel           FOR zif_salv_toolbar~view_excel.
    ALIASES view_grid            FOR zif_salv_toolbar~view_grid.
    ALIASES view_lotus           FOR zif_salv_toolbar~view_lotus.

    CLASS-DATA mo_salv_toolbar TYPE REF TO zcl_salv_toolbar.

ENDCLASS.



CLASS zcl_salv_toolbar IMPLEMENTATION.


  METHOD class_constructor.

    mo_salv_toolbar = NEW #( ).

  ENDMETHOD.


  METHOD get_reference.

    result = mo_salv_toolbar.

  ENDMETHOD.


ENDCLASS.
