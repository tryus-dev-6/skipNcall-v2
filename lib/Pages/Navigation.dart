import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';

import 'BalanceAndBilling.dart';
import 'Dashboard.dart';
import 'Packages.dart';
import 'Transaction.dart';
import 'Zips.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int index = 0;

  final screens = [
    const Dashboard(),
    const Packages(),
    const Zip(),
    const Transaction(),
    const BalanceAndBilling(),
  ];

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0XffFDF9FF),
      statusBarIconBrightness: Brightness.dark,

    ));

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          labelTextStyle: MaterialStatePropertyAll(
              TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
        ),
        child: NavigationBar(
          height: 70,
          indicatorColor: const Color(0XffF5F5FF),
          backgroundColor: Colors.white,
          selectedIndex: index,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          //animationDuration: const Duration(seconds: 1),
          onDestinationSelected: (index) => {
            setState(() => this.index = index)
          },
          destinations: [
            const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Home'),

            const NavigationDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: 'Packages'),

            const NavigationDestination(
                icon: Icon(Icons.location_on_outlined),
                selectedIcon: Icon(Icons.location_on_rounded),
                label: 'Zips'),

            NavigationDestination(
                selectedIcon: SizedBox(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(
                    'assets/images/ic_transaction.svg',
                    width: 20,
                    height: 20,
                  ),
                ),
                icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(
                    'assets/images/transaction2.svg',
                    width: 20,
                    height: 20,
                  ),
                ),
                label: 'Transaction'
            ),

            NavigationDestination(
                selectedIcon: SizedBox(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(
                    'assets/images/ic_balance_clicked.svg',
                    width: 20,
                    height: 20,
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
    );
  }
}

