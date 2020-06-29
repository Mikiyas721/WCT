import '../../../customWidgets/myRadioDialogTile.dart';
import '../../../customWidgets/mySettingItem.dart';
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
            MyRadioDialogTile(
              leadingIcon: Icons.access_time,
              title: 'Age',
              options: [
                '< 30 Years',
                '30 - 55 Years',
                '> 55 Years',
              ],
              groupValue: 0,
              trailing: '< 30 Years',
              onSubmit: () {},
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
            MyRadioDialogTile(
              leadingIcon: Icons.local_drink,
              title: 'Other Drinks',
              options: ['Small', 'Medium', 'High'],
              groupValue: 0,
              trailing: 'Small',
              onSubmit: () {},
            ),
            MyRadioDialogTile(
              leadingIcon: Icons.fastfood,
              title: 'Meal fluid content',
              options: [
                'Very Little (Mainly dry Cereals)',
                'Little',
                'Average',
                'Very Much (Mainly fruits and Vegetables)'
              ],
              groupValue: 1,
              trailing: 'Little',
              onSubmit: () {},
            ),
          ]).toList()),
          bottomSheet: Card(
              color: Theme.of(context).primaryColorLight,
              margin: EdgeInsets.all(0),
              child: Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Current recommended amount 5Ls',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ],
                ),
                padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              )),
        ));
  }
}
