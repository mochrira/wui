import 'dart:async';

import 'package:example/pages/button/button_page.dart';
import 'package:flutter/material.dart';
import 'package:wui/wui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WuiConfig.addValue('apiURL', "https://api.laundry.wajek.id");

    return MaterialApp(
      title: 'Flutter Demo',
      theme: WuiDefaultTheme.light(context),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Map<String, dynamic>> items = [{
    "icon": Icon(Icons.wifi),
    "title": "Wireless Settings",
    "subtitle": "Turn on/off wireless adapter"
  }, {
    "icon": Icon(Icons.devices),
    "title": "Connected Devices",
    "subtitle": "Manage connection to connected devices"
  }, {
    "icon": Icon(Icons.bluetooth),
    "title": "Bluetooth Settings",
    "subtitle": "Manage bluetooth adapter"
  }];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: () {
            
            }
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, index) {
          if(index == items.length) {
            return WuiLoading();
          }

          return WuiListTile(
            title: Text(items[index]["title"] ?? ""),
            subtitle: Text(items[index]["subtitle"] ?? ""),
            leading: items[index]["icon"],
            trailing: Icon(Icons.chevron_right),
            borderMode: index == items.length - 1 ? 'none' : 'normal',
            onTap: () {
              WuiLoading.modal(context);
              Timer(Duration(seconds: 5), () {
                WuiLoading.close(context);
              });
              // showModalBottomSheet(context: context, builder: (BuildContext context) {
              //   return WuiActionSheet(
              //     title: Text(items[index]["title"]),
              //     actions: [
              //       WuiListTile(
              //         leading: Icon(Icons.edit),
              //         title: Text("Edit Wireless"),
              //         borderMode: 'normal',
              //         onTap: () {
              //           Navigator.of(context).pop();
              //           showDialog(
              //             context: context, 
              //             builder: (BuildContext context) => WuiModal(
              //               title: Text("Enter Your Device Name"),
              //               insetBody: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.stretch,
              //                 children: [
              //                   TextField(
              //                     decoration: InputDecoration(
              //                       hintText: "Alphanumeric [A-Z,0-9]",
              //                       labelText: "Nama Wireless"
              //                     ),
              //                   )
              //                 ],
              //               ),
              //               actions: [
              //                 WuiButton(
              //                   text: "BATAL",
              //                 ),
              //                 WuiButton(
              //                   text: "SIMPAN",
              //                 )
              //               ],
              //             )
              //           );
              //         },
              //       ),
              //       WuiListTile(
              //         leading: Icon(Icons.delete),
              //         title: Text("Delete Wireless"),
              //         onTap: () {

              //         },
              //       ),
              //       WuiListTile(
              //         title: Text("See Also"),
              //         onTap: () {

              //         },
              //       )
              //     ],
              //   );
              // });
            },
          );
        }, 
        itemCount: items.length + 1
      )
    );
  }
}
