import 'package:flutter/material.dart';

Color wuiColorInfo = Color.fromRGBO(207, 226, 255, 1);
Color wuiColorInfoBorder = Color.fromRGBO(182, 212, 254, 1);
Color wuiColorInfoText = Color.fromRGBO(8, 66, 152, 1);

class WuiAlertInfo extends StatelessWidget {

  final String? text;
  const WuiAlertInfo(this.text, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: wuiColorInfoBorder
        ),
        color: wuiColorInfo
      ),
      child: Text(text ?? "", style: TextStyle(
        color: wuiColorInfoText
      ))
    );
  }
}