import 'package:cusipco/screens/main_screen/my_account/my_appointment/appointments_screen.dart';
import 'package:cusipco/screens/main_screen/my_account/my_order_screen.dart';
import 'package:cusipco/screens/mra-que/question.dart';
import 'package:flutter/material.dart';
import 'package:cusipco/Global/globle_methd.dart';

import 'package:cusipco/screens/main_screen/calarie_counter/calorie_counter_screen.dart';
import 'package:cusipco/screens/main_screen/cart/cart_prowider_service.dart';
import 'package:cusipco/screens/main_screen/home/home_screen.dart';
import 'package:cusipco/screens/main_screen/my_account/my_account_main_screen.dart';
import 'package:cusipco/screens/main_screen/support/support_screen.dart';
import 'package:cusipco/service/prowider/main_navigaton_prowider_service.dart';
import 'package:cusipco/themedata.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  GlobalKey<ScaffoldState> _globalscafoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");

        var provider1 =
            Provider.of<CardProviderService>(context, listen: false);
        provider1.getCart();
        checkAppUpdate(context, isShowNormalAlert: false);
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    checkAppUpdate(context, isShowNormalAlert: true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNavigationProwider>(
        builder: (context, navProwider, child) {
      return Container(
        color: ThemeClass.safeareBackGround,
        child: SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                key: _globalscafoldKey,
                extendBodyBehindAppBar: true,
                body: PersistentTabView(
                  context, controller: navProwider.navController,
                  onItemSelected: (item) {
                    // print("selectedItem:"+item.toString());
                  },
                  navBarHeight: 70,
                  screens: _buildScreens(),
                  items: _navBarsItems(),
                  backgroundColor: ThemeClass.blackColor,
                  padding: NavBarPadding.only(left: 0, right: 0),
                  stateManagement: true,
                  hideNavigationBarWhenKeyboardShows: true,
                  decoration: NavBarDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    colorBehindNavBar: Colors.white,
                  ),
                  popAllScreensOnTapOfSelectedTab: true,
                  popActionScreens: PopActionScreensType.all,
                  itemAnimationProperties: const ItemAnimationProperties(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.ease,
                  ),
                  screenTransitionAnimation: const ScreenTransitionAnimation(
                    animateTabTransition: true,
                    curve: Curves.ease,
                    duration: Duration(milliseconds: 200),
                  ),
                  navBarStyle: NavBarStyle
                      .style2, // Choose the nav bar style with this property.
                ))),
      );
    });
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Column(
          children: [
            Image.asset(
              "assets/images/dashboard/home_icon.png",
              height: 30,
              width: 30,
            ),
            const SizedBox(
              height: 3,
            ),
            Transform.translate(
              offset: Offset(0, -2),
              child: Text(
                "Home",
                style: TextStyle(color: ThemeClass.whiteColor, fontSize: 8),
              ),
            )
          ],
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          children: [
            Image.asset(
              "assets/images/dashboard/heart_icon.png",
              height: 30,
              width: 30,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              "HRA",
              style: TextStyle(color: ThemeClass.whiteColor, fontSize: 8),
            )
          ],
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          children: [
            Image.asset(
              "assets/images/dashboard/calender_icon.png",
              height: 30,
              width: 30,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              "Appointments",
              style: TextStyle(color: ThemeClass.whiteColor, fontSize: 8),
            )
          ],
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          children: [
            Image.asset(
              "assets/images/dashboard/msg_icon.png",
              height: 30,
              width: 30,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              "Orders",
              style: TextStyle(color: ThemeClass.whiteColor, fontSize: 8),
            )
          ],
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          children: [
            Image.asset(
              "assets/images/dashboard/user_icon.png",
              height: 30,
              width: 30,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              "Account",
              style: TextStyle(color: ThemeClass.whiteColor, fontSize: 8),
            )
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      question( ),
      AppointmentsScreen(),
      MyOrderScreen(),
      MyAccountMainScreen()
    ];
  }
}
