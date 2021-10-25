import 'package:flutter/material.dart';
import 'package:wui/themes/constants.dart';

enum WuiButtonSize { large, normal, small }
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
    return size == WuiButtonSize.small ? 32 : (size == WuiButtonSize.normal ? 48 : 64);
  }

  double getFontSize() {
    return size == WuiButtonSize.small ? 14 : (size == WuiButtonSize.normal ? 16 : 24);
  }

  EdgeInsets getPadding() {
    double horizontalPadding = 16;
    if(iconOnly == true) {
      horizontalPadding = (size == WuiButtonSize.normal ? 6 : 12);
    } else {
      if(rounded == true) {
        horizontalPadding = (size == WuiButtonSize.small ? 28 : (size == WuiButtonSize.normal ? 32 : 40));
      } else {
        horizontalPadding = (size == WuiButtonSize.small ? 14 : (size == WuiButtonSize.normal ? 24 : 32));
      }
    }
    return EdgeInsets.symmetric(horizontal: horizontalPadding);
  }

  BorderRadius getBorderRadius() {
    double radius = 4;
    if(iconOnly == true || rounded == true) {
      radius = size == WuiButtonSize.small ? 12 : (size == WuiButtonSize.normal ? 24 : 32);
    } else {
      radius = size == WuiButtonSize.small ? 4 : (size == WuiButtonSize.normal ? 8 : 12);
    }
    return BorderRadius.circular(radius);
  }

  Color getThemeColor(BuildContext context) {
    switch(theme) {
      case WuiButtonTheme.danger: return Color(0xFFDB2323);
      case WuiButtonTheme.primary: return Theme.of(context).primaryColor;
      default: return Colors.black.withOpacity(.1);
    }
  }

  Color getTextColor(BuildContext context) {
    if(smooth == true) {
      switch (theme) {
        case WuiButtonTheme.danger: return Color(0xFFDB2323);
        case WuiButtonTheme.primary: return Theme.of(context).primaryColor;
        default: return wuiDefaultTextColor;
      }
    }

    switch (theme) {
      case WuiButtonTheme.danger:
      case WuiButtonTheme.primary: return Colors.white;
      default: return wuiDefaultTextColor;
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
    return RawMaterialButton(
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
          style: (Theme.of(context).textTheme.button!.copyWith(
            fontSize: getFontSize(),
            fontWeight: FontWeight.w500,
            color: getTextColor(context)
          )),    
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
    );
  }
}

class GoogleButton extends StatelessWidget {

  final Function? onPressed;
  const GoogleButton({ Key? key, this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(
        minHeight: 64,
        minWidth: 64,
        maxHeight: 64,
        maxWidth: 64
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32)
      ),
      child: Image.asset('assets/images/google.png', 
        package: 'wui',
        width: 48,
        height: 48,
      ),
      onPressed: () {
        if(onPressed != null) {
          onPressed!();
        }
      },
    );
  }
}