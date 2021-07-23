import 'package:example/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:wui/wui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: WuiDefaultTheme.light(context),
      home: HomePage(),
    );
  }
}