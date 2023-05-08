import 'package:flutter/material.dart';
import 'package:cusipco/screens/main_screen/cart/cart_prowider_service.dart';
import 'package:cusipco/screens/main_screen/cart/cart_screen.dart';
import 'package:cusipco/themedata.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../screens/video_audio/video_screen.dart';
import '../../service/prowider/doctor_details_provider.dart';

class AppBarWithTextAndBackWidget extends StatelessWidget {
  const AppBarWithTextAndBackWidget(
      {Key? key,
        this.extraIcon,
        this.userId,
      this.onTap,
      this.audiovideo,
      required this.title,
      this.isShowCart = false,
      this.isClickOnCart = true,
      this.onCartPress,
      required this.onbackPress})
      : super(key: key);

  final String title;
  final String? userId;
  final Function onbackPress;
  final bool isShowCart;
  final bool? extraIcon;
  final bool? audiovideo;
  final Function(BuildContext context)? onTap;
  final bool isClickOnCart;
  final Function? onCartPress;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DoctorsDetailsServices>(context);

    return AppBar(
      backgroundColor: ThemeClass.blackColor,
      toolbarHeight: 70,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
      actions: [
        extraIcon == true
            ? Align(
                child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                        onTap: () {
                          onTap!(context);
                          //   Fluttertoast.showToast(
                          //       msg: "Working on it");
                        },
                        child: Icon(Icons.chat))),
              )
            : SizedBox(),
        isShowCart
            ? InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  if (isClickOnCart) {
                    pushNewScreen(
                      context,
                      screen: CartScreen(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  }
                  // onCartPress!();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Stack(
                    children: [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.asset(
                            "assets/images/cart_wihte_icon.png",
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
            : SizedBox(),
        audiovideo == true
            ? Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(msg: "Under maintenance!");
                          },
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          ))),
                  Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: GestureDetector(
                          onTap: () {
                            Provider.of<DoctorsDetailsServices>(context,
                                    listen: false)
                                .getAgoraToken(model.doctorDetailsModel!
                                .data.id, "Video", context: context)
                                .then((value) => {
                                      if(value!.success == "1"){
                                        pushNewScreen(context,
                                            screen: VideoScreen(
                                                roomId: value.data.call_room))
                                      } else {
                                        Fluttertoast.showToast(msg: value.message.toString())
                                      }
                                    }
                                    );
                          },
                          child: Icon(
                            Icons.video_call,
                            color: Colors.white,
                          ))),
                ],
              )
            : SizedBox()
      ],
    );
  }
}
