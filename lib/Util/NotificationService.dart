

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {

  FirebaseMessaging messaging = FirebaseMessaging.instance;

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

}