import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../bloc/provider/provider.dart';
import '../../bloc/themeBloc.dart';

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
          Icon(
            Icons.local_drink,
            size: 70,
            semanticLabel: 'Water',
          ),
          Icon(
            Icons.fastfood,
            size: 70,
            semanticLabel: 'Food',
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
            IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
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
      PopupMenuButton<int>(
        onSelected: (int selectedMenu) {
          if (selectedMenu == 0) Toast.show('Notification Disabled', context);
        },
        itemBuilder: (BuildContext context) {
          return [PopupMenuItem(value: 0, child: Text('Disable Notification'))];
        },
      )
    ];
  }
}
