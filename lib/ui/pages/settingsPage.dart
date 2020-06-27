import 'package:flutter/material.dart';
import 'package:wct/ui/customWidgets/mySettingItem.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
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
          MySettingItem(
              leadingIcon: Icons.color_lens,
              title: 'Theme',
              onTap: () {
                Navigator.pushNamed(context, '/themePage');
              }),
          MySettingItem(
              leadingIcon: Icons.timer,
              title: 'Time',
              onTap: () {
                Navigator.pushNamed(context, '/timePage');
              })
        ]).toList(),
      ),
    );
  }
}
