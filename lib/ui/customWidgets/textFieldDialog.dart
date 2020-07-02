import 'package:flutter/material.dart';

class TextFieldDialog extends StatelessWidget {
  final String title;
  final ValueChanged<String> onValueChanged;

  TextFieldDialog(
      {@required this.title,
      @required this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        keyboardType: TextInputType.number,
        onChanged: (String newValue) {
          onValueChanged(newValue);
        },
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok'))
      ],
    );
  }
//TODO Add Validation
}
