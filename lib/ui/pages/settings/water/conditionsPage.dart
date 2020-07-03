import '../../../customWidgets/myTextFieldDialogTile.dart';
import '../../../../bloc/conditionsBloc.dart';
import '../../../../bloc/provider/provider.dart';
import '../../../customWidgets/myRadioDialogTile.dart';
import 'package:flutter/material.dart';

class ConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConditionsBloc>(
      blocFactory: () => ConditionsBloc(),
      builder: (BuildContext context, ConditionsBloc bloc) {
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
                      return MyTextFieldDialogTile(
                          //TODO Replace with a Sliding Number Picker
                          tileTitle: 'Weight',
                          dialogTitle: 'Weight in Kgs',
                          leadingIcon: Icons.linear_scale,
                          onValueChanged: bloc.onWeightEntered,
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
                    }),
                Card(
                  shape: BeveledRectangleBorder(),
                  margin: EdgeInsets.all(0),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                        "If you exercise, please fill the conditions below.\nWhen you start exercising enable the 'Now Exercising' Mood."),
                  ),
                ),
                StreamBuilder(
                    stream: bloc.exerciseTypeStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return MyRadioDialogTile(
                        leadingIcon: Icons.accessibility,
                        title: 'Exercise Type',
                        dialogTitle: 'How much do you sweat, during exercise?',
                        options: ['A little', 'Average', 'Very much'],
                        groupValue: bloc.getExerciseType(snapshot.data),
                        trailing: bloc.getExerciseType(snapshot.data),
                        onRadioSelected: bloc.onExerciseTypeChanged,
                      );
                    }),
                StreamBuilder(
                    stream: bloc.exerciseLengthStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return MyTextFieldDialogTile(
                        leadingIcon: Icons.timer,
                        tileTitle: 'Exercise Length',
                        dialogTitle:
                            'How long do you exercise per day, in Minutes',
                        onValueChanged: bloc.onExerciseLengthChanged,
                        trailing: bloc.getExerciseLength(snapshot.data),
                      );
                    })
              ]).toList()),
              //TODO Add daily physical engagement
              bottomSheet: StreamBuilder(
                stream: bloc.recommendedStream,
                builder:
                    (BuildContext context, AsyncSnapshot<double> snapshot) {
                  return Card(
                      shape: BeveledRectangleBorder(),
                      color: Theme.of(context).primaryColorLight,
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              bloc.getRecommendedString(),
                              style: Theme.of(context).textTheme.body2,
                            )
                          ],
                        ),
                        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      ));
                },
              ),
            ));
      },
    );
  }
}
