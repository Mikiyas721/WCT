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
                StreamBuilder(
                    stream: bloc.disableNotificationStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      return SwitchListTile(
                        title: Text('Disable'),
                        value: bloc.disableValue(snapshot.data),
                        onChanged: bloc.onDisableTap,
                      );
                    }),
                StreamBuilder(
                    stream: bloc.notificationStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return SwitchListTile(
                          title: Text('Notification'),
                          value: bloc.notificationValue(snapshot.data),
                          onChanged: bloc.onNotificationTap);
                    }),
                StreamBuilder(
                  stream: bloc.popupStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return SwitchListTile(
                        title: Text('Popup Notification'),
                        value: bloc.popupValue(snapshot.data),
                        onChanged: bloc.onPopupTap);
                  },
                ),
                StreamBuilder(
                  stream: bloc.alarmStream,
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
                      onRadioSelected: bloc.onAlarmChanged,
                    );
                  },
                )
              ]).toList(),
            ),
          );
        });
  }
}
