import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skip_n_call/Pages/PayableLead.dart';
import 'package:skip_n_call/Util/ColorCodes.dart';

import 'BalanceAndBilling.dart';
import 'Dashboard.dart';
import 'Packages.dart';
import 'Transaction.dart';
import 'Zips.dart';

class Navigation extends StatefulWidget {

  // ignore: prefer_typing_uninitialized_variables
  final index;

  const Navigation({super.key, required this.index});

  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int index = 0;
  late PageController _pageController;
  bool canClose = false;

  @override
  void initState() {

    index = widget.index;
    _pageController = PageController(initialPage: index);

    super.initState();
  }

  final screens = [
    const Dashboard(),
    const Packages(),
    const Zip(),
    const PayableLead(),
    const BalanceAndBilling(),
  ];

  @override
  Widget build(BuildContext context) {

    print("build");

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0XffFDF9FF),
      statusBarIconBrightness: Brightness.dark,

    ));

    return WillPopScope(
      onWillPop: () async{
        if (index > 0) {

          _pageController.animateToPage(
            index - 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );

          return false;

        } else {
          return true;
        }
      },

      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: screens,
          onPageChanged: (newIndex) {
            setState(() {
              index = newIndex;
            });
          },
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(
            labelTextStyle: MaterialStatePropertyAll(
                TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
            elevation: 10,

          ),
          child: NavigationBar(
            height: 80,
            indicatorColor: Colors.transparent,
            elevation: 10,
            backgroundColor: Colors.white,
            selectedIndex: index,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            //animationDuration: const Duration(seconds: 1),
            onDestinationSelected: (newIndex) {
              setState(() {
                index = newIndex;
                _pageController.animateToPage(
                  newIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
            destinations: [
              const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(
                      Icons.home_rounded,
                    color: color0,
                  ),
                  label: 'Home'
              ),

              const NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard,color: color0),
                  label: 'Packages'),

              const NavigationDestination(
                  icon: Icon(Icons.location_on_outlined),
                  selectedIcon: Icon(Icons.location_on_rounded , color: color0),
                  label: 'Zips'),

              NavigationDestination(
                  selectedIcon: SizedBox(
                    width: 25,
                    height: 25,
                    child: SvgPicture.asset(
                      'assets/images/ic_unpaid_lead1.svg',
                      width: 17,
                      height: 17,
                        color: color0
                    ),
                  ),
                  icon: SizedBox(
                    width: 25,
                    height: 25,
                    child: SvgPicture.asset(
                      'assets/images/ic_unpaid_lead.svg',
                      width: 17,
                      height: 17,
                    ),
                  ),
                  label: 'Payable Lead'
              ),

              NavigationDestination(
                  selectedIcon: SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      'assets/images/ic_balance_clicked.svg',
                      width: 20,
                      height: 20,
                        color: color0
                    ),
                  ),
                  icon: SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      'assets/images/ic_balance.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  label: 'Balance'),

            ],
          ),
        ),
      ),
    );
  }

}

