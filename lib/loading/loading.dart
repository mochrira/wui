import 'package:flutter/material.dart';

class WuiLoading extends StatelessWidget {
  const WuiLoading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 32, minWidth: 32,
          maxHeight: 32, maxWidth: 32
        ),
        child: CircularProgressIndicator(
          strokeWidth: 3,
        ),
      )
      );
  }

  static bool canClose = false;

  static modal(context) {
    showDialog(context: context, builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return canClose;
        },
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                minHeight: 48, minWidth: 48,
                maxHeight: 48, maxWidth: 48
              ),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                color: Colors.white,
                boxShadow: [BoxShadow(
                  blurRadius: 16,
                  color: Colors.black12,
                  offset: Offset(0, 0)
                )]
              ),
              child: CircularProgressIndicator(
                strokeWidth: 3,
              )
            )
          )
        ),
      );
    }, barrierColor: Colors.black26);
  }

  static close(context) {
    canClose = true;
    Navigator.of(context).pop();
  }

}