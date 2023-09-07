import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'EditProfile.dart';

enum SampleItem { itemOne}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0Xff634099),
      statusBarIconBrightness: Brightness.light,
    ));

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(
          color: Color(0Xff634099), // <-- SEE HERE
        ),
        centerTitle: true,
        title: const Text("Profile",
            style: TextStyle(
              color: Color(0Xff634099),
            )),
        backgroundColor: const Color(0XffFDF9FF),

        actions: <Widget>[
          PopupMenuButton<SampleItem>(
            icon: SvgPicture.asset(
              height: 18,
              'assets/images/ic_3dot_menu.svg',
              color: const Color(0Xff634099),
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
                      const EditProfile(),
                    ),
                  );
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
                  // Icon for the first item
                  title: Container(
                      margin:
                      const EdgeInsets.only(left: 15),
                      child: const Text('Edit')
                  ),
                ),
              ),
            ],
          ),
        ],

      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0XffFDF9FF),
        ),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: Stack(
                      children: <Widget>[
                        const SizedBox(
                          width: 90,
                          height: 90,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/ic_user2.png'),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Card(
                              margin:
                                  const EdgeInsets.only(right: 10, bottom: 10),
                              color: const Color(0Xff00A18A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                height: 25,
                                width: 25,
                                child: SvgPicture.asset(
                                  'assets/images/ic_edit.svg',
                                  height: 10,
                                  width: 10,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 15),
              child: const Column(
                children: [
                  Text(
                    'Abdulla Al Mued',
                    style: TextStyle(fontSize: 20, color: Color(0Xff434141)),
                  ),
                  Text(
                    'abdullaalmuid101@gmail.com',
                    style: TextStyle(fontSize: 14, color: Color(0Xff696969)),
                  ),
                  Text(
                    '01831553096',
                    style: TextStyle(fontSize: 14, color: Color(0Xff696969)),
                  ),
                ],
              ),
            ),
            Card(
              color: const Color(0Xff634099),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.only(
                  right: 15, left: 15, top: 20, bottom: 15),
              child: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(5),
                          child: const Text(
                            'Balance',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(5),
                          child: const Text(
                            '\$ 12,2545',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(5),
                          child: const Text(
                            'Expense',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(5),
                          child: const Text(
                            '\$ 12,2545',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 15),
              child: const Text(
                'General',
                style: TextStyle(fontSize: 20, color: Color(0Xff434141)),
              ),
            ),
            Card(
              color: const Color(0XffEFEFEF),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.only(
                  right: 15, left: 15, top: 10, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 15, right: 10),
                        child: SvgPicture.asset(
                          'assets/images/ic_top_up.svg',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Top-Up',
                            style: TextStyle(
                                fontSize: 18, color: Color(0Xff424853)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5, left: 0.5),
                            child: const Text(
                              'Balance',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0Xff858585)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, right: 25),
                    child: SvgPicture.asset(
                      'assets/images/ic_right.svg',
                      height: 25,
                      width: 20,
                      color: const Color(0Xff424853),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: const Color(0XffEFEFEF),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 15, right: 10),
                        child: SvgPicture.asset(
                          'assets/images/ic_top_up_history.svg',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Top-Up History',
                            style: TextStyle(
                                fontSize: 18, color: Color(0Xff424853)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5, left: 0.5),
                            child: const Text(
                              'Overall History',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0Xff858585)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, right: 25),
                    child: SvgPicture.asset(
                      'assets/images/ic_right.svg',
                      height: 25,
                      width: 20,
                      color: const Color(0Xff424853),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: const Color(0XffEFEFEF),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.only(right: 15, left: 15, bottom: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 15, right: 10),
                        child: SvgPicture.asset(
                          'assets/images/ic_privacy_policy.svg',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Privacy & Policy',
                            style: TextStyle(
                                fontSize: 18, color: Color(0Xff424853)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5, left: 0.5),
                            child: const Text(
                              'Overall Policy',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0Xff858585)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, right: 25),
                    child: SvgPicture.asset(
                      'assets/images/ic_right.svg',
                      height: 25,
                      width: 20,
                      color: const Color(0Xff424853),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
