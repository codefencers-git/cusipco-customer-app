import 'package:cached_network_image/cached_network_image.dart';
import 'package:cusipco/themedata.dart';
import 'package:cusipco/widgets/app_bars/appbar_for_home.dart';
import 'package:cusipco/widgets/button_widget/rounded_button_widget.dart';
import 'package:cusipco/widgets/slider_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  List corporateBenifit = [
    {
      "image": "assets/images/dashboard/nutrition_icon.png",
      "text": "Diet Consultation"
    },
    {
      "image": "assets/images/dashboard/page_icon.png",
      "text": "Health Checkup"
    },
    {
      "image": "assets/images/dashboard/girl_icon.png",
      "text": "Women's Health (OBG)"
    },
    {"image": "assets/images/dashboard/corona_icon.png", "text": "Covid Test"},
    {
      "image": "assets/images/dashboard/tablet_icon.png",
      "text": "Pregnancy Test"
    },
    {
      "image": "assets/images/dashboard/thermometer_icon.png",
      "text": "Blood Sugar Test"
    },
  ];

  List helthBenifit = [
    {
      "image": "assets/images/dashboard/heart1_icon.png",
      "text": "Health Checkup"
    },
    {
      "image": "assets/images/dashboard/hospital_icon.png",
      "text": "Order Pharmacy"
    },
    {
      "image": "assets/images/dashboard/doctor_icon.png",
      "text": "Doctor Consultation"
    },
    {
      "image": "assets/images/dashboard/covid_icon.png",
      "text": "Covid Care Plan"
    },
    {
      "image": "assets/images/dashboard/injection_icon.png",
      "text": "Vaccinations"
    },
    {"image": "assets/images/dashboard/teeth_icon.png", "text": "Dental Care"},
    {"image": "assets/images/dashboard/eye_icon.png", "text": "Eye Care"},
    {"image": "assets/images/dashboard/manu1_icon.png", "text": "More"},
  ];

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
              child: AppbarForHomeWidget()),
          body: Container(
              color: ThemeClass.whiteColor,
              height: height,
              width: width,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle("Corporate Benefits", false),
                    _buildGridList(corporateBenifit),
                    _buildOrderCart(),
                    _buildTitle("Health Benefits", true),
                    _buildGridList(helthBenifit),
                    _buildConsultentCart(),
                    SliderWidget(
                      type: "home",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildTitle("Latest Blogs", true),
                    _buildblogView(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  _buildGridListTile(item) {
    return Column(
      children: [
        Container(
          height: 32,
          width: 32,
          child: Image.asset(
            item['image'],
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              item['text'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeClass.blackColor,
                fontFamily: "Gilory",
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildGridList(List list) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 2.2),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
      ),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildGridListTile(list[index]);
      },
    );
  }

  Widget _buildblogView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...[1, 2, 3].map(
            (e) => _buildBlogListtile(),
          )
        ],
      ),
    );
  }

  Container _buildBlogListtile() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            height: 150,
            imageUrl:
                "https://images.unsplash.com/photo-1612550761236-e813928f7271?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YnVzc2luZXNzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Center(
                child: CircularProgressIndicator(color: ThemeClass.blueColor)),
            errorWidget: (context, url, error) =>
                Center(child: Icon(Icons.error)),
          ),
          SizedBox(
            height: 5,
          ),
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
                  "25 Feb 2023",
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
                  "By Admin",
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
          SizedBox(
            height: 5,
          ),
          Text(
            "Book Your Dr. Consultation",
            style: TextStyle(
              color: ThemeClass.blackColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,...",
            style: TextStyle(
              color: ThemeClass.greyColor,
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Read More",
            style: TextStyle(
              color: ThemeClass.blueColor22,
              fontWeight: FontWeight.w500,
              fontFamily: "Gilory",
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildConsultentCart() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: ThemeClass.whiteColorgrey,
      padding: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ThemeClass.whiteColorgrey,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              ThemeClass.blueColor.withOpacity(0.21),
              ThemeClass.blueColor3.withOpacity(0.21),
            ],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Book  Your Dr. Consultation",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ThemeClass.blueColor22,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Set a date and time slot and book your consultation  as per your availability",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ThemeClass.greyColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: ButtonWidget(
                    title: "Book Now",
                    fontsize: 12,
                    color: ThemeClass.blueColor,
                    callBack: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildOrderCart() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: ThemeClass.whiteColorgrey,
      padding: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ThemeClass.whiteColorgrey,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              ThemeClass.blueColor.withOpacity(0.21),
              ThemeClass.blueColor3.withOpacity(0.21),
            ],
          ),
        ),
        child: Column(
          children: [
            Text(
              "Order With Prescription",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: ThemeClass.blueColor22,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Upload a prescription and tell us what you need. we do the rest!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeClass.greyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: ButtonWidget(
                  title: "Order Now",
                  fontsize: 12,
                  color: ThemeClass.blueColor,
                  callBack: () {}),
            ),
          ],
        ),
      ),
    );
  }

  _buildTitle(String title, bool isShowICon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: ThemeClass.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              isShowICon
                  ? Row(
                      children: [
                        Text(
                          "View All",
                          style: TextStyle(
                            color: ThemeClass.blueColor22,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          size: 15,
                          color: ThemeClass.blueColor22,
                        ),
                      ],
                    )
                  : SizedBox()
            ],
          ),
          Divider()
        ],
      ),
    );
  }

  InkWell _buildCardItem(HomeGridModel data) {
    return InkWell(
      onTap: () {
        data.onPress();
      },
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(data.image.toString()),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: Text(
                  "${data.title.toString()}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
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
