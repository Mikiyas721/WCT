import 'package:Nutracker/ui/customWidgets/numberPickerDialog.dart';
import 'package:Nutracker/ui/customWidgets/radioDialog.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../bloc/timeBloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import '../../ui/customWidgets/cup.dart';
import '../../bloc/conditionsBloc.dart';
import '../../bloc/notificationBloc.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../bloc/provider/provider.dart';
import '../../bloc/themeBloc.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nutrition Tracker'),
          actions: getPopups(context),
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
          BlocProvider<ConditionsBloc>(
            blocFactory: () => ConditionsBloc(),
            builder: (BuildContext context, ConditionsBloc bloc) {
              return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                StreamBuilder(
                    stream: bloc.consumedStream,
                    builder: (BuildContext context, AsyncSnapshot snapShot) {
                      return CustomPaint(
                        painter: Cup(
                            consumedAmount: bloc.consumedAmount(snapShot.data),
                            recommendedAmount: double.parse(bloc.fetchRecommended())),
                        size: Size(150, 620),
                      );
                    }),
                Card(
                    color: Theme.of(context).primaryColorLight,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Recommended Amount',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          StreamBuilder(
                              stream: bloc.recommendedStream,
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                return Text(
                                  'Regular : ${bloc.fetchRecommended()} Ls\nExercising : ${bloc.getExerciseTimeRecommended()} Ls\n',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                );
                              }),
                          Text(
                            'Day Statistics',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          StreamBuilder(
                              stream: bloc.consumedStream,
                              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                                return Text(
                                  'Consumed : ${bloc.consumedAmount(snapshot.data)} Ls\nRemaining : ${bloc.remainingAmount(snapshot.data)} Ls\n',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                );
                              }),
                          Text(
                            'Next Drink Statistics',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          StreamBuilder(
                              stream: bloc.recommendedStream,
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text('After : '),
                                          BlocProvider(
                                            blocFactory: () => TimeBloc(),
                                            builder: (BuildContext context, TimeBloc bloc) {
                                              return StreamBuilder(
                                                  stream: bloc.timeStream,
                                                  builder:
                                                      (BuildContext context, AsyncSnapshot<String> snapShot) {
                                                    return SlideCountdownClock(
                                                      duration: Duration(
                                                          seconds: bloc.getCountDownTime(snapshot.data)),
                                                      onDone: bloc.onTimerDone,
                                                      separator: ':',
                                                      textStyle: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    );
                                                  });
                                            },
                                          )
                                        ],
                                      ),
                                      Text(
                                        'Amount : ${bloc.getUnitAmount()} Ls\n',
                                        style: TextStyle(fontStyle: FontStyle.italic),
                                      ),
                                    ]);
                              }),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              FlatButton(
                                child: Text('Drink'),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        int cupCount = 1;
                                        return MyNumberPickerDialog('How many cups did you drink?', 1,
                                            bloc.getUnitAmountInCups(), 1, 4, (num selectedValue) {
                                          cupCount = selectedValue;
                                        }, () {
                                          bloc.onDrinkConfirmed(cupCount);
                                          Navigator.pop(context);
                                        });
                                      });
                                },
                                color: Theme.of(context).buttonColor,
                              ),
                              Padding(padding: EdgeInsets.only(left: 5)),
                              FlatButton(
                                child: Text('Extend'),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return RadioDialog('How long do you want to extend the reminder?',
                                            '5 Minutes', ['5 Minutes', '10 Minutes', '15 Minutes'],
                                            onRadioSelected: (String selectedRadio) {});
                                      });
                                },
                                color: Theme.of(context).buttonColor,
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: FlatButton(
                                onPressed: bloc.onStopAlarm,
                                child: Text('Stop Alarm'),
                                color: Theme.of(context).buttonColor,
                              )),
                        ],
                      ),
                    )),
              ]);
            },
          ),
          Icon(
            Icons.fastfood,
            size: 20,
          )
        ]),
        floatingActionButton: FabCircularMenu(
          children: [
            BlocProvider<ThemeBloc>(
                blocFactory: () => ThemeBloc(),
                builder: (BuildContext context, ThemeBloc bloc) {
                  return IconButton(
                      icon: Icon(Icons.brush),
                      onPressed: () {
                        bloc.nextTheme();
                      });
                }),
            BlocProvider(
                blocFactory: () => NotificationBloc(),
                builder: (BuildContext context, NotificationBloc bloc) {
                  return StreamBuilder(
                    stream: bloc.alarmStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return IconButton(
                          icon: Icon(bloc.getNotificationIcon(snapshot.data)),
                          onPressed: bloc.onAlarmSwitched);
                    },
                  );
                }),
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, '/settingsPage');
                }),
          ],
          ringWidth: 55,
          ringDiameter: 250,
          fabOpenColor: Colors.redAccent,
        ),
      ),
    );
  }

  List<Widget> getPopups(BuildContext context) {
    return [
      BlocProvider(
        blocFactory: () => NotificationBloc(),
        builder: (BuildContext context, NotificationBloc bloc) {
          return PopupMenuButton<int>(
            onSelected: (int selectedMenu) {
              if (selectedMenu == 0) {
                bool currentDisable = bloc.disableValue(null);
                bloc.onDisableTap(!currentDisable);
                currentDisable == true
                    ? Toast.show('Notification Enabled', context)
                    : Toast.show('Notification Disabled', context);
              } else if (selectedMenu == 1) {
                bool currentDisable = bloc.nowExercisingValue(null);
                bloc.onNowExercisingTap(!currentDisable);
                currentDisable == true
                    ? Toast.show('Now Exercising Disabled', context)
                    : Toast.show('Now Exercising Enabled', context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    value: 0,
                    child: StreamBuilder(
                        stream: bloc.disableNotificationStream,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          return Text(bloc.disableValue(snapshot.data) == true
                              ? 'Enable Notification'
                              : 'Disable Notification');
                        })),
                PopupMenuItem(
                    value: 1,
                    child: StreamBuilder(
                        stream: bloc.nowExercisingStream,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          return Text(bloc.nowExercisingValue(snapshot.data) == true
                              ? 'Disable Exercising'
                              : 'Enable Exercising');
                        }))
              ];
            },
          );
        },
      )
    ];
  }
}
