import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData theme() => ThemeData(
    brightness: Brightness.light,
    primaryColor: kPrimaryColor,
    colorScheme: ThemeData().colorScheme.copyWith(primary: kPrimaryColor),
    scaffoldBackgroundColor: kBacColor,
    fontFamily: FontFamilyText,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: WidgetStateProperty.all<TextStyle>(TextStyle(
                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal)),
            backgroundColor: WidgetStateProperty.all<Color>(kButtonColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(9)),
            )))));
