
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:skip_n_call/Api/Constants.dart';
import 'package:skip_n_call/Pages/ChangeEmail.dart';
import 'package:skip_n_call/Pages/EditProfile.dart';
import 'package:skip_n_call/Pages/Home.dart';
import 'package:skip_n_call/Pages/LeadDetailsData.dart';
import 'package:skip_n_call/Pages/LeadDetailsList.dart';
import 'package:skip_n_call/Pages/NotificationScreen.dart';
import 'package:skip_n_call/Pages/PasswordSet.dart';
import 'package:skip_n_call/Pages/Profile.dart';
import 'package:skip_n_call/Pages/PurchaseZip.dart';
import 'package:skip_n_call/Pages/SignUp.dart';
import 'package:skip_n_call/Pages/Splash.dart';
import 'package:skip_n_call/Pages/ZipCart.dart';
import 'package:skip_n_call/Pages/ZipDetails.dart';
import 'Helper/SharedPreferencesHelper.dart';
import 'Pages/Login.dart';
import 'Pages/Navigation.dart';
import 'Util/Constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'Util/NotificationService.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = Constants.STRIPE_PUBLISH_KEY;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService notificationService = NotificationService();

  notificationService.firebaseInit();

  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: "/", page: () => const Splash()),
        GetPage(name: "/login", page: () => const Login()),
        GetPage(name: "/signUp", page: () => const SignUp()),
        GetPage(name: "/passwordSet", page: () => const PasswordSet()),
        GetPage(name: "/home", page: () => const Home()),
        GetPage(name: "/profile", page: () => const Profile()),
        GetPage(name: "/editProfile", page: () => const EditProfile()),
        GetPage(name: "/changeEmail", page: () => const ChangeEmail()),
        GetPage(name: "/notification", page: () => const NotificationScreen()),
        GetPage(name: "/leadDetailsData", page: () => const LeadDetailsData()),
        GetPage(name: "/zipCart", page: () => const ZipCart()),
        GetPage(name: "/leadDetailsList", page: () => const LeadDetailsList()),
        GetPage(name: "/zipDetails", page: () => const ZipDetails()),
        GetPage(name: "/purchaseZip", page: () => const PurchaseZip()),
      ],
    );
  }
}