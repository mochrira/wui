import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wui/drawer/drawer.dart';
import 'package:wui/list_tile/list_tile.dart';
import 'package:wui/modal/modal.dart';
import 'package:wui/wui.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String, dynamic>> _items = [{
    "icon": Icon(Icons.wifi),
    "title": "Network",
    "subtitle": "Manage your device network connection"
  }, {
    "icon": Icon(Icons.security),
    "title": "Security",
    "subtitle": "Manage your device security"
  }, {
    "icon": Icon(Icons.apps),
    "title": "Apps",
    "subtitle": "Default apps, permission manager"
  }];

  _itemTap(BuildContext context, int index) async {
    int? res = await WuiDialog.open(context, 
      title: _items[index]["title"], 
      message: "Do you want to enter " + _items[index]["title"] + " settings for managing all available configuration?", 
      buttons: ["CANCEL", "YES, TAKE ME THERE"]
    );
  }

  _buttonPress(BuildContext context) {
    WuiLoading.open(context);
    Timer(Duration(seconds: 5), () {
      WuiLoading.close(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: WuiDrawer(),
      appBar: AppBar(
        title: Text("Settings"),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.refresh)
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _items.length + 5,
        itemBuilder: (BuildContext context, int index) {

          if(index == _items.length) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: WuiFormField(
                labelText: "Username",
                trailing: Icon(Icons.account_box)
              ),
            );
          }

          if(index == _items.length + 1) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: WuiFormField(
                labelText: "Email",
                placeholderText: "Pilih salah satu",
                readOnly: true,
                trailing: WuiButton(
                  iconOnly: true,
                  icon: Icons.arrow_drop_down,
                  smooth: true,
                  onPressed: () async {
                    await WuiActionSheet.open(context, 
                    title: Text("Pilih Email"),
                    actions: [
                      WuiListTile(
                        leading: Icon(Icons.radio_button_off),
                        title: Text("mochrira@gmail.com"),
                        onTap: () {},
                        borderMode: 'normal',
                      ),
                      WuiListTile(
                        leading: IconTheme(
                          data: IconThemeData(
                            color: Theme.of(context).primaryColor
                          ),
                          child: Icon(Icons.radio_button_on)
                        ),
                        title: Text("selviaja69@gmail.com"),
                        onTap: () {},
                      )
                    ]);
                  },
                ),
              ),
            );
          }

          if(index == _items.length + 2) {
            return Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: WuiButton(
                text: "KIRIM FORMULIR",
                size: WuiButtonSize.large,
                theme: WuiButtonTheme.primary,
                rounded: true,
                onPressed: () {
                  _buttonPress(context);
                },
              ),
            );
          }

          if(index == _items.length + 3) {
            return Padding(
              padding: EdgeInsets.only(top: 48),
              child: Center(
                child: WuiLoading()
              )
            );
          }

          if(index == _items.length + 4) {
            return Padding(
              padding: EdgeInsets.only(top: 48),
              child: Center(
                child: WuiButton(
                  iconOnly: true,
                  icon: Icons.refresh,
                  onPressed: () {},
                )
              )
            );
          }

          return WuiListTile(
            leading: _items[index]["icon"] as Icon,
            title: Text(_items[index]["title"].toString()),
            subtitle: Text(_items[index]["subtitle"].toString()),
            borderMode: index < _items.length - 1 ? 'normal' : 'none',
            onTap: () {
              _itemTap(context, index);
            },
          );
        }
      ),
    );
  }
}