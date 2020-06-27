import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Water and Nutrition Tracker'),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.local_drink),
            ),
            Tab(
              icon: Icon(Icons.fastfood),
            )
          ]),
        ),
        body: TabBarView(children: [
          Icon(
            Icons.local_drink,
            semanticLabel: 'Water',
          ),
          Icon(
            Icons.fastfood,
            semanticLabel: 'Food',
          )
        ]),
        bottomNavigationBar: ConvexAppBar(
          items: <TabItem>[
            TabItem(icon: Icon(Icons.brush), title: "Theme"),
            TabItem(icon: Icon(Icons.settings), title: "Settings"),
            TabItem(icon: Icon(Icons.volume_down), title: "Sound")
          ],
          initialActiveIndex: 1,
          onTap: (int tabIndex) {
            if (tabIndex == 0) {
            } else if (tabIndex == 1) {
              Navigator.pushNamed(context, '/settingsPage');
            } else if (tabIndex == 2) {}
          },
        ),
      ),
    );
  }
}
