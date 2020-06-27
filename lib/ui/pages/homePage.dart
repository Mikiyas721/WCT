import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WNT'),
      ),
      body: null,
      bottomNavigationBar: ConvexAppBar(
        items: <TabItem>[
          TabItem(icon: Icon(Icons.brush), title: "Theme"),
          TabItem(icon: Icon(Icons.settings), title: "Settings"),
          TabItem(icon: Icon(Icons.volume_down), title: "Sound")
        ],
        initialActiveIndex: 1,
        onTap: (int tabIndex) {
          if (tabIndex == 0)
            Navigator.pushNamed(context, '/settingsPage');
          else if (tabIndex == 1) {
          } else if (tabIndex == 2) {}
        },
      ),
    );
  }
}
