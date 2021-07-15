import 'package:flutter/material.dart';
import 'package:wui/button/button.dart';

class WuiDialog extends StatelessWidget {

  final String? title;
  final String? message;
  final List<String>? buttons;
  const WuiDialog({ Key? key, this.title, this.message, this.buttons }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...(title != null ? [Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: DefaultTextStyle(
              style: (Theme.of(context).textTheme.subtitle1 ?? TextStyle()).copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),
              child: Container(child: Text(title ?? "")),
            ),
          )] : []),
          ...(message != null ? [Container(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 20),
            child: DefaultTextStyle(
              style: (Theme.of(context).textTheme.bodyText2 ?? TextStyle()).copyWith(
                fontSize: 16
              ),
              child: Text(message ?? "")
            )
          )] : []),
          ...(buttons != null ? [Container(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: buttons!.asMap().map(
                (index, caption) => new MapEntry(index, 
                  WuiButton(
                    text: caption,
                    smooth: true,
                    onPressed: () {
                      Navigator.of(context).pop(index);
                    },
                  )
                )
              ).values.toList(),
            )
          )] : [])
        ],
      ),
    );
  }

  static Future<dynamic> open(BuildContext context, {
    required String title,
    required String message,
    required List<String> buttons
  }) {
    return showDialog(context: context, builder: (BuildContext context) {
      return WuiDialog(
        title: title,
        message: message,
        buttons: buttons
      );
    });
  }
}