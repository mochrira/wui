import 'package:flutter/material.dart';
import 'package:wui/themes/constants.dart';

class WuiStaticField extends StatelessWidget {

  final Widget? label;
  final Widget? inputSuffix;
  final Widget? inputPrefix;
  final Widget? leading;
  final Widget? trailing;
  final Widget? value;
  final void Function()? onTap;

  const WuiStaticField({ 
    Key? key ,
    this.label,
    this.inputSuffix,
    this.inputPrefix,
    this.leading,
    this.trailing,
    this.value,
    this.onTap
  }) : super(key: key);

  get _hasContent {
    return this.value != null;
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        child: Builder(
          builder: (BuildContext context) {
            FocusNode focusNode = Focus.of(context);
            bool hasFocus = focusNode.hasFocus;

            return Container(
              padding: EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: () {
                  if(!hasFocus) {
                    focusNode.requestFocus();
                  }

                  if(onTap != null) {
                    onTap!();
                  }
                },
                child: Container(
                  child: Stack(
                    children: [
                    
                      // main container
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...(leading != null ? [Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: leading!
                          )] : []),
                    
                          Expanded(
                            child: Stack(
                              children: [
                                // label
                                AnimatedPositioned(
                                  top: _hasContent || hasFocus ? 4 : 20,
                                  child: AnimatedDefaultTextStyle(
                                    duration: Duration(milliseconds: 200),
                                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: hasFocus || _hasContent ? 12 : 16,
                                      color: hasFocus ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyText2!.color
                                    ),
                                    child: label ?? Text(""),
                                  ), 
                                  duration: Duration(milliseconds: 200)
                                ),
                    
                                // editable text
                                Container(
                                  padding: const EdgeInsets.only(top: 8, bottom: 0),
                                  width: double.infinity,
                                  height: 56,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ...(inputPrefix != null ? [AnimatedOpacity(
                                        duration: Duration(milliseconds: 200),
                                        opacity: hasFocus || _hasContent ? 1 : 0,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: DefaultTextStyle(
                                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                              fontSize: 16,
                                              height: 1.125
                                            ),
                                            child: inputPrefix!
                                          )
                                        ),
                                      )] : []),
                    
                                      Expanded(
                                        child: Opacity(
                                          opacity: (_hasContent || hasFocus ? 1 : 0),
                                          child: DefaultTextStyle(
                                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                              fontSize: 16,
                                              height: 1.125,
                                              color: Colors.black87
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 8),
                                              child: value ?? Text("")
                                            ),
                                          ),
                                        ),
                                      ),
                    
                                      ...(inputSuffix != null ? [AnimatedOpacity(
                                        duration: Duration(milliseconds: 200),
                                        opacity: hasFocus || _hasContent ? 1 : 0,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: DefaultTextStyle(
                                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                              fontSize: 16,
                                              height: 1.125
                                            ),
                                            child: inputSuffix!
                                          )
                                        ),
                                      )] : []),
                                    ],
                                  ),
                                )],
                            ),
                          ),
                    
                          ...(trailing != null ? [Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: trailing!
                          )] : []),
                        ],
                      ),
                    
                      // bottom border
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: hasFocus ? 2 : 1,
                                style: BorderStyle.solid,
                                color: hasFocus ? Theme.of(context).primaryColor : wuiDefaultBorderColor
                              )
                            )
                          ),
                        )
                      )
                    ],
                  ),
                ),
              )
            );
          } 
        ),
      ),
    );
  }
}