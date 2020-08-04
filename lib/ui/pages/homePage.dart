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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: StreamBuilder(
                          stream: bloc.soFarStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<double> snapshot) {
                            return LinearProgressIndicator(
                              value: bloc.progress(snapshot.data),
                            );
                          })),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            cup.decrease(0.1);
                            bloc.onOneCup();
                          },
                          child: Text('1 Cup')),
                      FlatButton(
                          onPressed: () async {
                            cup.refill();
                            bloc.onTwoCup();
                            bloc.showNotification();
                          },
                          child: Text('2 Cup'))
                    ],
                  )
                ],
              );
            },
          ),
          CustomPaint(
            painter: cup,
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
