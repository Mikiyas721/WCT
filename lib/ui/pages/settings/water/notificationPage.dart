import '../../../../bloc/notificationBloc.dart';
import '../../../../bloc/provider/provider.dart';
import '../../../customWidgets/myRadioDialogTile.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocFactory: () => NotificationBloc(),
        builder: (BuildContext context, NotificationBloc bloc) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Notification and Sounds'),
            ),
            body: ListView(
              children: ListTile.divideTiles(context: context, tiles: [
                StreamBuilder(builder:
                    (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  return SwitchListTile(
                    title: Text('Disable'),
                    value: bloc.disableValue(snapshot.data),
                    onChanged: bloc.onDisableTap,
                  );
                }),
                StreamBuilder(
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return SwitchListTile(
                      title: Text('Notification'),
                      value: bloc.disableValue(snapshot.data),
                      onChanged: bloc.onNotificationTap);
                }),
                StreamBuilder(
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return SwitchListTile(
                        title: Text('Popup Notification'),
                        value: bloc.disableValue(snapshot.data),
                        onChanged: bloc.onPopupTap);
                  },
                ),
                StreamBuilder(
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return MyRadioDialogTile(
                      leadingIcon: Icons.surround_sound,
                      title: 'Alarm',
                      options: [
                        'Silent',
                        'Vibrate',
                        'Sound',
                      ],
                      groupValue: bloc.alarmGroupValue(snapshot.data),
                      trailing: bloc.alarmGroupValue(snapshot.data),
                      onSubmit: bloc.onAlarmSubmitted,
                    );
                  },
                )
              ]).toList(),
            ),
          );
        });
  }
}
