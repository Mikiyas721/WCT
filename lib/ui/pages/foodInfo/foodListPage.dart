import 'package:Nutracker/ui/pages/foodInfo/fruitsListTab.dart';
import 'package:flutter/material.dart';

class FoodListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Text('Cereals'),
              Text('Fruits'),
              Text('Vegetables'),
            ]),
          ),
          body: TabBarView(
            children: <Widget>[
              Icon(Icons.fastfood),
              FruitListTab(),
              Icon(Icons.fastfood)
            ],
          ),
        ));
  }
}
