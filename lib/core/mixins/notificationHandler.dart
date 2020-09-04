import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'date_formatter.dart';

class NotificationHandler with FormatterMixin {
  BuildContext context;
  NotificationHandler({@required this.context});
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> initializeLocalNotification() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    InitializationSettings initializationSettings =
        InitializationSettings(androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  static Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }

  Future onSelectNotification(String payLoad) async{
    if (payLoad != null) {
      print('Notification Payload $payLoad');
    }
    await Navigator.pushNamed(context, '/');
  }

  void scheduleNotification(int seconds) {
    Timer(Duration(seconds: seconds), notify);
  }

  Future<void> notify() async {
    await initializeLocalNotification();
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'Channel ID', 'Channel title', 'channel body',
        priority: Priority.High, importance: Importance.Max, ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(getIdFromTime(DateTime.now()), 'Nutracker',
        'Time for your ${getTimeInMeridian(DateTime.now())} drink', notificationDetails);
  }

  Future<void> notifyAfterSec() async {
    await initializeLocalNotification();
    var timeDelayed = DateTime.now().add(Duration(seconds: 5));
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'second channel ID', 'second Channel title', 'second channel body',
        priority: Priority.High, importance: Importance.Max, ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(
        getIdFromTime(DateTime.now()), 'Nutracker', 'Time to take a drink', timeDelayed, notificationDetails);
  }

  int getIdFromTime(DateTime now) => now.hour == 0 ? now.minute : (now.hour * 60) + now.minute;
}
