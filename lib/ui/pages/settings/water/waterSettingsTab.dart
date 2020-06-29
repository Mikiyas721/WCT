import '../../../customWidgets/myRadioDialogTile.dart';
import 'package:flutter/material.dart';
import '../../../customWidgets/mySettingItem.dart';

class WaterSettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(context: context, tiles: [
        MySettingItem(
            leadingIcon: Icons.content_paste,
            title: 'Conditions',
            onTap: () {
              Navigator.pushNamed(context, '/conditionsPage');
            }),
        MySettingItem(
            leadingIcon: Icons.notifications,
            title: 'Notification and Sound',
            onTap: () {
              Navigator.pushNamed(context, '/notificationPage');
            }),
        MyRadioDialogTile(
          leadingIcon: Icons.timer,
          title: 'Time',
          options: [
            '20 Minutes',
            '40 Minutes',
            '60 Minutes',
            '90 Minutes',
            '2 Hours',
            '3 Hours',
            '4 Hours'
          ],
          groupValue: 2,
          trailing: '60 Minutes',
          onSubmit: () {},
        ),
      ]).toList(),
    );
  }
}
