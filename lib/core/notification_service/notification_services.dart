import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificationservice {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    final DarwinInitializationSettings initializationSetingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {
        debugPrint("$id $title $body $payload");
      },
    );
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSetingsDarwin);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  showNotificationdetail() {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'wallpaper_notification_1',
      'wallpaper_notification',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();

    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    flutterLocalNotificationsPlugin.show(
        Random().nextInt(20),
        "Happy Birtthday",
        "Wishing you a very very happy birthday",
        notificationDetails);
  }
}
