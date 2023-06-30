import 'package:auto_animated/auto_animated.dart';
import 'package:cusipco/screens/chat/chat_list_screen.dart';
import 'package:cusipco/screens/main_screen/blog/blog_listing_model.dart';
import 'package:cusipco/screens/main_screen/blog/blog_screen.dart';
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
import 'blog_prowider_service.dart';

class BlogListScreen extends StatefulWidget {
  final slider;
  final Function(Data data, dynamic context) onClickModule;
  final String title;

  const BlogListScreen(
      {Key? key, required this.title, this.slider, required this.onClickModule})
      : super(key: key);

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  @override
  void initState() {
    Provider.of<BlogProviderService>(context, listen: false)
        .getAllBlog(context, {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<BlogProviderService>(context);
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
              onTap: (context) {
                goto(ChatScreen());
              },
              onbackPress: () {
                Navigator.pop(context);
              },
              title: widget.title.toString(),
              isShowCart: false,
            )),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
                          child: Consumer<BlogProviderService>(
                              builder: (context, blogProwider, child) {
                            var list = blogProwider.allBlogListingData;
                            return list != null ? LiveList.options(
                                itemCount: list!.data!.length,
                                physics: BouncingScrollPhysics(),
                                options: AnimationService.animationOption,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index,
                                    Animation<double> animation) {
                                  final data = list.data![index];
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
                                                  height: 12,
                                                )
                                              : SizedBox(),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                 goto(BlogScreen(blogItem: data));
                                                },
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  height: 170,
                                                  width: width - 10,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            12))),
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "READ MORE",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                          data.image.toString(),
                                                        )),
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(12),
                                                  ),
                                                ),
                                              ),
                                              Container(color: Colors.transparent,height: 10,),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 24,
                                                      width: 24,
                                                      child: Image.asset(
                                                        "assets/images/dashboard/calender_icon.png",
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      data.date.toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: ThemeClass.blackColor,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      height: 24,
                                                      width: 24,
                                                      child: Image.asset(
                                                        "assets/images/dashboard/user1_icon.png",
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      data.author.toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: ThemeClass.blackColor,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 5,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        data.title.toString(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          color: ThemeClass
                                                              .blackColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      data.short_description
                                                          .toString(),
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                        color: ThemeClass
                                                            .blackColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 9,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 0, vertical: 10),
                                              child: Divider(
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                }) :  Center(
                              child: CircularProgressIndicator(
                                color: ThemeClass.blueColor,
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
