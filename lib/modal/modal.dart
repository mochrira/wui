import 'package:flutter/material.dart';

class WuiModal extends StatelessWidget {

  final Widget? header;
  final Widget? insetContent;
  final Widget? content;
  final Widget? footer;
  const WuiModal({ Key? key, this.header, this.insetContent, this.content, this.footer }) : super(key: key);

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
          ...(header != null ? [Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: DefaultTextStyle(
              style: (Theme.of(context).textTheme.subtitle1 ?? TextStyle()).copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),
              child: Container(child: header),
            ),
          )] : []),
          ...(insetContent != null || content != null ? [Container(
            padding: (insetContent != null ? EdgeInsets.fromLTRB(24, 0, 24, 20) : EdgeInsets.all(0)),
            child: insetContent ?? content
          )] : []),
          ...(footer != null ? [Container(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 20),
            child: footer
          )] : []),
        ],
      ),
    );
  }

  static Future<dynamic> open(BuildContext context, {
    Widget? header,
    Widget? insetContent,
    Widget? content,
    Widget? footer
  }) {
    return showDialog(context: context, builder: (BuildContext context) {
      return WuiModal(
        header: header,
        insetContent: insetContent,
        content: content,
        footer: footer,
      );
    });
  }
}