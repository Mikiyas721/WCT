import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioDialog extends StatefulWidget {
  final _RadioDialogState radioDialogState;

  RadioDialog(String title, String groupValue, List<String> options,
      {void Function() onSubmit})
      : radioDialogState = _RadioDialogState(
            title: title,
            options: options,
            groupValue: groupValue,
            onSubmit: onSubmit);

  @override
  State<StatefulWidget> createState() {
    return radioDialogState;
  }
}

class _RadioDialogState extends State<RadioDialog> {
  final String title;
  final List<String> options;
  String groupValue;
  void Function() onSubmit;

  _RadioDialogState(
      {@required this.title,
      @required this.options,
      @required this.groupValue,
      this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        FlatButton(onPressed: onSubmit, child: Text('Ok'))
      ],
      content: ListView(
        children: getChildren(),
      ),
    );
  }

  List<Widget> getChildren() {
    List<Widget> list = List();
    for (String option in options) {
      list.add(RadioListTile<String>(
        title: Text(option),
        value: option,
        groupValue: groupValue,
        onChanged: (String value) {
          setState(() {
            groupValue = value;
          });
        },
      ));
    }
    return list;
  }
}
