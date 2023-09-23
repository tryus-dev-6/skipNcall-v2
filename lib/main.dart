import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:skip_n_call/Api/Constants.dart';
import 'Helper/SharedPreferencesHelper.dart';
import 'Pages/Login.dart';
import 'Pages/Navigation.dart';
import 'Util/Constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = Constants.STRIPE_PUBLISH_KEY;

  runApp(const MyApp());
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

    return const GetMaterialApp(
      title: 'Flutter layout demo',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String userId = '';

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<void> getData()async {
    String? retrievedUserId = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);
    userId = retrievedUserId ?? '';

    debugPrint("userId: $userId");

    if(userId.isEmpty){
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      });
    }
    else{

      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Navigation(index: 2),
          ),
        );
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
            child:Padding(
              padding: const EdgeInsets.all(35.0),
              child: ScalableImageWidget.fromSISource(
                si: ScalableImageSource.fromSvg(
                  MySVG(imagePath: 'assets/images/logo.svg'),
                  'key',
                  compact: true,
                ),
              ),
            )
        ),
      ),
    );
  }

}


class MySVG extends AssetBundle {
  final String imagePath;
  MySVG({required this.imagePath});
  @override
  Future<ByteData> load(String key) async {
    // TODO: implement load
    return await rootBundle.load(imagePath);
  }

  @override
  Future<T> loadStructuredData<T>(
      String key, Future<T> Function(String value) parser) {
    // TODO: implement loadStructuredData
    throw UnimplementedError();
  }
}
