import 'package:flutter/material.dart';

class WuiActionSheet extends StatelessWidget {

  final Widget? title;
  final List<Widget>? actions;
  const WuiActionSheet({ Key? key, this.title, this.actions }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...(title != null ? [Container(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: DefaultTextStyle(
            style: (Theme.of(context).textTheme.subtitle1 ?? TextStyle(
              fontSize: 20
            )).copyWith(
              fontWeight: FontWeight.w500
            ),
            child: title ?? Container(),
          ),
        )] : []),
        ...(actions ?? [])
      ],
    );
  }

  static Future<dynamic> open(BuildContext context, {
    Widget? title,
    List<Widget>? actions
  }) {
    return showModalBottomSheet(context: context, builder: (BuildContext context) {
      return WuiActionSheet(
        title: title,
        actions: actions
      );
    });
  }
}