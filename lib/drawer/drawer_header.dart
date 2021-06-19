import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WuiDrawerHeader extends StatelessWidget {

  final ImageProvider? avatarImage;
  final String? title;
  final String? subTitle;
  final bool? expand;
  final Function? onPressed;

  const WuiDrawerHeader({ 
    Key? key, 
    this.avatarImage,
    this.title,
    this.subTitle,
    this.expand = false,
    this.onPressed
  }) : super(key: key);

  EdgeInsets getButtonPadding() {
    return (onPressed != null ? EdgeInsets.fromLTRB(24, 0, 16, 0) : EdgeInsets.symmetric(horizontal: 24));
  }

  Widget getIcon() {
    return (expand == true ? Icon(Icons.arrow_drop_up_rounded, size: 32) : Icon(Icons.arrow_drop_down_rounded, size: 32));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...(
          avatarImage != null ? [
            Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, (title != null || subTitle != null) ? 8 : 16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: avatarImage!,
                    radius: 32,
                    backgroundColor: Colors.black.withOpacity(.12),
                  ),
                  Expanded(child: Container())
                ],
              ),
            )
          ] : []
        ),
        ...(
          title != null || subTitle != null ? [
            RawMaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: getButtonPadding(),
              constraints: BoxConstraints(
                minHeight: 64
              ),
              child: IconTheme(
                data: IconThemeData(
                  color: Colors.black.withOpacity(.67)
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black.withOpacity(.67)
                  ),
                  overflow: TextOverflow.ellipsis,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ...(
                              title != null ? [
                                Text(title ?? '', style: TextStyle(
                                  fontSize: 16
                                ))
                              ] : []
                            ),
                            ...(
                              subTitle != null ? [
                                Text(subTitle ?? '', style: TextStyle(
                                  fontSize: 14
                                ))
                              ] : []
                            )
                          ],
                        ),
                      ),
                      ...(onPressed != null ? [
                        getIcon()
                      ] : [])
                    ],
                  ),
                ),
              ),
              onPressed: onPressed != null ? () {
                onPressed!();
              } : null
            ),
            SizedBox(height: 16)
          ] : []
        )
      ],
    );
  }
}