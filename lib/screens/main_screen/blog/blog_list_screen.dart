import 'package:auto_animated/auto_animated.dart';
import 'package:cusipco/screens/chat/chat_list_screen.dart';
import 'package:cusipco/screens/main_screen/blog/blog_listing_model.dart';
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

class BlogListScreen extends StatefulWidget {
  final BlogListingModel list;
  final slider;
  final  Function(Data data, dynamic context) onClickModule;
  final String title;
  const BlogListScreen({Key? key, required this.list, required this.title, this.slider,  required this.onClickModule}) : super(key: key);

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  @override
  void initState() {

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
                        itemCount: widget.list.data!.length,
                        physics: BouncingScrollPhysics(),
                        options: AnimationService.animationOption,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index,
                            Animation<double> animation) {
                          final data = widget.list.data![index];

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
                                  Column(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                        ),
                                        child: Image.asset(
                                          data.image.toString(),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Text(
                                        data.title.toString(),
                                        style: TextStyle(
                                          color: ThemeClass.blackColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
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


  goto(Widget _screen) {
    pushNewScreen(
      context,
      screen: _screen,
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
