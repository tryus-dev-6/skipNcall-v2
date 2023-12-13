import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../Util/ColorCodes.dart';
import 'BalanceAndBilling.dart';
import 'Dashboard.dart';
import 'Packages.dart';
import 'PayableLead.dart';
import 'Zips.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  PersistentTabController controller = PersistentTabController(initialIndex: 0);


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: color0,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: color0,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: PersistentTabView(
              context,
              controller: controller,
              margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10),
              screens: _buildScreens(),
              items: _navBarsItems(),
              confineInSafeArea: true,
              backgroundColor:
              color0, // Default is Colors.white.
              handleAndroidBackButtonPress: true, // Default is true.
              resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
              stateManagement: true, // Default is true.
              hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
              decoration: NavBarDecoration(
                borderRadius: BorderRadius.circular(10.0),
                colorBehindNavBar: Colors.white,
              ),
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: const ItemAnimationProperties(
                // Navigation Bar's items animation properties.
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),
              navBarStyle: NavBarStyle
                  .style10, // Choose the nav bar style with this property.
            ),
          )
        ],
      ),
    );;
  }

  List<Widget> _buildScreens() {
      return [
        Dashboard(controller),
        const Packages(),
        const Zip(),
        const PayableLead(),
        const BalanceAndBilling(),
      ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          title: "Home",
          textStyle: TextStyle(color: Colors.white),
          icon: const Icon(
            Icons.work_history,
            color: Colors.white,
            size: 20,
          ),
          inactiveIcon: const Icon(
            Icons.work_history,
            color: Color(0xc8ffffff),
            size: 20,
          ),
          iconSize: 20,
          activeColorPrimary: const Color(0X2DFFFFFF),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          title: "Packages",
          icon: const Icon(
            Icons.dashboard,
            color: Colors.white,
            size: 20,
          ),
          inactiveIcon: const Icon(
            Icons.dashboard_outlined,
            color: Color(0xc8ffffff),
            size: 20,
          ),
          iconSize: 20,
          activeColorPrimary: const Color(0X2DFFFFFF),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          title: "Zips",
          icon: const Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: 20,
          ),
          inactiveIcon: const Icon(
            Icons.location_on_outlined,
            color: Color(0xc8ffffff),
            size: 20,
          ),
          iconSize: 20,
          activeColorPrimary: const Color(0X2DFFFFFF),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          title: "Lead",
          icon: SvgPicture.asset(
              'assets/images/ic_unpaid_lead1.svg',
              width: 20,
              height: 20,
              color: Colors.white
          ),
          inactiveIcon: SvgPicture.asset(
            'assets/images/ic_unpaid_lead.svg',
            width: 20,
            height: 20,
            color: Colors.white,
          ),
          iconSize: 20,
          activeColorPrimary: const Color(0X2DFFFFFF),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          title: "Balance",
          icon: SvgPicture.asset(
              'assets/images/ic_balance_clicked.svg',
              width: 20,
              height: 20,
              color: Colors.white
          ),
          inactiveIcon: SvgPicture.asset(
            'assets/images/ic_balance.svg',
            width: 20,
            height: 20,
            color: Colors.white,
          ),
          iconSize: 20,
          activeColorPrimary: const Color(0X2DFFFFFF),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

}
