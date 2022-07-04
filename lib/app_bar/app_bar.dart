import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wui/themes/constants.dart';

class WuiSliverAppBar extends StatefulWidget {

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;

  final Widget? flexibleTitle;
  final Widget? flexibleSubTitle;

  final bool? alwaysShowTitle;

  const WuiSliverAppBar({
    Key? key,
    this.leading,
    this.title,
    this.actions,

    this.flexibleTitle,
    this.flexibleSubTitle,

    this.alwaysShowTitle
  }) : super(key: key);

  @override
  State<WuiSliverAppBar> createState() => _WuiSliverAppBarState();
}

class _WuiSliverAppBarState extends State<WuiSliverAppBar> with SingleTickerProviderStateMixin{

  GlobalKey _sizeChangedKey = GlobalKey();
  double _opacity = 1;
  Timer? _sizeChangeDebounce;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200), animationBehavior: AnimationBehavior.normal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double paddingTop = MediaQuery.of(context).viewPadding.top + 64;
    double expandedHeight = MediaQuery.of(context).size.height / 2;
    bool alwaysShowTitle = widget.alwaysShowTitle ?? false;

    return SliverAppBar(      
      leading: widget.leading,
      title: alwaysShowTitle ? widget.title : AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _animationController.value,
            child: Transform.translate(
              offset: Offset(0, 24 - (_animationController.value * 24)),
              child: widget.title
            )
          );
        },
      ),
      actions: widget.actions,

      toolbarHeight: 64,
      collapsedHeight: 64,
      backgroundColor: Colors.white,
      elevation: 2,

      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: wuiColorHeading
      ),
      iconTheme: IconThemeData(
        color: wuiColorHeading
      ),
      actionsIconTheme: IconThemeData(
        color: wuiColorHeading
      ),

      pinned: true,
      expandedHeight: expandedHeight,
      flexibleSpace: NotificationListener<SizeChangedLayoutNotification>(
        onNotification: (SizeChangedLayoutNotification notification) {
          if(_sizeChangeDebounce != null) _sizeChangeDebounce!.cancel();
          _sizeChangeDebounce = Timer(Duration.zero, () {
            setState(() {
              double calc = (_sizeChangedKey.currentContext!.size!.height - paddingTop) / (expandedHeight - paddingTop);
              _opacity = calc > 1 ? 1 : (calc < 0 ? 0 : calc);
              if(!_animationController.isAnimating) {
                if(_opacity == 0) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
              }
            });
          });
          return true;
        },
        child: SizeChangedLayoutNotifier(
          key: _sizeChangedKey,
          child: Opacity(
            opacity: _opacity,
            child: Container(
              padding: EdgeInsets.only(top: paddingTop),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...(widget.flexibleTitle != null ? [
                      DefaultTextStyle(
                        child: widget.flexibleTitle!,
                        style: TextStyle(
                          fontSize: 32,
                          height: 1.5,
                          color: wuiColorHeading
                        )
                      )
                    ] : []),
                    ...(widget.flexibleSubTitle != null ? [
                      DefaultTextStyle(
                        child: widget.flexibleSubTitle!,
                        style: TextStyle(
                          height: 1.5,
                          color: wuiColorText
                        )
                      )
                    ] : [])
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WuiAppBar extends StatelessWidget implements PreferredSizeWidget{

  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;

  const WuiAppBar({
    Key? key,
    this.leading,
    this.actions,
    this.title
  }) : super(key: key);

  @override
  get preferredSize => Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title,
      actions: actions,

      toolbarHeight: 64,
      backgroundColor: Colors.white,
      elevation: 2,

      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: wuiColorHeading
      ),
      iconTheme: IconThemeData(
        color: wuiColorHeading
      ),
      actionsIconTheme: IconThemeData(
        color: wuiColorHeading
      )
    );
  }
}