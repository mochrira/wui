import 'package:flutter/material.dart';
import 'package:wui/modal/modal.dart';

class WuiLoading extends StatelessWidget {
  const WuiLoading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28, height: 28,
      child: CircularProgressIndicator(
        strokeWidth: 3,
      ),
    );
  }

  static bool _show = false;
  static bool _canClose = false;

  static open(context) {
    if(_show) return;

    _show = true;
    _canClose = false;
    wuiShowDialog(context, (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return _canClose;
          },
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Center(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(.14),
                    offset: Offset(0, 4),
                    blurRadius: 5,
                    spreadRadius: 0,
                  ), BoxShadow(
                    color: Colors.black.withOpacity(.12),
                    offset: Offset(0, 1),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ), BoxShadow(
                    color: Colors.black.withOpacity(.20),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    spreadRadius: -1,
                  )]
                ),
                child: Center(
                  child: Container(
                    width: 28, height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                )
              )
            )
          ),
        );
      }
    );
  }

  static close(context) {
    if(_show) {
      _canClose = true;
      _show = false;
      Navigator.of(context).pop();
    }
  }

}