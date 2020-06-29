import 'package:flutter/material.dart';

class RadioDialog extends StatefulWidget {
  final _RadioDialogState radioDialogState;

  RadioDialog(String title, int groupValue, List<String> options,
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
  int groupValue;
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
      content: Scrollbar(
          controller: ScrollController(),
          child: ListView(shrinkWrap: true, children: getChildren())),
    );
  }

  List<Widget> getChildren() {
    List<Widget> list = List();
    for (int i = 0; i < options.length; i++) {
      list.add(RadioListTile<int>(
        title: Text(options[i]),
        value: i,
        groupValue: groupValue,
        onChanged: (int value) {
          setState(() {
            groupValue = value;
          });
        },
      ));
    }
    return list;
  }
}
