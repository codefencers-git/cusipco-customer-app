import 'package:cached_network_image/cached_network_image.dart';
import 'package:cusipco/model/general_information_model.dart';
import 'package:cusipco/screens/main_screen/PregnancyTest/pregnancy_test_category_screen.dart';
import 'package:cusipco/screens/main_screen/home/BloodSugarTest/blood_sugar_test_category_screen.dart';
import 'package:cusipco/screens/main_screen/home/CovidTest/covid_test_category_screen.dart';
import 'package:cusipco/screens/main_screen/home/Dental_care/dental_care_category_scree.dart';
import 'package:cusipco/screens/main_screen/home/Diet/diet_grid_screen.dart';
import 'package:cusipco/screens/main_screen/home/Doctor/doctors_category_screen.dart';
import 'package:cusipco/screens/main_screen/home/Vaccination/vaccination_category_screen.dart';
import 'package:cusipco/screens/main_screen/home/WomenHealth/women_health_category_screen.dart';
import 'package:cusipco/screens/main_screen/home/emergency_services/emergency_services_screen.dart';
import 'package:cusipco/screens/main_screen/home/store/store_grid_screen.dart';
import 'package:cusipco/screens/main_screen/support/support_screen.dart';
import 'package:cusipco/screens/main_screen/view_all_category/view_all_screen.dart';
import 'package:cusipco/themedata.dart';
import 'package:cusipco/widgets/app_bars/appbar_for_home.dart';
import 'package:cusipco/widgets/button_widget/rounded_button_widget.dart';
import 'package:cusipco/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../model/user_model.dart';
import '../../../service/prowider/order_history_provider.dart';
import '../../../service/shared_pref_service/user_pref_service.dart';
import 'EyeCare/eye_care_category_scree.dart';
import 'HealthCheck/checkup_category_screen.dart';
import 'global_product_list_screen.dart';

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
      "id": 0,
      "image": "assets/images/dashboard/nutrition_icon.png",
      "text": "Diet Consultation"
    },
    {
      "id": 1,
      "image": "assets/images/dashboard/page_icon.png",
      "text": "Health Checkup"
    },
    {
      "id": 2,
      "image": "assets/images/dashboard/girl_icon.png",
      "text": "Women's Health (OBG)"
    },
    {
      "id": 3,
      "image": "assets/images/dashboard/corona_icon.png",
      "text": "Covid Test"
    },
    {
      "id": 4,
      "image": "assets/images/dashboard/tablet_icon.png",
      "text": "Pregnancy Test"
    },
    {
      "id": 5,
      "image": "assets/images/dashboard/thermometer_icon.png",
      "text": "Blood Sugar Test"
    },
  ];

  List allHelthBenifit = [

    {
      "id": 6,
      "image": "assets/images/dashboard/heart1_icon.png",
      "text": "Health Checkup"
    },
    {
      "id": 7,
      "image": "assets/images/dashboard/hospital_icon.png",
      "text": "Order Pharmacy"
    },
    {
      "id": 8,
      "image": "assets/images/dashboard/doctor_icon.png",
      "text": "Doctor Consultation"
    },
    {
      "id": 9,
      "image": "assets/images/dashboard/covid_icon.png",
      "text": "Covid Care Plan"
    },
    {
      "id": 10,
      "image": "assets/images/dashboard/injection_icon.png",
      "text": "Vaccinations"
    },
    {
      "id": 11,
      "image": "assets/images/dashboard/teeth_icon.png",
      "text": "Dental Care"
    },
    {
      "id": 12,
      "image": "assets/images/dashboard/eye_icon.png",
      "text": "Eye Care"
    },
    {
      "id": 0,
      "image": "assets/images/dashboard/nutrition_icon.png",
      "text": "Diet Consultation"
    },
  ];

  List helthBenifit = [
    {
      "id": 6,
      "image": "assets/images/dashboard/heart1_icon.png",
      "text": "Health Checkup"
    },
    {
      "id": 7,
      "image": "assets/images/dashboard/hospital_icon.png",
      "text": "Order Pharmacy"
    },
    {
      "id": 8,
      "image": "assets/images/dashboard/doctor_icon.png",
      "text": "Doctor Consultation"
    },
    {
      "id": 9,
      "image": "assets/images/dashboard/covid_icon.png",
      "text": "Covid Care Plan"
    },
    {
      "id": 10,
      "image": "assets/images/dashboard/injection_icon.png",
      "text": "Vaccinations"
    },
    {
      "id": 11,
      "image": "assets/images/dashboard/teeth_icon.png",
      "text": "Dental Care"
    },
    {
      "id": 12,
      "image": "assets/images/dashboard/eye_icon.png",
      "text": "Eye Care"
    },
    {
      "id": 13,
      "image": "assets/images/dashboard/manu1_icon.png",
      "text": "More"
    },
  ];

  List emergencyServices = [
    {
      "id": 33,
      "image": "assets/images/dashboard/blood_requirement.png",
      "text": "Blood Requirement"
    },
    {
      "id": 44,
      "image": "assets/images/dashboard/ambulance.png",
      "text": "Ambulance Services"
    },
    {
      "id": 55,
      "image": "assets/images/dashboard/connect_with_support_team.png",
      "text": "Connect with \nsupport \nteam"
    },
    {
      "id": 66,
      "image": "assets/images/dashboard/blood_donation.png",
      "text": "Blood \nDonation"
    },

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
              child: Consumer<UserPrefService>(
                  builder: (context, navProwider, child) {
                return AppbarForHomeWidget(
                    headerText:
                        navProwider.globleUserModel!.data!.name ?? "User");
              })),
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
                    Container(
                      color: ThemeClass.whiteColorgrey,
                      height: 20,),
                    _buildTitle("Emergency Services", true),
                    _buildGridList(emergencyServices),

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

  goto(Widget _screen) {
    pushNewScreen(
      context,
      screen: _screen,
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  _buildGridListTile(item) {
    return InkWell(
      onTap: () {
        //For Corporate Benefits
        if (item["id"] == 0) {
          goto(DietGridScreen());
          print("Diet Consultation");
        } else if (item["id"] == 1) {
          goto(productListScreen(
            categoryId: "38",
            routeName: "LabTest",
          ));
          print("Health Checkup");
        } else if (item["id"] == 2) {
          goto(productListScreen(
            categoryId: "39",
            routeName: "LabTest",
          ));
          print("Women's Health");
        } else if (item["id"] == 3) {
          goto(productListScreen(
            categoryId: "40",
            routeName: "LabTest",
          ));
          print("Covid Test");
        } else if (item["id"] == 4) {
          goto(productListScreen(
            categoryId: "41",
            routeName: "LabTest",
          ));
          print("Pregnancy Test");
        } else if (item["id"] == 5) {
          goto(productListScreen(
            categoryId: "42",
            routeName: "LabTest",
          ));
          print("Blood Sugar Test");
        }

        //For Health Benefits
        if (item["id"] == 6) {
          goto(CheckupCategoryScreen());
          print("Health Checkup");
        } else if (item["id"] == 7) {
          goto(StoreGridScreen());
          print("Order Pharmacy");
        } else if (item["id"] == 8) {
          goto(DoctorsCategoryScreen());
          print("Doctor Consultation");
        } else if (item["id"] == 9) {
          goto(productListScreen(
            categoryId: "40",
            routeName: "LabTest",
          ));
          print("Covid Care Plan");
        } else if (item["id"] == 10) {
          goto(VaccinationCategoryScreen());
          print("Vaccinations");
        } else if (item["id"] == 11) {
          goto(DentalCareCategoryScreen());
          print("Dental Care");
        } else if (item["id"] == 12) {
          goto(EyeCareCategoryScreen());
          print("Eye Care");
        } else if (item["id"] == 13) {
          goto(ViewAllCategoriesScreen(categoriesList: allHelthBenifit));
        }

        //for emergency services
        if (item["id"] == 33) {
          goto(EmergencyServicesScreen());
          print("Blood Requirement");
        } else if (item["id"] == 44) {
          goto(EmergencyServicesScreen());
          print("Ambulance Services");
        } else if (item["id"] == 55) {
          goto(SupportScreen());
          print("Connect with support team");
        } else if (item["id"] == 66) {
          goto(EmergencyServicesScreen());
          print("Blood Donation");
        }
      },
      child: Column(
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
      ),
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
                    callBack: () {
                      goto(DoctorsCategoryScreen());
                    }),
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
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllCategoriesScreen(categoriesList: emergencyServices)));
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              color: ThemeClass.blueColor22,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
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
