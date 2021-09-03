import 'package:flutter/material.dart';
import 'package:wui/button/button.dart';
import 'package:wui/themes/constants.dart';

const wuiModalFooterButtonPadding = EdgeInsets.fromLTRB(16, 0, 16, 16);

class WuiModal extends StatelessWidget {

  final Widget? header;
  final Widget? insetContent;
  final Widget? content;
  final Widget? footer;
  final EdgeInsets? footerPadding;

  const WuiModal({ 
    Key? key, 
    this.header,
    this.insetContent,
    this.content,
    this.footer,
    this.footerPadding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: double.infinity,
          maxHeight: double.infinity
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 10,
              spreadRadius: 0,
              color: Colors.black.withOpacity(.14)
            ),
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 18,
              spreadRadius: 0,
              color: Colors.black.withOpacity(.12)
            ),
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 5,
              spreadRadius: -1,
              color: Colors.black.withOpacity(.20)
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...(header != null ? [Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 18),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 18
                ),
                child: Container(child: header),
              ),
            )] : []),
            ...(insetContent != null ? [Container(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 20),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyText2!,
                child: insetContent!
              )
            )] : []),
            ...(content != null ? [DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyText2!,
              child: content!
            )] : []),
            ...(footer != null ? [Container(
              padding: footerPadding != null ? footerPadding! : EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: footer!,
            )] : [])
          ],
        ),
      ),
    );
  }

  static Future<dynamic> open(BuildContext context, {
    Widget? header,
    Widget? insetContent,
    Widget? content,
    EdgeInsets? footerPadding,
    Widget? footer
  }) async {
    return await wuiShowDialog(context, (context) => WuiModal(
      header: header,
      insetContent: insetContent,
      content: content,
      footerPadding: footerPadding,
      footer: footer
    ));
  }
}

class WuiDialog {

  static Future<int?> open(BuildContext context, {
    required String title,
    required String message,
    required List<String> buttons,
    int? defaultIndex
  }) async {
    return await WuiModal.open(context, header: Text(title),
      insetContent: Text(message),
      footerPadding: wuiModalFooterButtonPadding,
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: List<Widget>.from(buttons.asMap().map((int index, String val) => MapEntry(index, WuiButton(
          text: val,
          smooth: true,
          size: WuiButtonSize.small,
          theme: defaultIndex == index ? WuiButtonTheme.primary : WuiButtonTheme.normal,
          onPressed: () {
            Navigator.of(context).pop(index);
          },
        ))).values.toList()),
      )
    );
  }

}

wuiShowDialog(BuildContext context, Widget Function(BuildContext context) builder) async {
  return await showGeneralDialog(
    context: context, 
    barrierColor: wuiDefaultBarrierColor,
    pageBuilder: (context, anim1, anim2) => builder(context),
    barrierDismissible: true,
    barrierLabel: "",
    transitionDuration: Duration(milliseconds: 200),
    transitionBuilder: (context, anim1, anim2, child) => Transform.scale(
      scale: anim1.value,
      child: Opacity(
        opacity: anim1.value,
        child: child
      )
    )
  );
}