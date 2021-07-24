import 'package:flutter/material.dart';
import 'package:wui/action_sheet/action_sheet.dart';
import 'package:wui/form_field/static_field.dart';
import 'package:wui/list_tile/list_tile.dart';

class WuiSelectField extends StatelessWidget {

  final Widget? label;
  final Widget? inputSuffix;
  final Widget? inputPrefix;
  final Widget? leading;
  final Widget? value;

  final Widget? optionTitle;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  final int? activeIndex;
  final void Function(int index)? onChange;

  const WuiSelectField({ 
    Key? key,
    this.label,
    this.inputSuffix,
    this.inputPrefix,
    this.leading,
    this.value,

    this.optionTitle,
    required this.itemCount,
    required this.itemBuilder,

    this.activeIndex,
    this.onChange
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WuiStaticField(
      label: label,
      inputSuffix: inputSuffix,
      inputPrefix: inputPrefix,
      leading: leading,
      trailing: Icon(Icons.expand_more),
      value: value,
      onTap: () async {
        int? res = await WuiActionSheet.open(context, 
          title: optionTitle,
          actions: List.generate(itemCount, (index) => WuiListTile(
            leading: IconTheme(
              data: IconThemeData(
                color: index == activeIndex ? 
                  Theme.of(context).primaryColor : 
                  Theme.of(context).iconTheme.color
              ),
              child: index == activeIndex ? 
                Icon(Icons.radio_button_on) : 
                Icon(Icons.radio_button_off)
            ),
            title: itemBuilder(context, index),
            borderMode: index < itemCount - 1 ? 'normal' : 'none',
            onTap: () {
              Navigator.of(context).pop(index);
            },
          )
        ));

        if(res != null && onChange != null && activeIndex != res) {
          onChange!(res);
        }
      },
    );
  }
}