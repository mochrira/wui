import 'package:flutter/material.dart';
import 'package:wui/action_sheet/action_sheet.dart';
import 'package:wui/button/button.dart';
import 'package:wui/dialog/dialog.dart';
import 'package:wui/list_tile/list_tile.dart';
import 'package:wui/modal/modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WuiListTile(
              leading: Icon(Icons.folder),
              title: Text("Bottom Sheet"),
              subtitle: Text("Open options for each rows"),
              onTap: () async {
                int? res = await WuiActionSheet.open(
                  context, 
                  title: Text("Bottom Sheet Title"),
                  actions: [
                    WuiListTile(
                      leading: Icon(Icons.edit),
                      title: Text("Edit Selected Row"),
                      borderMode: 'normal',
                      onTap: () {
                        Navigator.of(context).pop(1);
                      },
                    ),
                    WuiListTile(
                      leading: Icon(Icons.delete),
                      title: Text("Delete Selected Row"),
                      onTap: () async {
                        Navigator.of(context).pop(2);
                      },
                    )
                  ]
                );

                if(res == 1) {
                  dynamic resEdit = await WuiModal.open(
                    context, 
                    header: Text("Edit Record"),
                    insetContent: TextField(
                      decoration: InputDecoration(
                        labelText: "Name"
                      ),
                    ),
                    footer: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WuiButton(
                          smooth: true,
                          text: "BATAL",
                          onPressed: () {
                            Navigator.of(context).pop("BATAL");
                          },
                        ),
                        WuiButton(
                          theme: WuiButtonTheme.primary,
                          text: "SIMPAN",
                          onPressed: () {
                            Navigator.of(context).pop("SIMPAN");
                          },
                        )
                      ],
                    )
                  );
                  print(resEdit);
                }

                if(res == 2) {
                  int? resDialog = await WuiDialog.open(context, 
                    title: "Error",
                    message: "Unknown field pasien.noPasien on where clause",
                    buttons: ["BATAL", "HAPUS"]
                  );
                  print(resDialog);
                }
              },
            )
          ],
        )
      ),
    );
  }
}