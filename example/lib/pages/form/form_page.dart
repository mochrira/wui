import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wui/wui.dart';

class FormPage extends StatefulWidget {
  const FormPage({ Key? key }) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  String _tipe = "Bahan Baku";
  List<String> _tipeOptions = ["Bahan Baku", "Menu Resto"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: WuiDrawer(),
      appBar: AppBar(
        title: Text("Form Page"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            WuiFormField(
              labelText: "Nama Produk",
            ),
            
            WuiFormField(
              labelText: "Harga Jual",
              keyboardType: TextInputType.number,
            ),

            WuiStaticField(
              label: Text("Static Text"),
              value: Text("This is static text")
            ),

            WuiSelectField(
              label: Text("Tipe Produk"),
              optionTitle: Text("Pilih Tipe"),
              value: Text(_tipe),

              itemCount: _tipeOptions.length, 
              itemBuilder: (BuildContext context, int index) {
                return Text(_tipeOptions[index]);
              },

              activeIndex: _tipeOptions.indexOf(_tipe),
              onChange: (int index) {
                setState(() {
                  _tipe = _tipeOptions[index];
                });
              },
            ),

            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                child: WuiButton(
                  size: WuiButtonSize.large, 
                  rounded: true,
                  theme: WuiButtonTheme.primary,
                  text: "KIRIM FORMULIR",
                  onPressed: () async {
                    WuiLoading.open(context);
                    Timer(Duration(seconds: 5), () async {
                      WuiLoading.close(context);
                      await wuiShowDialog(context, (BuildContext context) => WuiModal(
                        header: Text("Modal Header")
                      ));
                    });
                  },
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}