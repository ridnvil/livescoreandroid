import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:livescore/uiapps/home_layout.dart';
import 'package:livescore/uiapps/login_layout.dart';
import 'package:path/path.dart';


Future<void> main() async{
  final int  helloAlarmID = 0;

  void printHello() {
    final DateTime now = new DateTime.now();
    final int isolateId = Isolate.current.hashCode;
    print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeLayout(),
    initialRoute: '/',
    routes: {
      HomeLayout.tag: (ctx) => HomeLayout(),
      LoginLayout.tag: (ctx) => LoginLayout(),
    },
  ));
//  await AndroidAlarmManager.periodic(const Duration(minutes: 1), helloAlarmID, (){
//    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//    var initializationSettingsAndroid =
//        new AndroidInitializationSettings('app_icon');
//    var initializationSettingsIOS = new IOSInitializationSettings();
//    var initializationSettings = new InitializationSettings(
//        initializationSettingsAndroid, initializationSettingsIOS);
//    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//    flutterLocalNotificationsPlugin.initialize(initializationSettings,
//        onSelectNotification: onSelectNotification);
//  });

}
//
//Future onSelectNotification(String payload) async {
//  if (payload != null) {
//    debugPrint('notification payload: ' + payload);
//  }
//}
