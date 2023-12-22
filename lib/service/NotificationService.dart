
/*
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {

    
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('agsil');
    
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      //onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, 
      iOS: initializationSettingsIOS, 
      macOS: null
    ); 
    
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification
    ); 

    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "1", 
      "Agsil",
    );
    

    const IOSNotificationDetails iOSPlatformChannelSpecifics =
    IOSNotificationDetails(
        presentAlert: false,  // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        presentBadge: false,  // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        presentSound: true,  // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        //sound: String?,  // Specifics the file path to play (only from iOS 10 onwards)
        //badgeNumber: 1, // The application's icon badge number
        //attachments: List<IOSNotificationAttachment>?, (only from iOS 10 onwards),
        subtitle:"Votre guide touristique digitale", //Secondary description  (only from iOS 10 onwards)
        threadIdentifier: ""
   );

    
    if (Platform.isIOS) {
      const NotificationDetails platformChannelSpecifics = NotificationDetails(iOS: iOSPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.periodicallyShow(0, 'AGSIL',
      'Decouvrez les meilleurs endroit et la programmatioin des evenements de cette semaine', RepeatInterval.weekly, platformChannelSpecifics,
      androidAllowWhileIdle: true);
      
      await flutterLocalNotificationsPlugin.show(
        1,
        "AGSIL",
        "Decouvrez les meilleurs endroit et la programmatioin des evenements de cette semaine",
        platformChannelSpecifics,);

    } else {
      const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
      
      await flutterLocalNotificationsPlugin.periodicallyShow(0, 'AGSIL',
      'Decouvrez les meilleurs endroit et la programmatioin des evenements de cette semaine', RepeatInterval.weekly, platformChannelSpecifics,
      androidAllowWhileIdle: true);
      
      await flutterLocalNotificationsPlugin.show(
        1,
        "AGSIL",
        "Decouvrez les meilleurs endroit et la programmatioin des evenements de cette semaine",
        platformChannelSpecifics);
    }
    
  }

  Future selectNotification(String payload) async {
    runApp(MyApp());
  }
  


}*/