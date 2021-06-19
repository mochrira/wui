import 'package:flutter/material.dart';
import 'package:wui/wui.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({ Key? key }) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: WuiDrawer(
        children: [
          WuiDrawerHeader(
            avatarImage: NetworkImage('https://randomuser.me/api/portraits/men/43.jpg'),
            title: "Moch. Rizal Rachmadani",
            subTitle: "mochrira@gmail.com",
            expand: true,
            onPressed: () {},
          ),
          WuiDrawerButton(
            active: true,
            icon: Icons.home,
            text: "Dashboard",
          ),
          WuiDrawerDivider(
            line: false,
            labelText: "TRANSAKSI",
          ),
          WuiDrawerButton(
            icon: Icons.folder,
            text: "Top Up Saldo",
          )
        ],
      ),
      appBar: AppBar(),
    );
  }
}