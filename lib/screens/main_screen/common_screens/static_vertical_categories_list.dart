import 'package:auto_animated/auto_animated.dart';
import 'package:cusipco/screens/chat/chat_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:cusipco/screens/main_screen/home/Doctor/doctor_list_screen.dart';
import 'package:cusipco/service/animation_service.dart';
import 'package:cusipco/service/prowider/doctor_category_provider.dart';
import 'package:cusipco/widgets/app_bars/appbar_with_text.dart';
import 'package:cusipco/widgets/online_offline_bottom_sheet.dart';

import 'package:cusipco/widgets/slider_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../themedata.dart';

class StaticVerticalCategoriesList extends StatefulWidget {
  final List list;
  final slider;
  final Null Function(Map<String, Object> data, dynamic context) onClickModule;
  final String title;
  const StaticVerticalCategoriesList({Key? key, required this.list, required this.title, this.slider,  required this.onClickModule}) : super(key: key);

  @override
  State<StaticVerticalCategoriesList> createState() => _StaticVerticalCategoriesListState();
}

class _StaticVerticalCategoriesListState extends State<StaticVerticalCategoriesList> {
  @override
  void initState() {
    Provider.of<DoctorsCategoryService>(context, listen: false)
        .getDoctorsCategory(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DoctorsCategoryService>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: ThemeClass.safeareBackGround,
      child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(65.0),
                child: AppBarWithTextAndBackWidget(
                  extraIcon: false,
                  onTap: (context){
                    goto(ChatScreen());
                  },
                  onbackPress: () {
                    Navigator.pop(context);
                  },
                  title: widget.title.toString(),
                  isShowCart: true,
                )),
            body: Container(
              color: ThemeClass.whiteColor,
              height: height,
              width: width,
              child: Column(
                children: [
                 widget.slider ?? Container(),
                  model.loading
                      ? Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 2,
                      ),
                      child: CircularProgressIndicator(
                        color: ThemeClass.blueColor,
                      ),
                    ),
                  )
                      : model.isError
                      ? Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 2,
                      ),
                      child: Text(model.errorMessage),
                    ),
                  )
                      : Expanded(
                    child: LiveList.options(
                        itemCount: widget.list.length,
                        physics: BouncingScrollPhysics(),
                        options: AnimationService.animationOption,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index,
                            Animation<double> animation) {
                          final data = widget.list[index];

                          return FadeTransition(
                            opacity: Tween<double>(
                              begin: 0,
                              end: 1,
                            ).animate(animation),
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(0, 0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: Column(
                                children: [
                                  index == 0
                                      ? SizedBox(
                                    height: 16,
                                  )
                                      : SizedBox(),
                                  ListTile(
                                    onTap: () {
                                      widget.onClickModule(data, context);
                                    },
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                      ),
                                      child: Image.asset(
                                        data["image"].toString(),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    title: Text(
                                      data["text"].toString(),
                                      style: TextStyle(
                                        color: ThemeClass.blackColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Divider()
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _checkNavigation(data) async {
    var res = await showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return BottomSheetForOnlineOffLineDoctore();
        });
    print(res);
    if (res == "Book Appointment") {
      pushNewScreen(context,
          screen: DoctorListScreen(
            mode: "Book-Appointment",
            categoryId: data.id.toString(),
          ),
          withNavBar: true);
    } else if (res == "Immediate Consultation") {
      pushNewScreen(context,
          screen: DoctorListScreen(
            mode: "Instant-Consultation",
            categoryId: data.id.toString(),
          ),
          withNavBar: true);
    } else if(res == "Face to Face Consultation"){
      pushNewScreen(context,
          screen: DoctorListScreen(
            mode: "Offline",
            categoryId: data.id.toString(),
          ),
          withNavBar: true);
    }


    int clicked = 0;
    if (res == "Online") {
      res = null;
      var mode = await showDialog(
          context: context,
          builder: (builder) {
            return Center(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  height: 150,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              clicked = 1;
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 10),
                              child: Text(
                                "Book-Appointment",
                                style: TextStyle(fontSize: 15),
                              ),
                            )),
                      ),
                      Divider(),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              clicked = 2;
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 10),
                              child: Text(
                                "Instant Consultation",
                                style: TextStyle(fontSize: 15),
                              ),
                            )),
                      ),
                    ],
                  )),
            );
          });
    }
    // For Instant Consultation & Book Appointment Button
    if (clicked == 1) {
      print("Book Appointment");
      pushNewScreen(context,
          screen: DoctorListScreen(
            mode: "Book-Appointment",
            categoryId: data.id.toString(),
          ),
          withNavBar: true);
    } else if (clicked == 2) {
      print("Instant Consultation");
      pushNewScreen(context,
          screen: DoctorListScreen(
            mode: "Instant-Consultation",
            categoryId: data.id.toString(),
          ),
          withNavBar: true);
    }

    //For Bottom Sheet Online, Offline And Face To Face Buttons
    if (res != null) {
      if (res == "Offline") {
        print("Offline");
      } else if (res == "Face to face") {
        print("Face To Face");
      }
    }
  }

  goto(Widget _screen) {
    pushNewScreen(
      context,
      screen: _screen,
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
