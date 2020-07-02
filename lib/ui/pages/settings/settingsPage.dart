import '../settings/food/foodSettingsTab.dart';
import '../settings/general/generalSettingsTab.dart';
import 'water/waterSettingsTab.dart';
import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: ShiftingTabBar(
              labelStyle: Theme.of(context).textTheme.body1,
              tabs: <ShiftingTab>[
                ShiftingTab(
                    icon: Icon(
                      Icons.local_drink,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    text: 'Water'),
                ShiftingTab(
                    icon: Icon(
                      Icons.menu,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    text: 'General'),
                ShiftingTab(
                    icon: Icon(
                      Icons.fastfood,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    text: 'Nutrition')
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
