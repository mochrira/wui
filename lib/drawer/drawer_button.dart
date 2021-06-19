import 'package:flutter/material.dart';

class WuiDrawerButton extends StatelessWidget {

  final String? text;
  final IconData? icon;
  final Function? onPressed;
  final bool? active;

  const WuiDrawerButton({ 
    Key? key, 
    this.onPressed,
    this.text,
    this.icon,
    this.active = false
  }) : super(key: key);

  Color getTextColor(BuildContext context) {
    return active == true ? Theme.of(context).primaryColor : Colors.black.withOpacity(.67);
  }

  Color getFillColor(BuildContext context) {
    return active == true ? Theme.of(context).primaryColor.withOpacity(.12) : Colors.transparent;
  }

  Color getHighlightColor(BuildContext context) {
    return active == true ? Theme.of(context).primaryColor.withOpacity(.12) : Colors.black.withOpacity(.08);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24), 
            bottomRight: Radius.circular(24)
          )
        ),
        hoverColor: getHighlightColor(context),
        highlightColor: getHighlightColor(context),
        splashColor: getHighlightColor(context),
        fillColor: getFillColor(context),
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(horizontal: 24),
        constraints: BoxConstraints(
          minHeight: 48
        ),
        onPressed: () {
          onPressed!();
        },
        child: IconTheme(
          data: IconThemeData(
            color: getTextColor(context)
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: getTextColor(context)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...(icon != null ? [Icon(icon!), SizedBox(width: 24)] : []),
                Text(text ?? ''),
              ],
            )
          ),
        ),
      ),
    );
  }
}