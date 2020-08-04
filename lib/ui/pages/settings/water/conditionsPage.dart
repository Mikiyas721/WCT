import '../../../customWidgets/myNumberPickerTile.dart';
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
                      return MyNumberPickerTile(
                        tileTitle: 'Weight',
                        dialogTitle: 'Weight in Kgs',
                        leadingIcon: Icons.linear_scale,
                        initialValue: int.parse(bloc.getWeight(snapshot.data)),
                        minValue: 30,
                        maxValue: 300,
                        onValueChanged: bloc.onWeightChanged,
                        trailing: bloc.getWeight(snapshot.data),
                      );
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
                        "If you exercise, please fill the conditions below.\nWhen you start exercising enable the 'Now Exercising' Mode."),
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
                      return MyNumberPickerTile(
                        tileTitle: 'Exercise Length',
                        dialogTitle: 'Exercise length per day, in Minutes',
                        leadingIcon: Icons.timer,
                        initialValue:
                            int.parse(bloc.getExerciseLength(snapshot.data)),
                        step: 45,
                        minValue: 45,
                        maxValue: 270,
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
                  return BottomAppBar(
                      color: Theme.of(context).primaryColorLight,
                      child: Padding(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.18),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Current recommended amount : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Regular - ${bloc.fetchRecommended()} Ls\nExercising - ${bloc.getExerciseTimeRecommended()} Ls',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        padding: EdgeInsets.all(10),
                      ));
                },
              ),
            ));
      },
    );
  }
}
