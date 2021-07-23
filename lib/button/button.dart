import 'package:flutter/material.dart';

enum WuiButtonSize { large, normal }
enum WuiButtonIconPos { prefix, suffix }
enum WuiButtonTheme { normal, primary, danger }

class WuiButton extends StatelessWidget {

  final String? text;
  final IconData? icon;
  final WuiButtonIconPos? iconPos;
  final bool? iconOnly;

  final WuiButtonSize? size;
  final bool? rounded;
  final bool? smooth;
  final WuiButtonTheme? theme;
  final Function? onPressed;

  const WuiButton({ 
    Key? key, 
    this.text,
    this.icon,
    this.iconPos = WuiButtonIconPos.prefix,
    this.iconOnly,
    this.size = WuiButtonSize.normal,
    this.rounded = false,
    this.smooth = false,
    this.theme = WuiButtonTheme.normal,
    this.onPressed
  }) : super(key: key);

  double getMinheight() {
    return this.size == WuiButtonSize.normal ? 36 : 48;
  }

  double getFontSize() {
    return this.size == WuiButtonSize.normal ? 14 : 16;
  }

  EdgeInsets getPadding() {
    double horizontalPadding = 16;
    if(iconOnly == true) {
      horizontalPadding = (size == WuiButtonSize.normal ? 6 : 12);
    } else {
      if(rounded == true) {
        horizontalPadding = (size == WuiButtonSize.normal ? 24 : 32);
      } else {
        horizontalPadding = (size == WuiButtonSize.normal ? 16 : 24);
      }
    }
    return EdgeInsets.symmetric(horizontal: horizontalPadding);
  }

  BorderRadius getBorderRadius() {
    double radius = 4;
    if(iconOnly == true || rounded == true) {
      radius = (size == WuiButtonSize.normal ? 18 : 24);
    } else {
      radius = (size == WuiButtonSize.normal ? 4 : 8);
    }
    return BorderRadius.circular(radius);
  }

  Color getThemeColor(BuildContext context) {
    switch(theme) {
      case WuiButtonTheme.danger: return Color(0xFFDB2323);
      case WuiButtonTheme.primary: return Theme.of(context).primaryColor;
      default: return Colors.black.withOpacity(.04);
    }
  }

  Color getTextColor(BuildContext context) {
    if(smooth == true) {
      switch (theme) {
        case WuiButtonTheme.danger: return Color(0xFFDB2323);
        case WuiButtonTheme.primary: return Theme.of(context).primaryColor;
        default: return Colors.black.withOpacity(.67);
      }
    }

    switch (theme) {
      case WuiButtonTheme.danger:
      case WuiButtonTheme.primary: return Colors.white;
      default: return Colors.black.withOpacity(.67);
    }
  }

  Color getFillColor(BuildContext context) {
    return this.smooth == true ? Colors.transparent : getThemeColor(context);
  }

  Widget getIconSpacing() {
    return this.size == WuiButtonSize.normal ? SizedBox(width: 8) : SizedBox(width: 16);
  }

  Color getHighlightColor(BuildContext context) {
    if(smooth == true) {
      switch (theme) {
        case WuiButtonTheme.danger: return Color(0xFFDB2323).withOpacity(.12);
        case WuiButtonTheme.primary: return Theme.of(context).primaryColor.withOpacity(.12);
        default: return Colors.black.withOpacity(.08);
      }
    }
    
    switch (theme) {
      case WuiButtonTheme.danger:
      case WuiButtonTheme.primary: return Colors.white.withOpacity(.16);
      default: return Colors.black.withOpacity(.08);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onPressed != null ? 1 : .5,
      child: RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fillColor: getFillColor(context),
        highlightColor: getHighlightColor(context),
        splashColor: getHighlightColor(context),
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        padding: getPadding(),
        constraints: BoxConstraints(
          minHeight: getMinheight()
        ),
        shape: RoundedRectangleBorder(
          borderRadius: getBorderRadius()
        ),
        child: IconTheme(
          data: IconThemeData(
            color: getTextColor(context)
          ),
          child: DefaultTextStyle(
            style: (Theme.of(context).textTheme.button ?? TextStyle(
              fontSize: getFontSize(),
              fontWeight: FontWeight.w500
            )).copyWith(
              color: getTextColor(context)
            ),    
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // leading icon
                ...(icon != null ? (iconPos == WuiButtonIconPos.prefix ? 
                  [Icon(icon), ...((iconOnly ?? false) == false ? [getIconSpacing()] :[])] : [])
                 : []),

                // text
                ...(text != null && (iconOnly ?? false) == false ? [Text(text ?? '')] : []),

                // trailing icon
                ...(icon != null ? (iconPos == WuiButtonIconPos.suffix ? 
                  [...((iconOnly ?? false) == false ? [getIconSpacing()] :[]), Icon(icon)] : [])
                 : [])
              ],
            )
          ),
        ),
        onPressed: onPressed != null ? () {
          onPressed!();
        } : null
      ),
    );
  }
}