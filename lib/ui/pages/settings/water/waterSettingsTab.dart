import '../../../../bloc/provider/provider.dart';
import '../../../../bloc/timeBloc.dart';
import '../../../customWidgets/myRadioDialogTile.dart';
import 'package:flutter/material.dart';
import '../../../customWidgets/mySettingItem.dart';

class WaterSettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(context: context, tiles: [
        MySettingItem(
            leadingIcon: Icons.content_paste,
            title: 'Conditions',
            onTap: () {
              Navigator.pushNamed(context, '/conditionsPage');
            }),
        MySettingItem(
            leadingIcon: Icons.notifications,
            title: 'Notification and Sound',
            onTap: () {
              Navigator.pushNamed(context, '/notificationPage');
            }),
        BlocProvider(
            blocFactory: () => TimeBloc(),
            builder: (BuildContext context, TimeBloc bloc) {
              return StreamBuilder(
                stream: bloc.timeStream,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return MyRadioDialogTile(
                      leadingIcon: Icons.timer,
                      title: 'Time',
                      options: [
                        'auto',
                        '60 Minutes',
                        '90 Minutes',
                        '2 Hours',
                        '3 Hours',
                        '4 Hours'
                      ],
                      groupValue: bloc.getTimeGroupValue(snapshot.data),
                      trailing: bloc.getTimeGroupValue(snapshot.data),
                      onRadioSelected: bloc.onTimeChanged);
                },
              );
            }),
      ]).toList(),
    );
  }
}
