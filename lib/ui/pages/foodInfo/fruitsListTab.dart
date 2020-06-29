import '../../customWidgets/foodCard.dart';
import 'package:flutter/material.dart';

class FruitListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: getChildren());
  }
}

List<Widget> getChildren() {
  List<Widget> list = List();
  for (Map<String, String> fruitInfo in fruitData) {
    list.add(FoodCard(
      imageUrl: fruitInfo['imageUrl'],
      title: fruitInfo['title'],
      nutrition: fruitInfo['details'],
    ));
  }
  return list;
}

final fruitData = [
  {
    'imageUrl': 'assets/banana.jpg',
    'title': 'Banana',
    'details': 'Vitamin A -------- 2 %'
  }
];
