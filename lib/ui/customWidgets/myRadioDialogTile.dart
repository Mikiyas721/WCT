import '../customWidgets/mySettingItem.dart';
import '../customWidgets/radioDialog.dart';
import 'package:flutter/material.dart';

class MyRadioDialogTile extends StatelessWidget {
  final String title;
  final String dialogTitle;
  final List<String> options;
  final String trailing;
  final String groupValue;
  final IconData leadingIcon;
  final ValueChanged<String> onRadioSelected;

  MyRadioDialogTile(
      {@required this.title,
      this.dialogTitle,
      @required this.options,
      @required this.trailing,
      @required this.groupValue,
      this.leadingIcon,
      @required this.onRadioSelected});

  @override
  Widget build(BuildContext context) {
    return MySettingItem(
      title: title,
      leadingIcon: leadingIcon,
      trailing: trailing,
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RadioDialog(
                dialogTitle==null?title:dialogTitle,
                groupValue,
                options,
                onRadioSelected: onRadioSelected,
              );
            });
      },
    );
  }
}
