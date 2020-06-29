import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String nutrition;

  FoodCard(
      {@required this.imageUrl,
      @required this.title,
      @required this.nutrition});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
        margin: EdgeInsets.all(7),
        child: Padding(
          padding: EdgeInsets.all(7),
          child: Row(
            children: <Widget>[
              Image.asset(
                imageUrl,
                width: width * 0.3,
                height: width * 0.3,
              ),
              Column(
                children: <Widget>[Text(title), Text(nutrition)],
              )
            ],
          ),
        ));
  }
}
