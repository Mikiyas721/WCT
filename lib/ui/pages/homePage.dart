import 'package:fab_circular_menu/fab_circular_menu.dart';
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
            Icons.local_drink,size: 70,
            semanticLabel: 'Water',
          ),
          Icon(
            Icons.fastfood,size: 70,
            semanticLabel: 'Food',
          )
        ]),
        floatingActionButton: FabCircularMenu(
          children: [
            IconButton(icon: Icon(Icons.brush), onPressed: () {}),
            IconButton(icon: Icon(Icons.settings), onPressed: () {
              Navigator.pushNamed(context, '/settingsPage');
            }),
            IconButton(icon: Icon(Icons.volume_up), onPressed: () {})
          ],
          ringWidth: 55,
          ringDiameter: 250,
          fabOpenColor: Colors.redAccent,
        ),
      ),
    );
  }
}
