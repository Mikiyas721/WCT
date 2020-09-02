import '../../ui/customWidgets/numberPickerDialog.dart';
import '../../ui/customWidgets/mySettingItem.dart';
import 'package:flutter/material.dart';

class MyNumberPickerTile extends StatelessWidget {
  final String tileTitle;
  final String dialogTitle;
  final IconData leadingIcon;
  final String trailing;
  final int initialValue;
  final int minValue;
  final int maxValue;
  final int step;
  final void Function(num selectedValue) onValueChanged;

  MyNumberPickerTile(
      {@required this.tileTitle,
      @required this.leadingIcon,
      @required this.initialValue,
      @required this.minValue,
      @required this.maxValue,
      @required this.onValueChanged,
      this.dialogTitle,
      this.step = 1,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return MySettingItem(
      title: tileTitle,
      leadingIcon: leadingIcon,
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MyNumberPickerDialog(dialogTitle == null ? tileTitle : dialogTitle, step, initialValue,
                  minValue, maxValue, onValueChanged, () {
                Navigator.pop(context);
              });
            });
      },
      trailing: trailing,
    );
  }
}
