import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class MyNumberPickerDialog extends StatefulWidget {
  final _NumberPickerDialogState _numberPickerDialogState;

  MyNumberPickerDialog(String dialogTile, int step, int initialValue, int minValue, int maxValue,
      void Function(num newValue) onValueChanged, void Function() onOkClicked)
      : _numberPickerDialogState = _NumberPickerDialogState(
            dialogTile, initialValue, minValue, maxValue, step, onValueChanged, onOkClicked);

  @override
  State<StatefulWidget> createState() {
    return _numberPickerDialogState;
  }
}

class _NumberPickerDialogState extends State<MyNumberPickerDialog> {
  String dialogTitle;
  int initialValue;
  int minValue;
  int maxValue;
  int step;
  void Function(num selectedValue) onValueChanged;
  void Function() onOkClicked;

  _NumberPickerDialogState(this.dialogTitle, this.initialValue, this.minValue, this.maxValue, this.step,
      this.onValueChanged, this.onOkClicked);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(dialogTitle),
      actions: <Widget>[FlatButton(onPressed: onOkClicked, child: Text('Ok'))],
      content: NumberPicker.integer(
        infiniteLoop: true,
        step: step,
        initialValue: initialValue,
        minValue: minValue,
        maxValue: maxValue,
        onChanged: (num newValue) {
          setState(() {
            initialValue = newValue;
          });
          onValueChanged(newValue);
        },
      ),
    );
  }
}
