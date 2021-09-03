import 'package:flutter/material.dart';
import 'package:wui/button/button.dart';
import 'package:wui/form_field/form_field.dart';

class KontakFormPage extends StatefulWidget {
  const KontakFormPage({ Key? key }) : super(key: key);

  @override
  _KontakFormPageState createState() => _KontakFormPageState();
}

class _KontakFormPageState extends State<KontakFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Kontak")
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            WuiFormField(
              labelText: "Nama Kontak",
              autoFocus: true,
            ),
            WuiFormField(
              inputPrefix: Text("+62"),
              labelText: "Nomor Handphone",
              keyboardType: TextInputType.number,
            )
          ],
        )
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: WuiButton(
          text: "Simpan Kontak",
          theme: WuiButtonTheme.primary,
          onPressed: () {
            
          },
        )
      ),
    );
  }
}