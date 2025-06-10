import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import '../global_var.dart' as global;

class LocalNotification {
  static late bool isDarkMode1;

  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  static const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static init() async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  static display(String title, String content) {
    flutterLocalNotificationsPlugin.show(
    0,
    title,
    content,

    NotificationDetails(
      android: AndroidNotificationDetails(
        "0",
        "Agestage",
        channelDescription: "Notifs de Agestage",
        importance: Importance.high,
        color: const Color(global.commonTheme),
        playSound: true,
        icon: '@mipmap/ic_launcher',
      ),
    ),
    payload: "Open from notification"
  );

  }
}