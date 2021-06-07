import 'package:flutter/material.dart';

class WuiDefaultTheme {
  static ThemeData light(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          headline6: Theme.of(context).textTheme.headline6?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.black
          )
        ),
        iconTheme: IconThemeData(color: Colors.black87),
        actionsIconTheme: IconThemeData(color: Colors.black87),
      )
    );
  }
}