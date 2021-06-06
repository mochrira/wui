import 'package:flutter/material.dart';

class WuiListTile extends StatelessWidget {

  final void Function()? onTap;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final String borderMode;

  WuiListTile({ Key? key, 
    this.onTap, 
    this.title, 
    this.subtitle,
    this.leading,
    this.trailing,
    this.borderMode = 'none'
  }) : super(key: key);

  final IconThemeData iconThemeData = IconThemeData(
    color: Colors.black87
  );

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Container(
        padding: EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: borderMode == 'full' ? BorderSide(
              color: Colors.black12
            ) : BorderSide.none
          )
        ),
        child: Row(
          crossAxisAlignment: subtitle == null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            ...(leading != null ? [
              Padding(
                padding: EdgeInsets.only(top: subtitle != null ? 16 : 0),
                child: Container(
                  width: 40, height: 40,
                  alignment: Alignment.centerLeft,
                  child: leading,
                ),
              ),
              SizedBox(width: 16),
            ] : []),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 16, bottom: 16, right: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: borderMode == 'normal' ? BorderSide(
                      color: Colors.black12
                    ) : BorderSide.none
                  )
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...(title != null ? [DefaultTextStyle(
                            style: (Theme.of(context).textTheme.subtitle1 ?? TextStyle(
                              fontSize: 16
                            )).copyWith(
                              color: Colors.black87
                            ), 
                            child: Container(
                              child: title
                            )
                          )] : []),
                          ...(subtitle != null ? [DefaultTextStyle(
                            style: (Theme.of(context).textTheme.bodyText2 ?? TextStyle(
                              fontSize: 14
                            )).copyWith(
                              color: Colors.black54
                            ), 
                            child: Container(
                              child: subtitle
                            )
                          )] : []),
                        ],
                      ),
                    ),
                    ...(trailing != null ? [
                      SizedBox(width: 16),
                      Container(
                        width: 40, height: 40,
                        alignment: Alignment.centerRight,
                        child: trailing,
                    )] : [])
                  ],
                ),
              )
            ),
          ],
        ),
      ),
      onPressed: onTap
    );
  }
}