import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wui/themes/constants.dart';

class WuiFormField extends StatefulWidget {

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelText;
  final Widget? inputSuffix;
  final Widget? inputPrefix;
  final Widget? leading;
  final Widget? trailing;
  final TextInputType? keyboardType;
  final bool readOnly;
  final String? placeholderText;
  final bool obscureText;
  final bool autoFocus;

  const WuiFormField({ 
    Key? key, 
    this.controller, 
    this.focusNode, 
    this.labelText ,
    this.inputSuffix,
    this.inputPrefix,
    this.leading,
    this.trailing,
    this.keyboardType,
    this.readOnly = false,
    this.placeholderText,
    this.obscureText = false,
    this.autoFocus = false
  }) : super(key: key);

  @override
  _WuiFormFieldState createState() => _WuiFormFieldState();
}

class _WuiFormFieldState extends State<WuiFormField> {

  TextEditingController? _controller;
  FocusNode? _focusNode;

  bool _hasContent = false;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller?.addListener(() {
      setState(() {
        _hasContent = _controller?.text.isNotEmpty ?? false;
      });
    });

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode?.addListener(() {
      setState(() {
        _focused = _focusNode?.hasFocus ?? false;
      });      
    });
  }

  _setFocus() {
    if(_focused && MediaQuery.of(context).viewInsets.bottom == 0) {
      _focusNode!.unfocus();
      Timer(Duration(milliseconds: 0), () {
        _focusNode!.requestFocus();
      });
    } else {
      _focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          _setFocus();
        },
        child: Container(
          child: Stack(
            children: [
             
              // main container
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...(widget.leading != null ? [Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: widget.leading!
                  )] : []),
            
                  Expanded(
                    child: Stack(
                      children: [
                        // label
                        AnimatedPositioned(
                          top: _hasContent || _focused ? 4 : 20,
                          child: AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: 200),
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: _focused || _hasContent ? 12 : 16,
                              color: _focused ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyText2!.color
                            ),
                            child: Text(
                              widget.labelText ?? "",
                            ),
                          ), 
                          duration: Duration(milliseconds: 200)
                        ),
            
                        // editable text
                        Container(
                          padding: const EdgeInsets.only(top: 8, bottom: 0),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...(widget.inputPrefix != null ? [AnimatedOpacity(
                                duration: Duration(milliseconds: 200),
                                opacity: _focused || _hasContent ? 1 : 0,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8, top: 8),
                                  child: DefaultTextStyle(
                                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 16,
                                      height: 1.125
                                    ),
                                    child: widget.inputPrefix!
                                  )
                                ),
                              )] : []),
            
                              Expanded(
                                child: Opacity(
                                  opacity: (_hasContent || _focused ? 1 : 0),
                                  child: TextField(
                                    controller: _controller!, 
                                    focusNode: _focusNode!, 
                                    obscureText: widget.obscureText,
                                    autofocus: widget.autoFocus,
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.125,
                                      color: Colors.black87
                                    ),
                                    keyboardType: widget.keyboardType,
                                    readOnly: widget.readOnly,
                                    decoration: InputDecoration(
                                      hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                                        fontSize: 16,
                                        color: Theme.of(context).textTheme.bodyText2!.color!.withOpacity(.375)
                                      ),
                                      hintText: widget.placeholderText,
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 8)
                                    ),
                                  ),
                                ),
                              ),
            
                              ...(widget.inputSuffix != null ? [AnimatedOpacity(
                                duration: Duration(milliseconds: 200),
                                opacity: _focused || _hasContent ? 1 : 0,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8, top: 8),
                                  child: DefaultTextStyle(
                                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 16,
                                      height: 1.125
                                    ),
                                    child: widget.inputSuffix!
                                  )
                                ),
                              )] : []),
                            ],
                          ),
                        )],
                    ),
                  ),
            
                  ...(widget.trailing != null ? [Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: widget.trailing!
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
                        width: _focused ? 2 : 1,
                        style: BorderStyle.solid,
                        color: _focused ? Theme.of(context).primaryColor : wuiDefaultBorderColor
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
}