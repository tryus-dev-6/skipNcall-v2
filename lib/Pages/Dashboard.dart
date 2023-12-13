import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:skip_n_call/Helper/SharedPreferencesHelper.dart';
import 'package:skip_n_call/Pages/Login.dart';
import 'package:skip_n_call/Util/ColorCodes.dart';
import 'package:skip_n_call/Util/NotificationService.dart';
import 'dart:async';

import '../Api/Constants.dart';
import '../Api/base_client.dart';
import '../Model/CommonResponse.dart';
import '../Util/Constants.dart';
import 'Navigation.dart';
import 'NotificationScreen.dart';
import 'Profile.dart';

enum SampleItem { itemOne, itemTwo }

class Dashboard extends StatefulWidget {

  PersistentTabController controller;
  Dashboard(this.controller, {super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  SampleItem? selectedMenu;
  String totalBalance = "";
  String warmLead = "";
  String hov = "";
  String rawLead = "";
  String? currentImage;
  String zips = "";

  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initiateDashboardInfo();
    notificationService.requestNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                Get.toNamed("/notification");
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
                                icon: currentImage != null ?
                                CircleAvatar(
                                  backgroundImage:
                                  NetworkImage(currentImage!),
                                  backgroundColor: Colors.white,
                                ):
                                SvgPicture.asset(
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
                                      Get.toNamed(
                                          "/profile");
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      widget.controller.index = 4;
                                    },
                                    child: Card(
                                        color: const Color(0Xff00A18A),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        margin: const EdgeInsets.only(
                                            top: 50.0, left: 15.0, right: 5.0),
                                        elevation: 5,
                                        child: Container(
                                          margin: const EdgeInsets.only(top: 15, bottom: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround, // Aligns children at the start and end
                                            children: [
                                              const Text(
                                                'Top Up',
                                                style: TextStyle(fontSize: 20, color: Colors.white),
                                              ),
                                              SvgPicture.asset(
                                                'assets/images/ic_right2.svg',
                                                height: 30,
                                                width: 30,
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      widget.controller.index = 2;
                                    },
                                    child: Card(
                                        color: const Color(0XffFFB100),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        margin: const EdgeInsets.only(
                                            top: 50.0, left: 5.0, right: 15.0),
                                        elevation: 5,
                                        child: Container(
                                          margin: const EdgeInsets.only(top: 15, bottom: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround, // Aligns children at the start and end
                                            children: [
                                              const Text(
                                                'Add Zip',
                                                style: TextStyle(fontSize: 20, color: Colors.white),
                                              ),
                                              SvgPicture.asset(
                                                'assets/images/ic_right2.svg',
                                                height: 30,
                                                width: 30,
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                margin: const EdgeInsets.only(
                                    top: 15.0, left: 15.0, right: 15.0),
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
                                        'assets/images/ic_dashboard_balance.svg',
                                        height: 60,
                                        width: 60,
                                      ),
                                    ),
                                    Column(
                                      children: [

                                        Container(
                                          margin:
                                          const EdgeInsets.only(right: 20),
                                          child: Text(
                                            '\$$totalBalance',
                                            style: const TextStyle(
                                                fontSize: 22,
                                                color: Color(0Xff434141)),
                                          ),
                                        ),

                                        Container(
                                          //color: const Color(0Xff424853),
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: const Color(0Xff424853),
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          margin: const EdgeInsets.only(
                                              right: 10, top: 5),
                                          child: const Text(
                                            'Total Balance',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      margin: const EdgeInsets.only(
                                          top: 15.0, left: 15.0, right: 5.0),
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          Container(

                                            margin: const EdgeInsets.only(top: 20),
                                            child: const Icon(
                                              Icons.people_alt,
                                              size: 40,
                                              color: Color(0XffFFB100),
                                            ),
                                          ),
                                          Container(
                                            height: 45,
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.only(
                                                top: 5),
                                            child: const Text(
                                              'Warm Lead',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0Xff434141)),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              warmLead,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: color0),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                Expanded(
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      margin: const EdgeInsets.only(
                                          top: 15.0, left: 5.0, right: 15.0),
                                      elevation: 5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(

                                            margin: const EdgeInsets.only(top: 20),
                                            child: const Icon(
                                              Icons.people_alt,
                                              size: 40,
                                              color: Color(0Xff424853),
                                            ),
                                          ),
                                          Container(
                                            height: 45,
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.only(
                                                right: 10, top: 5),
                                            child: const Text(
                                              'Home Owner verified',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0Xff434141)),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              hov,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: color0),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      margin: const EdgeInsets.only(
                                          top: 15.0, left: 15.0, right: 5.0),
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          Container(

                                            margin: const EdgeInsets.only(top: 20),
                                            child: const Icon(
                                              Icons.people_alt,
                                              size: 40,
                                              color: Color(0Xff634099),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.only(
                                                top: 5),
                                            child: const Text(
                                              'Raw Lead',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0Xff434141)),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              rawLead,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: color0),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                Expanded(
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      margin: const EdgeInsets.only(
                                          top: 15.0, left: 5.0, right: 15.0),
                                      elevation: 5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                              top: 20.0,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/images/ic_my_zip.svg',
                                              height: 40,
                                              width: 40,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.only(
                                                right: 10, top: 5),
                                            child: const Text(
                                              'My Zips',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0Xff434141)),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              zips,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: color0),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
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

    Get.offAllNamed("/login");
  }

  Future<void> initiateDashboardInfo() async {
    //DialogHelper.showLoading();

    String? userId =
    await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    var response;

    var profile = {"client_id": userId};

    response = await BaseClient()
        .postWithToken('user/dashboards', profile)
        .catchError((err) {
      debugPrint('error: $err');
    });

    if (response == null) {
      showSnackBar('failed to get response');

      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {
      totalBalance = allDatum.currentBalance!;
      warmLead = allDatum.warmLeadsCount.toString();
      hov = allDatum.hovlLeadsCount.toString();
      rawLead = allDatum.rawLeadsCount.toString();
      zips = allDatum.totalZip.toString();

      if (!mounted) {
        return;
      }

      setState(() {
        if(allDatum.proPic != null) {
          currentImage = Constants.IMAGE_URL + allDatum.proPic!;
        }
      });

    } else {
      if (allDatum.message != null) {
        showSnackBar(allDatum.message.toString());
      }
      if(allDatum.isTokenValid == false){
        toLogInPage();
      }
    }

    //DialogHelper.hideDialog();
  }

  void toLogInPage() {

    SharedPreferencesHelper.removeData(
        SKIP_N_CALL_USER_USERID);

    Get.offAllNamed("/login");

  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: const Color(0Xff1E1E1E),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: Colors.white,
        textColor: Colors.blue,
        onPressed: () {
          SnackbarController.closeCurrentSnackbar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
