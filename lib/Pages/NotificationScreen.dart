import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Color(0Xff634099),
    //   statusBarIconBrightness: Brightness.light,
    // ));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Color(0Xff634099), // <-- SEE HERE
          ),
          centerTitle: true,
          title: const Text("Notification",
              style: TextStyle(
                color: Color(0Xff634099),
              )),
          backgroundColor: Colors.white,
        ),
        body: Container(
            decoration: const BoxDecoration(
              color: Color(0XffFDF9FF),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            margin: const EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            elevation: 5,
                            color: const Color(0XffEFEFEF),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(left: 10.0,top: 5, bottom: 5),
                                  child: SvgPicture.asset(
                                    'assets/images/ic_notification2.svg',
                                    height: 45,
                                    width: 45,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0,top: 5, bottom: 5),
                                      child: const Text(
                                        'A lead just came in',
                                        style: TextStyle(
                                            fontSize: 14, color: Color(0Xff434141)),
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0, bottom: 5),
                                      child: const Text(
                                        '10 september, 2022',
                                        style: TextStyle(
                                            fontSize: 14, color: Color(0Xff00A18A)
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],

                                ),
                              ],
                            )
                        ),
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            margin: const EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            elevation: 5,
                            color: const Color(0XffEFEFEF),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(left: 10.0,top: 5, bottom: 5),
                                  child: SvgPicture.asset(
                                    'assets/images/ic_notification2.svg',
                                    height: 45,
                                    width: 45,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0,top: 5, bottom: 5),
                                      child: const Text(
                                        'A lead just came in',
                                        style: TextStyle(
                                            fontSize: 14, color: Color(0Xff434141)),
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0, bottom: 5),
                                      child: const Text(
                                        '10 september, 2022',
                                        style: TextStyle(
                                            fontSize: 14, color: Color(0Xff00A18A)
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],

                                ),
                              ],
                            )
                        ),
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            margin: const EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            elevation: 5,
                            color: const Color(0XffEFEFEF),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(left: 10.0,top: 5, bottom: 5),
                                  child: SvgPicture.asset(
                                    'assets/images/ic_notification2.svg',
                                    height: 45,
                                    width: 45,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0,top: 5, bottom: 5),
                                      child: const Text(
                                        'A lead just came in',
                                        style: TextStyle(
                                            fontSize: 14, color: Color(0Xff434141)),
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0, bottom: 5),
                                      child: const Text(
                                        '10 september, 2022',
                                        style: TextStyle(
                                            fontSize: 14, color: Color(0Xff00A18A)
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],

                                ),
                              ],
                            )
                        ),
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            margin: const EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            elevation: 5,
                            color: const Color(0XffEFEFEF),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(left: 10.0,top: 5, bottom: 5),
                                  child: SvgPicture.asset(
                                    'assets/images/ic_notification2.svg',
                                    height: 45,
                                    width: 45,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0,top: 5, bottom: 5),
                                      child: const Text(
                                        'A lead just came in',
                                        style: TextStyle(
                                            fontSize: 14, color: Color(0Xff434141)),
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0, bottom: 5),
                                      child: const Text(
                                        '10 september, 2022',
                                        style: TextStyle(
                                            fontSize: 14, color: Color(0Xff00A18A)
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],

                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
