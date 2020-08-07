import '../../ui/customWidgets/mySettingItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class MyTimePickerDialogTile extends StatelessWidget {
  final String title;
  final String dialogTitle;
  final String trailing;
  final bool is24Enabled;
  final DateTime time;

  final void Function(DateTime) onTimeChanged;

  MyTimePickerDialogTile(
      {@required this.title,
      @required this.trailing,
      @required this.time,
      this.onTimeChanged,
      this.is24Enabled = false,
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
                  time: time,
                  is24HourMode: is24Enabled,
                  onTimeChange: onTimeChanged,
                  isForce2Digits: true,
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  )
                ],
              );
            });
      },
    );
  }
}
