import '../../../customWidgets/myRadioDialogTile.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification and Sounds'),
      ),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          SwitchListTile(
            title: Text('Disable'),
            value: false,
            onChanged: (bool value) {},
          ),
          SwitchListTile(
              title: Text('Notification'),
              value: true,
              onChanged: (bool newValue) {}),
          SwitchListTile(
              title: Text('Popup Notification'),
              value: false,
              onChanged: (bool newValue) {}),
          MyRadioDialogTile(
            leadingIcon: Icons.surround_sound,
            title: 'Alarm',
            options: [
              'Silent',
              'Vibrate',
              'Sound',
            ],
            groupValue: 0,
            trailing: 'Silent',
            onSubmit: () {},
          ),
        ]).toList(),
      ),
    );
  }
}
