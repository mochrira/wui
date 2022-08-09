import 'package:example/pages/kontak/kontak_page.dart';
import 'package:flutter/material.dart';
import 'package:wui/wui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WuiConfig.addValue('apiURL', 'http://localhost:8084/');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: WuiDefaultTheme.light(context),
      home: KontakPage(),
    );
  }
}