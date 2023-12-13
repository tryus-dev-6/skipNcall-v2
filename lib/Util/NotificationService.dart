

import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
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

    initLocalNotifications();
    FirebaseMessaging.onMessage.listen((message) {

      // if (kDebugMode) {
      //   //print(message.notification!.body.toString());
      //   print(message.notification!.title.toString());
      // }

      showNotification(message);

    });
  }

  Future<void> initPushNotifications() async {

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    // FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    // FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    // FirebaseMessaging.onMessage.listen((message) {
    //   final notification = message.notification;
    //
    //   if (notification==null) return;
    //
    //   localNotifications.show(notification.hashCode, notification.title, notification.body, NotificationDetails(
    //       android: AndroidNotificationDetails(androidChannel.id, androidChannel.name, icon: '@drawable/ic_launcher')
    //   ), payload: jsonEncode(message.toMap()));
    // });
  }

  Future<void> initLocalNotifications() async {

    var androidInitSettings = const AndroidInitializationSettings("@mipmap/launcher_icon");
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

  void showNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      final title = notification.title;
      final body = notification.body;

      if (title != null && body != null) {
        AndroidNotificationChannel channel = AndroidNotificationChannel(
          Random.secure().nextInt(1000000).toString(),
          'skip_n_call_notification',
          groupId: "notification",
          importance: Importance.max,
          showBadge: true,

        );

        AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
          channel.id.toString(),
          channel.name.toString(),
          channelDescription: 'notification description',
          importance: Importance.high,
          priority: Priority.high,
          ticker: 'ticker',
        );

        const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

        NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails,
          iOS: darwinNotificationDetails,
        );

        Future.delayed(
          Duration.zero, () {
          flutterLocationPlugin.show(
            0,
            title,
            body,
            notificationDetails,
          );
        },
        );
      }
    }
  }

}