import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class ConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Conditions'),
          ),
          body: TabBarView(children: [Text('Male'), Text('Female')]),
          bottomSheet: ConvexAppBar(
              items: [
                TabItem(icon: Icon(Icons.pregnant_woman), title: "Male"),
                TabItem(icon: Icon(Icons.pregnant_woman), title: "Female")
              ],
              backgroundColor: Theme.of(context).primaryColor,
              activeColor: Theme.of(context).scaffoldBackgroundColor,
              color: Theme.of(context).iconTheme.color,
              top: -30),
        ));
  }
}
