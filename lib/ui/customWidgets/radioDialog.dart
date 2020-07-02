import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioDialog extends StatefulWidget {
  final _RadioDialogState radioDialogState;

  RadioDialog(String title, String groupValue, List<String> options,
      {ValueChanged<String> onRadioSelected})
      : radioDialogState = _RadioDialogState(
            title: title,
            options: options,
            groupValue: groupValue,
            onRadioSelected: onRadioSelected);

  @override
  State<StatefulWidget> createState() {
    return radioDialogState;
  }
}

class _RadioDialogState extends State<RadioDialog> {
  final String title;
  final List<String> options;
  String groupValue;
  ValueChanged<String> onRadioSelected;

  _RadioDialogState(
      {@required this.title,
      @required this.options,
      @required this.groupValue,
      @required this.onRadioSelected});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5),
      title: Text(title),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok'))
      ],
      content: Scrollbar(
          controller: ScrollController(),
          child: ListView(shrinkWrap: true, children: getChildren())),
    );
  }

  List<Widget> getChildren() {
    List<Widget> list = List();
    for (int i = 0; i < options.length; i++) {
      list.add(RadioListTile<String>(
        title: Text(options[i]),
        value: options[i],
        groupValue: groupValue,
        onChanged: (String value) {
          setState(() {
            groupValue = value;
            onRadioSelected(value);
          });
        },
      ));
    }
    return list;
  }
}
