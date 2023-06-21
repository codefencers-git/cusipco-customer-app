import 'package:cusipco/screens/main_screen/common_screens/forms/book_service_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../themedata.dart';
import '../../../widgets/app_bars/appbar_with_text.dart';
import '../../../widgets/button_widget/rounded_button_widget.dart';
import '../../../widgets/slider_widget.dart';
import '../common_screens/common_categories_screen.dart';
import '../common_screens/common_grid_screen.dart';
import '../common_screens/single_category_detail_screen.dart';
import '../home/Dental_care/dental_care_category_scree.dart';
import '../home/Diet/diet_grid_screen.dart';
import '../home/Doctor/doctors_category_screen.dart';
import '../home/EyeCare/eye_care_category_scree.dart';
import '../home/HealthCheck/checkup_category_screen.dart';
import '../home/Vaccination/vaccination_category_screen.dart';
import '../home/global_product_list_screen.dart';
import '../home/store/store_grid_screen.dart';
import '../support/support_screen.dart';

class ViewAllCategoriesScreen extends StatefulWidget {
  final List categoriesList;
  final String? title;

  const ViewAllCategoriesScreen(
      {Key? key, required this.categoriesList, this.title})
      : super(key: key);

  @override
  State<ViewAllCategoriesScreen> createState() =>
      _ViewAllCategoriesScreenState();
}

List vaccineModes = [
  {
    "id": 1,
    "image": "assets/images/dashboard/by_agegroup.jpg",
    "text": "Vaccine By Age",
  },
  {
    "id": 2,
    "image": "assets/images/dashboard/disease_vaccination.jpg",
    "text": "Vaccine By Disease"
  }
];

List covidCarePlan = [
  {
    "id": 1,
    "image": "assets/images/dashboard/rapid_antigen_test.jpg",
    "text": "Rapid Antigen Test",
    "for": "Rapid-Antigen-Test"
  },
  {
    "id": 2,
    "image": "assets/images/dashboard/antibody_test.jpg",
    "text": "Rapid Antibody Test",
    "for": "Rapid-Antibody-Test"
  },
  {
    "id": 3,
    "image": "assets/images/dashboard/rtpcr_test.jpg",
    "text": "RTPCR Test",
    "for": "RTPCR-Test"
  },
  {
    "id": 4,
    "image": "assets/images/dashboard/covid_vaccination.jpg",
    "text": "COVID Vaccination",
    "for": ""
  },
  {
    "id": 5,
    "image": "assets/images/dashboard/doctor_consultation.jpg",
    "text": "Doctor Consultation",
    "for": "RTPCR-Test"
  },
];

class _ViewAllCategoriesScreenState extends State<ViewAllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBarWithTextAndBackWidget(
            onbackPress: () {
              Navigator.pop(context);
            },
            title: widget.title ?? "Categories",
            isShowCart: true,
          )),
      body: Container(
          color: ThemeClass.whiteColor,
          width: width,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(widget.title ?? "Categories", true),
                _buildGridList(widget.categoriesList),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
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
            ],
          ),
          Divider()
        ],
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
        //For Health Benefits
        if (item["id"] == 0) {
          goto(DietGridScreen());
          print("Health Checkup");
        } else if (item["id"] == 6) {
          goto(CheckupCategoryScreen());
          print("Health Checkup");
        } else if (item["id"] == 7) {
          goto(StoreGridScreen());
          print("Order Pharmacy");
        } else if (item["id"] == 8) {
          goto(DoctorsCategoryScreen());
          print("Doctor Consultation");
        } else if (item["id"] == 9) {
          goto(CommonGridScreen(
            title: "Covid Care Plan",
            itemList: covidCarePlan,
            onClickModule: (Map<String, Object> data, context) {
              print("IDIDIDIDI" + data["id"].toString());
              pushNewScreen(
                context,
                screen: data["id"] == 1 || data["id"] == 2 || data["id"] == 3
                    ? BookServiceFormScreen(
                        route: "submit-covid-form",
                        for_service: data["for"].toString())
                    : data["id"] == 4
                        ? SingleCategoryScreen(
                            categoryId: '20',
                            mode: '',
                          )
                        : DoctorsCategoryScreen(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ));
          print("Covid Care Plan");
        } else if (item["id"] == 10) {
          goto(CommonGridScreen(
              slider: SliderWidget(
                type: "store",
              ),
              title: "Vaccinations",
              itemList: vaccineModes,
              onClickModule: (data, context) {
                if (data["id"] == 1) {
                  goto(CommonCategoriesScreen(
                    module: "AgeGroup",
                    route: 'Vaccine',
                    title: 'Vaccination By AgeGroup',
                  ));
                } else if (data["id"] == 2) {
                  goto(CommonCategoriesScreen(
                    module: "Vaccine",
                    route: 'Vaccine',
                    title: 'Vaccination By Disease',
                  ));
                }
              }));
          print("Vaccinations");
        } else if (item["id"] == 11) {
          goto(DentalCareCategoryScreen());
          print("Dental Care");
        } else if (item["id"] == 12) {
          goto(EyeCareCategoryScreen());
          print("Eye Care");
        } else if (item["id"] == 13) {
          print("More");
        }

        // //for emergency services
        // if (item["id"] == 33) {
        //   goto(BookServiceFormScreen(
        //       route: "submit-emergency-form",
        //       for_service: "Blood-Requirement"));
        //   print("Blood Requirement");
        // } else if (item["id"] == 44) {
        //   goto(BookServiceFormScreen(
        //       route: "submit-emergency-form",
        //       for_service: "Blood-Requirement"));
        //   print("Ambulance Services");
        // } else if (item["id"] == 55) {
        //   goto(SupportScreen());
        //   print("Connect with support team");
        // } else if (item["id"] == 66) {
        //   goto(BookServiceFormScreen(
        //       route: "submit-emergency-form",
        //       for_service: "Blood-Requirement"));
        //   print("Blood Donation");
        // }

        //for emergency services
        if (item["id"] == 33) {
          goto(BookServiceFormScreen(route: "submit-emergency-form", for_service: "Blood-Requirement"));
          print("Blood Requirement");
        } else if (item["id"] == 44) {
          goto(BookServiceFormScreen(route: "submit-emergency-form", for_service: "Ambulance"));
          print("Ambulance Services");
        } else if (item["id"] == 55) {
          goto(SupportScreen());
          print("Connect with support team");
        } else if (item["id"] == 66) {
          goto(BookServiceFormScreen(route: "submit-emergency-form", for_service: "Blood-Donation"));
          print("Blood Donation");
        } else if (item["id"] == 77) {
          goto(BookServiceFormScreen(route: "submit-emergency-form", for_service: "ECG"));
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
}
