import 'package:flutter/material.dart';

class TextFieldDialog extends StatelessWidget {
  final String title;
  final Function onSubmit;

  TextFieldDialog({@required this.title, @required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(keyboardType: TextInputType.number,),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        FlatButton(onPressed: onSubmit, child: Text('Ok'))
      ],
    );
  }
}
