import 'package:flutter/material.dart';
import '../../../customWidgets/mySettingItem.dart';

class GeneralSettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(context: context, tiles: [
        MySettingItem(
            leadingIcon: Icons.color_lens,
            title: 'Theme',
            onTap: () {
              Navigator.pushNamed(context, '/themePage');
            }),
        MySettingItem(
            leadingIcon: Icons.info,
            title: 'Facts and Recommendations',
            onTap: () {}),
        MySettingItem(
            leadingIcon: Icons.question_answer,
            title: 'About Nutracker',
            onTap: () {
            })
      ]).toList(),
    );
  }
}
