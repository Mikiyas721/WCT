import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
import 'package:wct/ui/customWidgets/mySettingItem.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: ShiftingTabBar(
              tabs: <ShiftingTab>[
                ShiftingTab(icon: Icon(Icons.local_drink), text: 'Water'),
                ShiftingTab(icon: Icon(Icons.menu), text: 'General'),
                ShiftingTab(icon: Icon(Icons.fastfood), text: 'Nutrition')
              ],
            ),
            body: TabBarView(
              children: <Widget>[
                getWaterTab(context),
                getGeneralTab(context),
                Icon(
                  Icons.fastfood,
                  size: 70,
                )
              ],
            )));
  }

  Widget getWaterTab(BuildContext context) {
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
        MySettingItem(
            leadingIcon: Icons.timer,
            title: 'Time',
            onTap: () {
              Navigator.pushNamed(context, '/timePage');
            })
      ]).toList(),
    );
  }

  Widget getGeneralTab(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(context: context, tiles: [
        MySettingItem(
            leadingIcon: Icons.color_lens,
            title: 'Theme',
            onTap: () {
              Navigator.pushNamed(context, '/themePage');
            }),
      ]).toList(),
    );
  }
}
