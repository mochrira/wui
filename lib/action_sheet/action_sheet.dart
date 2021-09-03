import 'package:flutter/material.dart';
import 'package:wui/themes/constants.dart';

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
          padding: EdgeInsets.fromLTRB(18, 20, 18, 12),
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20
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
    List<Widget>? actions,
    bool useRootNavigator = true
  }) {
    return showModalBottomSheet(context: context, 
      barrierColor: wuiDefaultBarrierColor,
      useRootNavigator: useRootNavigator,
      builder: (BuildContext context) {
        return WuiActionSheet(
          title: title,
          actions: actions
        );
      }
    );
  }
}