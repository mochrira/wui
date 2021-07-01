import 'package:flutter/material.dart';

class WuiLoading extends StatelessWidget {
  const WuiLoading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator()
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                color: Colors.white,
                boxShadow: [BoxShadow(
                  blurRadius: 16,
                  color: Colors.black12,
                  offset: Offset(0, 0)
                )]
              ),
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator()
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