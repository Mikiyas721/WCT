import '../../../../ui/customWidgets/mySettingItem.dart';
import '../../../../ui/customWidgets/myTimePickerDialogTile.dart';
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
                        title: Text('Disable Notification'),
                        value: bloc.disableValue(snapshot.data),
                        onChanged: bloc.onDisableTap,
                      );
                    }),
                StreamBuilder(
                  stream: bloc.nowExercisingStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return SwitchListTile(
                      title: Text('Now Exercising'),
                      value: bloc.nowExercisingValue(snapshot.data),
                      onChanged: bloc.onNowExercisingTap,
                    );
                  },
                ),
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
                ),
                Card(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  margin: EdgeInsets.all(0),
                  shape: BeveledRectangleBorder(),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 100, right: 100),
                        child: Column(children: <Widget>[
                          Text('Sleeping Time'),
                          StreamBuilder(
                            stream: bloc.repo24Stream,
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              return SwitchListTile(
                                  title: Text('24hrs'),
                                  value: bloc.is24Enabled(snapshot.data),
                                  onChanged: bloc.on24Changed);
                            },
                          )
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            StreamBuilder(
                              stream: bloc.sleepTimeStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                return MyTimePickerDialogTile(
                                  title: 'From',
                                  dialogTitle: 'Time from bed',
                                  time: bloc.mapTime(
                                      bloc.getFromBedTrailing(snapshot.data)),
                                  trailing:
                                      bloc.getFromBedTrailing(snapshot.data),
                                  onTimeChanged: bloc.onFromBedChanged,
                                );
                              },
                            ),
                            StreamBuilder(
                              stream: bloc.sleepTimeStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                return MyTimePickerDialogTile(
                                  title: 'To',
                                  dialogTitle: 'Time to bed',
                                  time: bloc.mapTime(
                                      bloc.getToBedTrailing(snapshot.data)),
                                  trailing:
                                      bloc.getToBedTrailing(snapshot.data),
                                  onTimeChanged: bloc.onToBedChanged,
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]).toList(),
            ),
          );
        });
  }
}
