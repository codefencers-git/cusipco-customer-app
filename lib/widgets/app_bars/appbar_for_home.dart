import 'package:cusipco/screens/main_screen/notifications/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:cusipco/screens/main_screen/cart/cart_prowider_service.dart';
import 'package:cusipco/screens/main_screen/cart/cart_screen.dart';
import 'package:cusipco/service/prowider/location_prowider_service.dart';
import 'package:cusipco/themedata.dart';
import 'package:cusipco/widgets/select_address_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class AppbarForHomeWidget extends StatefulWidget {
  final String? headerText;

  const AppbarForHomeWidget({
    Key? key,
    this.isBackShow = false,
    this.onbackPress,
    this.headerText,
  }) : super(key: key);

  final bool isBackShow;
  final Function? onbackPress;

  @override
  State<AppbarForHomeWidget> createState() => _AppbarForHomeWidgetState();
}

class _AppbarForHomeWidgetState extends State<AppbarForHomeWidget> {
  @override
  void initState() {
    super.initState();
  }

  String? dropdownvalue;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ThemeClass.blackColor,
      toolbarHeight: 70,
      centerTitle: true,
      automaticallyImplyLeading: false,

      title: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 5),
                //   child: Container(
                //     height: 32,
                //     width: 32,
                //     child: Image.asset(
                //       "assets/images/dashboard/manu_icon.png",
                //       fit: BoxFit.contain,
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello! ${widget.headerText}",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ThemeClass.whiteColor),
                    ),
                    Text(
                      "Lorem Ipsum dollar sit",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: ThemeClass.whiteColor.withOpacity(0.6)),
                    ),
                  ],
                )
                // Consumer<LocationProwiderService>(
                //     builder: (context, locationService, child) {
                //   return InkWell(
                //     onTap: () {
                //       pushNewScreen(
                //         context,
                //         screen: SelectAddressScreen(),
                //         withNavBar: false,
                //         pageTransitionAnimation:
                //             PageTransitionAnimation.cupertino,
                //       );
                //     },
                //     child: Text(
                //       locationService.currentLocationCity == null
                //           ? "Select City"
                //           : locationService.currentLocationCity!.name
                //               .toString(),
                //       style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400,
                //           color: ThemeClass.whiteColor),
                //     ),
                //   );
                // }),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  // onCartPress!();
                  pushNewScreen(
                    context,
                    screen: CartScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: NotificationsScreen(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Align(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Image.asset(
                              "assets/images/dashboard/notification_icon.png",
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 17,
                        right: 17,
                        child: Consumer<CardProviderService>(
                            builder: (context, initdataService, child) {
                          if (initdataService.cartData != null &&
                              initdataService.cartData!.items != null &&
                              initdataService.cartData!.items!.isNotEmpty) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              height: 17,
                              width: 17,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Text(initdataService
                                      .cartData!.items!.length
                                      .toString()),
                                ),
                              ),
                            );
                          } else {
                            return Text("");
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // onCartPress!();
                  pushNewScreen(
                    context,
                    screen: CartScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Stack(
                    children: [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Image.asset(
                            "assets/images/dashboard/cart_icon.png",
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 17,
                        right: 17,
                        child: Consumer<CardProviderService>(
                            builder: (context, initdataService, child) {
                          if (initdataService.cartData != null &&
                              initdataService.cartData!.items != null &&
                              initdataService.cartData!.items!.isNotEmpty) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              height: 17,
                              width: 17,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Text(initdataService
                                      .cartData!.items!.length
                                      .toString()),
                                ),
                              ),
                            );
                          } else {
                            return Text("");
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
      // actions: [],
    );
  }
}
