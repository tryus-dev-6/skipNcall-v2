import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skip_n_call/Helper/SharedPreferencesHelper.dart';
import 'package:skip_n_call/Helper/dialog_helper.dart';
import 'package:skip_n_call/Pages/Login.dart';
import 'package:skip_n_call/Util/NotificationService.dart';
import 'package:skip_n_call/Util/Tools.dart';
import 'dart:async';

import '../Util/Constants.dart';
import 'NotificationScreen.dart';
import 'Profile.dart';

enum SampleItem { itemOne, itemTwo }

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  SampleItem? selectedMenu;

  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.getDeviceToken().then((value) => {

      print("Device Token$value")

    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Color(0Xff634099),
    //   statusBarIconBrightness: Brightness.light,
    // ));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Color(0Xff634099),
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white),
      child: Scaffold(
        body: Container(
            // color: const Color(0XffFDF9FF),
            decoration: const BoxDecoration(
              color: Color(0XffFDF9FF),
              image: DecorationImage(
                image: AssetImage("assets/images/dashboard_bg2.jpg"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: <Widget>[
                  // ScalableImageWidget.fromSISource(
                  //   scale: double.infinity,
                  //   fit: BoxFit.fitWidth,
                  //   alignment: Alignment.topCenter,
                  //   si: ScalableImageSource.fromSvg(
                  //     MySVG(imagePath: 'assets/dashboard_bg.svg'),
                  //     'key',
                  //     compact: true,
                  //   ),
                  // ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // color: Colors.blue,
                            margin: const EdgeInsets.only(
                              left: 20.0,
                            ),
                            child: SvgPicture.asset(
                              'assets/images/logo.svg',
                              height: 45,
                              width: 150,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  child: SvgPicture.asset(
                                    'assets/images/ic_notification.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 60,
                                height: 60,
                                child: PopupMenuButton<SampleItem>(
                                  icon: SvgPicture.asset(
                                    height: 60,
                                    width: 60,
                                    'assets/images/ic_user.svg',
                                    color: Colors.white,
                                  ),
                                  //initialValue: selectedMenu,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  onSelected: (SampleItem item) {
                                    setState(() {
                                      selectedMenu = item;
                                      if (item.index == 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Profile(),
                                          ),
                                        );
                                      }
                                      if (item.index == 1) {
                                        logOut();
                                      }
                                    });
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<SampleItem>>[
                                    PopupMenuItem<SampleItem>(
                                      value: SampleItem.itemOne,
                                      child: ListTile(
                                        horizontalTitleGap: double.minPositive,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0.0),
                                        minLeadingWidth: double.minPositive,

                                        visualDensity: VisualDensity.compact,
                                        leading: SvgPicture.asset(
                                          'assets/images/ic_setting.svg',
                                          color: Colors.black,
                                        ),
                                        // Icon for the first item
                                        title: Container(
                                            margin:
                                                const EdgeInsets.only(left: 15),
                                            child: const Text('Profile')),
                                      ),
                                    ),
                                    PopupMenuItem<SampleItem>(
                                      value: SampleItem.itemTwo,
                                      child: ListTile(
                                        horizontalTitleGap: double.minPositive,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0.0),
                                        minLeadingWidth: double.minPositive,

                                        visualDensity: VisualDensity.compact,
                                        leading: SvgPicture.asset(
                                          'assets/images/ic_log_out.svg',
                                          color: Colors.black,
                                        ),
                                        // Icon for the first item
                                        title: Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: const Text('Log out')),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Column(
                            children: [
                              Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  margin: const EdgeInsets.only(
                                      top: 50.0, left: 20.0, right: 20.0),
                                  elevation: 5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 20.0,
                                            bottom: 20.0),
                                        child: SvgPicture.asset(
                                          'assets/images/ic_my_zip.svg',
                                          height: 60,
                                          width: 60,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(5),
                                        margin: const EdgeInsets.only(top: 5),
                                        child: const Text(
                                          'My Zips',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0Xff434141)),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: const Text(
                                          '98',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0Xff00A18A)),
                                        ),
                                      ),
                                    ],
                                  )),
                              Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  margin: const EdgeInsets.only(
                                      top: 20.0, left: 20.0, right: 20.0),
                                  elevation: 5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 20.0,
                                            bottom: 20.0),
                                        child: SvgPicture.asset(
                                          'assets/images/ic_data.svg',
                                          height: 60,
                                          width: 60,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(5),
                                        margin: const EdgeInsets.only(
                                            right: 10, top: 5),
                                        child: const Text(
                                          'Data',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0Xff434141)),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: const Text(
                                          '98',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0Xff434141)),
                                        ),
                                      ),
                                    ],
                                  )),
                              Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  margin: const EdgeInsets.only(
                                      top: 20.0, left: 20.0, right: 20.0),
                                  elevation: 5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 20.0,
                                            bottom: 20.0),
                                        child: SvgPicture.asset(
                                          'assets/images/ic_attend.svg',
                                          height: 60,
                                          width: 60,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(5),
                                        margin: const EdgeInsets.only(
                                            right: 10, top: 5),
                                        child: const Text(
                                          'Attend',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0Xff434141)),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: const Text(
                                          '98',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0XffFFB100)),
                                        ),
                                      ),
                                    ],
                                  )),
                              Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  margin: const EdgeInsets.only(
                                      top: 20.0, left: 20.0, right: 20.0),
                                  elevation: 5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 20.0,
                                            bottom: 20.0),
                                        child: SvgPicture.asset(
                                          'assets/images/ic_pending.svg',
                                          height: 60,
                                          width: 60,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        // decoration: BoxDecoration(
                                        //     color: const Color(0Xff634099),
                                        //     border: Border.all(
                                        //       color: const Color(0Xff634099),
                                        //     ),
                                        //     borderRadius: const BorderRadius.all(
                                        //         Radius.circular(8))
                                        // ),
                                        padding: const EdgeInsets.all(5),
                                        margin: const EdgeInsets.only(
                                            right: 10, top: 5),
                                        child: const Text(
                                          'Pending',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0Xff434141)),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: const Text(
                                          '98',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0Xff634099)),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  void logOut() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: const Text(
                            "Are you sure you want to logout ?",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black87, decoration: TextDecoration.none, fontFamily: 'system', fontWeight: FontWeight.normal),
                          )),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(Colors.red),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),

                            ),
                            onPressed: (){
                              Navigator.of(context).pop();
                              performLogOut();
                            },
                            child: const Text(
                            'Ok',
                            style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(Color(0Xff634099)),

                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                                ),
                              ),

                            ),
                            onPressed: (){

                              Navigator.of(context).pop();

                            }, child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 16),
                          ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void performLogOut() {
    //DialogHelper.showLoading();
    SharedPreferencesHelper.removeData(
        SKIP_N_CALL_USER_USERID);
    //DialogHelper.hideDialog();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
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
