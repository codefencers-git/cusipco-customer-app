import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../themedata.dart';
import '../../../widgets/app_bars/appbar_with_text.dart';
import '../../../widgets/button_widget/rounded_button_widget.dart';
import '../home/Dental_care/dental_care_category_scree.dart';
import '../home/Diet/diet_grid_screen.dart';
import '../home/Doctor/doctors_category_screen.dart';
import '../home/HealthCheck/checkup_category_screen.dart';
import '../home/Vaccination/vaccination_category_screen.dart';
import '../home/global_product_list_screen.dart';
import '../home/store/store_grid_screen.dart';

class ViewAllCategoriesScreen extends StatefulWidget {
  final List categoriesList;
  const ViewAllCategoriesScreen({Key? key,   required this.categoriesList}) : super(key: key);

  @override
  State<ViewAllCategoriesScreen> createState() => _ViewAllCategoriesScreenState();
}

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
            title: "Health Benefits",
            isShowCart: true,
          )),
      body:
    Container(
        color: ThemeClass.whiteColor,
        width: width,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle("Health Benefits", true),
              _buildGridList(widget.categoriesList),
              SizedBox(
                height: 10,
              ),

            ],
          ),
        )),);
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
          print("Covid Care Plan");
        } else if (item["id"] == 10) {
          goto(VaccinationCategoryScreen());
          print("Vaccinations");
        } else if (item["id"] == 11) {
          goto(DentalCareCategoryScreen());
          print("Dental Care");
        } else if (item["id"] == 12) {
          print("Eye Care");
        } else if (item["id"] == 13) {
          print("More");
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
