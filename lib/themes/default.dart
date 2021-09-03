import 'package:flutter/material.dart';
import 'package:wui/themes/constants.dart';

class WuiDefaultTheme {
  static ThemeData light(BuildContext context, { MaterialColor? primarySwatch }) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: primarySwatch ?? Colors.blue,
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        textTheme: TextTheme(
          headline6: Theme.of(context).textTheme.headline6?.copyWith(
            fontWeight: FontWeight.w500,
            color: wuiDefaultTextColor,
            fontFamily: wuiDefaultFontFamily
          ),
        ),
        iconTheme: Theme.of(context).iconTheme.copyWith(
          color: wuiDefaultTextColor
        ),
        actionsIconTheme: Theme.of(context).iconTheme.copyWith(
          color: wuiDefaultTextColor
        ),
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
        bodyText1: Theme.of(context).textTheme.bodyText1?.copyWith(
          fontWeight: FontWeight.w500,
          color: wuiDefaultTextColor,
          fontSize: 16,
          fontFamily: wuiDefaultFontFamily
        ),
        bodyText2: Theme.of(context).textTheme.bodyText2?.copyWith(
          color: wuiDefaultTextColor,
          fontSize: wuiDefaultFontSize,
          fontFamily: wuiDefaultFontFamily
        )
      ),
      iconTheme: Theme.of(context).iconTheme.copyWith(
        color: wuiDefaultTextColor
      )
    );
  }
}