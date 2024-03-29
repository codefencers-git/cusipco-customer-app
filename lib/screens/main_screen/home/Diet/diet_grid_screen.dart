import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cusipco/screens/main_screen/home/Diet/customized_diet_plan.dart';
import 'package:cusipco/screens/main_screen/home/Diet/standard_diet_plan.dart';
import 'package:cusipco/themedata.dart';
import 'package:cusipco/widgets/app_bars/appbar_with_text.dart';
import 'package:cusipco/widgets/slider_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class DietGridScreen extends StatefulWidget {
  DietGridScreen({Key? key}) : super(key: key);

  @override
  State<DietGridScreen> createState() => _DietGridScreenState();
}

class _DietGridScreenState extends State<DietGridScreen> {
  CarouselController buttonCarouselController = CarouselController();
  int _activePage = 0;

  List<HomeGridModel> GridItems = [];
  @override
  void initState() {
    super.initState();

    GridItems = [
      HomeGridModel(
        image: "assets/images/diet_basic.png",
        title: "Basic Diet Plan",
        color: ThemeClass.whiteColor,
        id: "1",
        onPress: () {
          pushNewScreen(
            context,
            screen: StanderdDietPlanScreen(
              type: "Standard",
              title: "Basic Diet Plan",
            ),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      HomeGridModel(
        image: "assets/images/diet_advance.png",
        title: "Advanced Diet Plan",
        color: ThemeClass.whiteColor,
        id: "2",
        onPress: () {
          pushNewScreen(
            context,
            screen: CustomizedDietPlanScreen(
              type: "Customized",
              title: "Advanced Diet Plan",
            ),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      HomeGridModel(
        image: "assets/images/diet_nutri.png",
        title: "Online Consultation \nwith Nutritionist",
        color: ThemeClass.whiteColor,
        id: "3",
        onPress: () {
          pushNewScreen(
            context,
            screen: CustomizedDietPlanScreen(
              title: "Online Consultation \nwith Nutritionist",
              type: "Unconfirmed",
            ),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: ThemeClass.safeareBackGround,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(65.0),
              child: AppBarWithTextAndBackWidget(
                onbackPress: () {
                  Navigator.pop(context);
                },
                title: "Diet",
                isShowCart: true,
              )),
          body: Container(
              color: ThemeClass.whiteColor,
              height: height,
              width: width,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SliderWidget(
                      type: "diet",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0),
                        itemCount: GridItems.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return _buildCardItem(GridItems[index]);
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    // Image.asset(
                    //   "assets/images/diet_bottom.png",
                    //   width: width * 0.9,
                    // ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Container _buildCardItem(HomeGridModel data) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4 ),
      // color: Colors.red,
      width: MediaQuery.of(context).size.height * 0.21,

      child: InkWell(
        onTap: () {
          data.onPress();
        },
        child: Column(
          children: [
            Container(
              width: 130,
              height:130,
              margin: EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                color: data.color,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Image.asset(
                  data.image,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeGridModel {
  String image;
  String title;
  Color color;
  String id;
  Function onPress;

  HomeGridModel(
      {required this.image,
      required this.title,
      required this.onPress,
      required this.color,
      required this.id});
}

class SliderModel {
  String? image;
  String? title;
  String? subtitle;
  String? description;

  SliderModel({this.image, this.title, this.subtitle, this.description});
}
