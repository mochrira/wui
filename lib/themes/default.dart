import 'package:flutter/material.dart';
import 'package:wui/themes/constants.dart';

class WuiDefaultTheme {
  static ThemeData light(BuildContext context, { MaterialColor? primarySwatch }) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: primarySwatch ?? Colors.blue,
      textTheme: Theme.of(context).textTheme.copyWith(
        bodyText1: Theme.of(context).textTheme.bodyText1?.copyWith(
          fontWeight: FontWeight.w500,
          color: wuiDefaultTextColor,
          fontSize: 16,
          fontFamily: wuiDefaultFontFamily,
          height: 1.5
        ),
        bodyText2: Theme.of(context).textTheme.bodyText2?.copyWith(
          color: wuiDefaultTextColor,
          fontSize: wuiDefaultFontSize,
          fontFamily: wuiDefaultFontFamily,
          height: 1.5
        )
      ),
      iconTheme: Theme.of(context).iconTheme.copyWith(
        color: wuiDefaultTextColor
      )
    );
  }
}