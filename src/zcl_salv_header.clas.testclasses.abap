CLASS ltc_range_to_string DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_range,
        sign   TYPE c LENGTH 1,
        option TYPE c LENGTH 2,
        low    TYPE string,
        high   TYPE string,
      END OF ty_range,
      tty_range TYPE STANDARD TABLE OF ty_range WITH EMPTY KEY.

    METHODS formats_include_exclude_and_interval FOR TESTING.
    METHODS returns_initial_for_empty_input FOR TESTING.

ENDCLASS.



CLASS ltc_range_to_string IMPLEMENTATION.


  METHOD formats_include_exclude_and_interval.
    DATA lt_range TYPE tty_range.
    DATA lv_result TYPE string.

    lt_range = VALUE #(
      ( sign = 'I' option = 'EQ' low = '1000' )
      ( sign = 'E' option = 'EQ' low = '2000' )
      ( sign = 'I' option = 'BT' low = '3000' high = '3999' ) ).

    lv_result = zcl_salv_header=>range_to_string( lt_range ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_result
      exp = '1000, Excl. 2000, 3000 - 3999' ).
  ENDMETHOD.


  METHOD returns_initial_for_empty_input.
    DATA lt_range TYPE tty_range.

    cl_abap_unit_assert=>assert_initial(
      act = zcl_salv_header=>range_to_string( lt_range ) ).
  ENDMETHOD.


ENDCLASS.
