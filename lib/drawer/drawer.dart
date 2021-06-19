import 'package:flutter/material.dart';

export './drawer_header.dart';
export './drawer_button.dart';
export './drawer_divider.dart';

class WuiDrawer extends StatelessWidget {

  final List<Widget>? children;

  const WuiDrawer({ 
    Key? key, 
    this.children
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: children != null ? ListView.builder(
        itemCount: children!.length,
        itemBuilder: (context, index) {
          return children![index];
        }
      ) : Container(),
    );
  }
}