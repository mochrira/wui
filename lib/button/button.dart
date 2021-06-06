import 'package:flutter/material.dart';

class WuiButton extends StatelessWidget {

  final Widget? child;
  const WuiButton({ Key? key, this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      fillColor: Colors.black.withOpacity(.04),
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 16),
      constraints: BoxConstraints(
        minHeight: 36
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4)
      ),
      child: DefaultTextStyle(
        style: (Theme.of(context).textTheme.button ?? TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500
        )).copyWith(
          color: Colors.black87
        ),
        child: Container(
          child: child
        )
      ),
      onPressed: () {}
    );
  }
}