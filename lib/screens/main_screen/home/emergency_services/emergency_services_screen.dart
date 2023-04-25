import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:cusipco/screens/main_screen/home/Doctor/doctor_list_screen.dart';
import 'package:cusipco/service/animation_service.dart';
import 'package:cusipco/service/prowider/doctor_category_provider.dart';
import 'package:cusipco/widgets/app_bars/appbar_with_text.dart';
import 'package:cusipco/widgets/online_offline_bottom_sheet.dart';

import 'package:cusipco/widgets/slider_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../Global/global_variable_for_show_messge.dart';
import '../../../../service/prowider/checkup_category_provider.dart';
import '../../../../themedata.dart';
import '../../../../widgets/button_widget/rounded_button_widget.dart';
import '../../../../widgets/text_boxes/text_box_normal.dart';

class EmergencyServicesScreen extends StatefulWidget {
  const EmergencyServicesScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyServicesScreen> createState() => _EmergencyServicesScreenState();
}

class _EmergencyServicesScreenState extends State<EmergencyServicesScreen> {
  @override
  void initState() {
    Provider.of<CheckupCategoryService>(context, listen: false)
        .getCheckupCategories(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _mobileController = TextEditingController();
    final TextEditingController _dateController = TextEditingController();

    final model = Provider.of<CheckupCategoryService>(context);
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
                  title: "Book Service",
                  isShowCart: true,
                )),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              color: ThemeClass.whiteColorgrey,
              height: height,
              width: width,
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Text(
                    "Book Now",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ThemeClass.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "Fill the details to book service!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeClass.greyColor,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextBoxSimpleWidget(
                    radius: 10,
                    hinttext: "Name",
                    controllers: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return GlobalVariableForShowMessage
                            .EmptyErrorMessage +
                            "Name";
                      }
                    },
                  ),SizedBox(
                    height: 15,
                  ),
                  TextBoxSimpleWidget(
                    radius: 10,
                    hinttext: "Mobile Number",
                    controllers: _mobileController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return GlobalVariableForShowMessage
                            .EmptyErrorMessage +
                            "Mobile Number";
                      }
                    },
                  ),SizedBox(
                    height: 15,
                  ),
                  TextBoxSimpleWidget(
                    radius: 10,
                    hinttext: "Select Date",
                    controllers: _dateController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return GlobalVariableForShowMessage
                            .EmptyErrorMessage +
                            "Select Date";
                      }
                    },
                  ),SizedBox(height: 40,),
                  ButtonWidget(
                      title :"Submit",
                      color: ThemeClass.blueColor,
                      isLoading: false,
                      callBack: () {
                       Navigator.of(context).pop();
                       Fluttertoast.showToast(msg: "Service booked!");
                      }),
                ],
              ),
            ),
          )),
    );
  }
  Padding _buildtitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 2),
      child: Text(
        title,
        style: TextStyle(
            color: ThemeClass.blueColor,
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  _checkNavigation(data) async {
    var res = await showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return BottomSheetForOnlineOffLineDoctore();
        });
    // pushNewScreen(context,
    //     screen: DoctorListScreen(
    //       mode: "",
    //       categoryId: data.id.toString(),
    //     ),
    //     withNavBar: true);

    print(res);
    if (res != null) {
      pushNewScreen(context,
          screen: DoctorListScreen(
            mode: res,
            categoryId: data.id.toString(),
          ),
          withNavBar: true);
      print(res);
    }
  }
}
