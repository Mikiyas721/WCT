import '../../ui/customWidgets/mySettingItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class MyTimePickerDialogTile extends StatelessWidget {
  final String title;
  final String dialogTitle;
  final String trailing;
  final void Function(DateTime) onTimeChanged;

  MyTimePickerDialogTile(
      {@required this.title,
      @required this.trailing,
      this.onTimeChanged,
      this.dialogTitle});

  @override
  Widget build(BuildContext context) {
    return MySettingItem(
      title: title,
      trailing: trailing,
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: dialogTitle == null ? Text(title) : Text(dialogTitle),
                content: TimePickerSpinner(
                  onTimeChange: onTimeChanged,
                  isForce2Digits: true,
                ),
              );
            });
      },
    );
  }
}
