import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/theme/custom/appbar_theme.dart';
import 'package:rjs_store/core/utils/theme/custom/bottom_sheet_theme.dart';
import 'package:rjs_store/core/utils/theme/custom/chekbox_theme.dart';
import 'package:rjs_store/core/utils/theme/custom/chip_theme.dart';
import 'package:rjs_store/core/utils/theme/custom/elevated_button_theme_data.dart';
import 'package:rjs_store/core/utils/theme/custom/outlined_button_theme.dart';
import 'package:rjs_store/core/utils/theme/custom/text_field_theme.dart';
import 'package:rjs_store/core/utils/theme/custom/text_theme.dart';

class TAppTheme {
  // Declaring a private constructor
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TtextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipThemeData,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetThemeData,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutLinedButtonTheme.lightOutLinedButtonTheme,
    inputDecorationTheme: TtextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TtextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipThemeData,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetThemeData,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutLinedButtonTheme.darkOutlinedButtonThemeData,
    inputDecorationTheme: TtextFormFieldTheme.darkInputDecorationTheme,
  );
}
