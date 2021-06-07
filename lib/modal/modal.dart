import 'package:flutter/material.dart';

class WuiModal extends StatelessWidget {

  final Widget? title;
  final Widget? insetBody;
  final Widget? body;
  final List<Widget>? actions;
  const WuiModal({ Key? key, this.title, this.insetBody, this.body, this.actions }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...(title != null ? [Container(
            padding: EdgeInsets.all(16),
            child: DefaultTextStyle(
              style: (Theme.of(context).textTheme.subtitle1 ?? TextStyle(
                fontSize: 16
              )).copyWith(
                fontWeight: FontWeight.w500
              ),
              child: Container(child: title),
            ),
          )] : []),
          ...[Container(
            padding: (insetBody != null ? EdgeInsets.fromLTRB(16, 0, 16, 16) : EdgeInsets.all(0)),
            child: insetBody ?? body
          )],
        ],
      ),
    );
  }
}