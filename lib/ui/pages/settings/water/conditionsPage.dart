import '../../../../bloc/conditionsBloc.dart';
import '../../../../bloc/provider/provider.dart';
import '../../../customWidgets/myRadioDialogTile.dart';
import '../../../customWidgets/mySettingItem.dart';
import '../../../customWidgets/textFieldDialog.dart';
import 'package:flutter/material.dart';

class ConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConditionsBloc>(
      blocFactory: () => ConditionsBloc(),
      builder: (BuildContext context, ConditionsBloc bloc) {
        bloc.fetchRecommended();
        return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Conditions'),
              ),
              body: ListView(
                  children: ListTile.divideTiles(context: context, tiles: [
                StreamBuilder(
                  stream: bloc.ageStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return MyRadioDialogTile(
                      leadingIcon: Icons.access_time,
                      title: 'Age',
                      options: [
                        '< 30 Years',
                        '30 - 55 Years',
                        '> 55 Years',
                      ],
                      groupValue: bloc.getAge(snapshot.data),
                      trailing: bloc.getAge(snapshot.data),
                      onRadioSelected: bloc.onAgeChanged,
                    );
                  },
                ),
                StreamBuilder(
                    stream: bloc.weightStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return MySettingItem(
                          leadingIcon: Icons.linear_scale,
                          title: 'Weight',
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return TextFieldDialog(
                                      title: 'Weight in Kgs',
                                      onValueChanged: bloc.onWeightEntered,

                                  );
                                });
                          },
                          trailing: bloc.getWeight(snapshot.data));
                    }),
                StreamBuilder(
                  stream: bloc.otherDrinksStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return MyRadioDialogTile(
                        leadingIcon: Icons.local_drink,
                        title: 'Other Drinks',
                        options: ['Small', 'Medium', 'High'],
                        groupValue: bloc.getOtherDrinks(snapshot.data),
                        trailing: bloc.getOtherDrinks(snapshot.data),
                        onRadioSelected: bloc.onOtherDrinksChanged);
                  },
                ),
                StreamBuilder(
                    stream: bloc.mealFluidStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return MyRadioDialogTile(
                        leadingIcon: Icons.fastfood,
                        title: 'Meal fluid content',
                        options: [
                          'Very Little\n(Mainly dry Cereals)',
                          'Little',
                          'Average',
                          'Very Much (Mainly fruits and Vegetables)'
                        ],
                        groupValue: bloc.getMealFluid(snapshot.data),
                        trailing: bloc.getMealFluidTrailing(snapshot.data),
                        onRadioSelected: bloc.onMealFluidsChanged,
                      );
                    })
              ]).toList()),
              bottomSheet: StreamBuilder(
                stream: bloc.recommendedStream,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return snapshot.data != null
                      ? Card(
                          shape: BeveledRectangleBorder(),
                          color: Theme.of(context).primaryColorLight,
                          margin: EdgeInsets.all(0),
                          child: Padding(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Current recommended amount ${snapshot.data}',
                                  style: Theme.of(context).textTheme.body2,
                                )
                              ],
                            ),
                            padding:
                                EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          ))
                      : Container(
                          width: 0,
                          height: 0,
                        );
                },
              ),
            ));
      },
    );
  }
}
