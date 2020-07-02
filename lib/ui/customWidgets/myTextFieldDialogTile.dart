import '../../ui/customWidgets/mySettingItem.dart';
import '../../ui/customWidgets/textFieldDialog.dart';
import 'package:flutter/material.dart';

class MyTextFieldDialogTile extends StatelessWidget {
  final String tileTitle;
  final String dialogTitle;
  final IconData leadingIcon;
  final void Function(String) onValueChanged;
  final String trailing;

  MyTextFieldDialogTile(
      {@required this.tileTitle,
      @required this.dialogTitle,
      @required this.leadingIcon,
      this.onValueChanged,
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
              return TextFieldDialog(
                title: dialogTitle,
                onValueChanged: onValueChanged,
              );
            });
      },
      trailing: trailing,
    );
  }
}
