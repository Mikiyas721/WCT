import '../../../customWidgets/mySettingItem.dart';
import '../../../customWidgets/radioDialog.dart';
import '../../../customWidgets/textFieldDialog.dart';
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
          body: ListView(
              children: ListTile.divideTiles(context: context, tiles: [
            MySettingItem(
              leadingIcon: Icons.access_time,
              title: 'Age',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      List<String> ageRanges = [
                        '< 30 Years',
                        '30 - 55 Years',
                        '> 55 Years',
                      ];
                      return RadioDialog(
                        'Age Range',
                        0,
                        ageRanges,
                        onSubmit: () {},
                      );
                    });
              },
            ),
            MySettingItem(
              leadingIcon: Icons.linear_scale,
              title: 'Weight',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TextFieldDialog(
                          title: 'Weight in Kgs', onSubmit: () {});
                    });
              },
            ),
            MySettingItem(
              leadingIcon: Icons.local_drink,
              title: 'Other Drinks',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      List<String> list = ['Small', 'Medium', 'High'];
                      return RadioDialog(
                        'Other drinks Level',
                        0,
                        list,
                        onSubmit: () {},
                      );
                    });
              },
            ),
            MySettingItem(
              leadingIcon: Icons.fastfood,
              title: 'Meal fluid content',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      List<String> list = [
                        'Very Little (Mainly dry Cereals)',
                        'Little',
                        'Average',
                        'Very Much (Mainly fruits and Vegetables)'
                      ];
                      return RadioDialog(
                        "How much fluidly is your meal?",
                        1,
                        list,
                        onSubmit: () {},
                      );
                    });
              },
            ),
          ]).toList()),
          bottomSheet: Card(
              color: Theme.of(context).primaryColorLight,
              margin: EdgeInsets.all(0),
              child: Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Current recommended amount 5Ls', style: Theme.of(context).textTheme.body2,),
                  ],
                ),
                padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              )),
        ));
  }
}
