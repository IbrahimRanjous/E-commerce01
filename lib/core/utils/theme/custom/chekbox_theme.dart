import 'package:flutter/material.dart';

class TCheckboxTheme {
  TCheckboxTheme._();

  // customizble light checkbox theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStateProperty.resolveWith(
      (state) {
        if (state.contains(WidgetState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      },
    ),
    fillColor: WidgetStateProperty.resolveWith(
      (state) {
        if (state.contains(WidgetState.selected)) {
          return Colors.blue;
        } else {
          return Colors.transparent;
        }
      },
    ),
  );
  // customizble dark checkbox theme
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStateProperty.resolveWith(
      (state) {
        if (state.contains(WidgetState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      },
    ),
    fillColor: WidgetStateProperty.resolveWith(
      (state) {
        if (state.contains(WidgetState.selected)) {
          return Colors.blue;
        } else {
          return Colors.transparent;
        }
      },
    ),
  );
}
