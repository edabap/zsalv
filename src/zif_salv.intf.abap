INTERFACE zif_salv
  PUBLIC.

  CONSTANTS gc_layout_sel_mode_a     TYPE lvc_libox  VALUE 'A' ##NO_TEXT.
  CONSTANTS gc_display_save_a        TYPE char1      VALUE 'A' ##NO_TEXT.
  CONSTANTS gc_var_handle            TYPE slis_handl VALUE '1' ##NO_TEXT.
  CONSTANTS gc_ready_for_input_true  TYPE int4       VALUE '1' ##NO_TEXT.
  CONSTANTS gc_ready_for_input_false TYPE int4       VALUE '0' ##NO_TEXT.

ENDINTERFACE.
