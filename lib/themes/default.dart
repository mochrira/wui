import 'package:flutter/material.dart';
import 'package:wui/themes/constants.dart';

class WuiDefaultTheme {
  static ThemeData light(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        textTheme: TextTheme(
          headline6: Theme.of(context).textTheme.headline6?.copyWith(
            fontWeight: FontWeight.w500,
            color: defaultTextColor,
            fontFamily: defaultFontFamily
          ),
        ),
        iconTheme: Theme.of(context).iconTheme.copyWith(
          color: defaultTextColor
        ),
        actionsIconTheme: Theme.of(context).iconTheme.copyWith(
          color: defaultTextColor
        ),
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
        bodyText1: Theme.of(context).textTheme.bodyText1?.copyWith(
          fontWeight: FontWeight.w500,
          color: defaultTextColor,
          fontSize: 16,
          fontFamily: defaultFontFamily
        ),
        bodyText2: Theme.of(context).textTheme.bodyText2?.copyWith(
          color: defaultTextColor,
          fontSize: 14,
          fontFamily: defaultFontFamily
        )
      ),
      iconTheme: Theme.of(context).iconTheme.copyWith(
        color: defaultTextColor
      )
    );
  }
}