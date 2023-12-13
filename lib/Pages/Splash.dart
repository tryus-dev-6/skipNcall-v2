import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Helper/SharedPreferencesHelper.dart';
import '../Util/Constants.dart';
import 'package:jovial_svg/jovial_svg.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

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
        Get.offAllNamed("/login");
      });
    }
    else{

      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed("/home");
      });

    }
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent, // Set status bar color
      statusBarIconBrightness: Brightness.dark, // Change icon color
      systemNavigationBarColor: Colors.transparent
    ));

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
