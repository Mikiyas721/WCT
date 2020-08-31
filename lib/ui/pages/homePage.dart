import 'package:Nutracker/ui/customWidgets/myCountDownTimer.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';

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
  Cup cup = Cup();

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
                CustomPaint(
                  painter: cup,
                  size: Size(180, 620),
                ),
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
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return Text(
                                  'Regular- ${bloc.fetchRecommended()} Ls\nExercising - ${bloc.getExerciseTimeRecommended()} Ls\n',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                );
                              }),
                          Text(
                            'Day Statistics',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          StreamBuilder(
                              stream: bloc.recommendedStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return Text(
                                  'Consumed Amount {}\nRemaining Amount {}\n',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                );
                              }),
                          Text(
                            'Next Drink Statistics',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          StreamBuilder(
                              stream: bloc.recommendedStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CountdownTimer(
                                        endTime: DateTime.now()
                                                .millisecondsSinceEpoch +
                                            10000,
                                      ),
                                      Text(
                                        'Amount {}',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ]);
                              }),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.local_drink),
                                  onPressed: () {
                                    if (cup.decrease(0.1)) {
                                      bloc.onOneCup();
                                    }
                                    cup.decrease(0.1);
                                    bloc.scheduleNotification();
                                  }),
                              FlatButton(
                                  onPressed: () async {
                                    cup.refill();
                                    bloc.onTwoCup();
                                    await bloc.notificationAfterSec();
                                  },
                                  child: Text('2 Cup'))
                            ],
                          )
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
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Text(bloc.disableValue(snapshot.data) == true
                              ? 'Enable Notification'
                              : 'Disable Notification');
                        })),
                PopupMenuItem(
                    value: 1,
                    child: StreamBuilder(
                        stream: bloc.nowExercisingStream,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Text(
                              bloc.nowExercisingValue(snapshot.data) == true
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
