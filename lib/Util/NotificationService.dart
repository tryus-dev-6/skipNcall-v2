

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocationPlugin = FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async{

    NotificationSettings settings = await messaging.requestPermission(

      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,

    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print("permission granted for android");
    }
    else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print("permission granted for iOS");
    }
    else{
      print("permission denied");
    }

  }

  Future<String> getDeviceToken() async {

    String? token = await messaging.getToken();

    return token!;
  }

  void isTokenRefreshed(){
    messaging.onTokenRefresh.listen((event) {

      print(event.toString());
      print("refreshed");

    });
  }

  void firebaseInit(){
    FirebaseMessaging.onMessage.listen((event) {

    });
  }

  Future<void> initLocalNotifications(BuildContext context, RemoteMessage message) async {

    var androidInitSettings = const AndroidInitializationSettings("@drawable/launcher_icon");
    var iOSInitSettings = const DarwinInitializationSettings();

    var initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iOSInitSettings,
    );

    await flutterLocationPlugin.initialize(
        initSettings,
      onDidReceiveNotificationResponse: (payload) => {

      }
    );

  }

}