import 'package:Nutracker/ui/pages/settings/foodSettingsTab.dart';
import 'package:Nutracker/ui/pages/settings/generalSettingsTab.dart';
import '../../../ui/pages/settings/waterSettingsTab.dart';
import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';

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
                WaterSettingsTab(),
                GeneralSettingsTab(),
                FoodSettingsTab()
              ],
            )));
  }
}
