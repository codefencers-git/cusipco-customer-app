import 'package:auto_animated/auto_animated.dart';
import 'package:cusipco/model/service_book_model.dart';
import 'package:cusipco/service/book_form_service.dart';
import 'package:cusipco/widgets/drop_down_custom.dart';
import 'package:flutter/material.dart';
import 'package:cusipco/screens/main_screen/home/Doctor/doctor_list_screen.dart';
import 'package:cusipco/service/animation_service.dart';
import 'package:cusipco/service/prowider/doctor_category_provider.dart';
import 'package:cusipco/widgets/app_bars/appbar_with_text.dart';
import 'package:cusipco/widgets/online_offline_bottom_sheet.dart';

import 'package:cusipco/widgets/slider_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../Global/global_variable_for_show_messge.dart';
import '../../../../notification_backGround/notification_service.dart';
import '../../../../service/prowider/checkup_category_provider.dart';
import '../../../../themedata.dart';
import '../../../../widgets/button_widget/rounded_button_widget.dart';
import '../../../../widgets/text_boxes/text_area.dart';
import '../../../../widgets/text_boxes/text_box_normal.dart';

class CovidVaccinationForm extends StatefulWidget {
  final String  route;
  final String for_service;

  const CovidVaccinationForm(
      {Key? key, required this.route, required this.for_service})
      : super(key: key);

  @override
  State<CovidVaccinationForm> createState() => _CovidVaccinationFormState();
}

class _CovidVaccinationFormState extends State<CovidVaccinationForm> {
  @override
  void initState() {
    // Provider.of<CheckupCategoryService>(context, listen: false)
    //     .getCheckupCategories(context: context);
    super.initState();
  }

  var type_of_vac = ['1st Dose', '2nd Dose', 'Booster Dose'];
  String? gender;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                  title: "Book Service",
                  isShowCart: true,
                )),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  color: ThemeClass.whiteColorgrey,
                  height: height,
                  width: width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Book Now",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ThemeClass.blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      Container(
                        width: width - 50,
                        child: Text(
                          "Fill the details to book ${widget.for_service} service!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeClass.greyColor,
                            fontSize: 15,
                          ),
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
                            return GlobalVariableForShowMessage.EmptyErrorMessage +
                                "Name";
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextBoxSimpleWidget(
                        radius: 10,
                        hinttext: "Mobile Number",
                        controllers: _mobileController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return GlobalVariableForShowMessage.EmptyErrorMessage +
                                "Mobile Number";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextBoxSimpleWidget(
                        isNumber: true,
                        radius: 10,
                        hinttext: "Age",
                        controllers: _ageController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return GlobalVariableForShowMessage.EmptyErrorMessage +
                                "Mobile Number";
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DropDownCustom(
                        onChanged: (val){
                          setState(() {
                            _doseController.text = val.toString();
                          });
                          print("dosess"+_doseController.text.toString());
                        },
                        radius: 10,
                        items: type_of_vac.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        hinttext: 'Type Of Vaccination',
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextAreaBox(
                        radius: 10,
                        hinttext: "Current Address",
                        controllers: _addressController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return GlobalVariableForShowMessage.EmptyErrorMessage +
                                "Current Address";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _buildGenderBox(),
                      SizedBox(
                        height: 40,
                      ),
                      ButtonWidget(
                          title: "Submit",
                          color: ThemeClass.blueColor,
                          isLoading: false,
                          callBack: () {
                              _confirm(
                                  _nameController.text.toString(),
                                  _addressController.text.toString(),
                                  _mobileController.text.toString(),
                                  widget.for_service.toString(),
                                  _ageController.text.toString(),
                                  gender.toString(),
                                  _doseController.text.toString());

                          }),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }


  _buildGenderBox(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildtitle("Select Gender"),
        Row(
          children: [
            RadioMenuButton(value: "Male", groupValue: gender, onChanged: (item){
              setState(() {
                gender = "Male";
              });
            }, child: Text("Male")),
            RadioMenuButton(value: "Female", groupValue: gender, onChanged: (item){
              setState(() {
                gender = "Female";
              });
            }, child: Text("Female")),
          ],
        ),
      ],
    );
  }


  Padding _buildtitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 0),
      child: Text(
        title,
        style: TextStyle(
          color: ThemeClass.blackColor,
          fontSize: 14,
        ),
      ),
    );
  }

  _confirm(name, address, mobile_number, for_service, age,gender, dose) async {
    EasyLoading.show();

    print("ALL Data");
    print(name);
    print(mobile_number);
    print(age);
    print(dose);
    print(gender);
    print(address);
    print(for_service);

    try {
      BookServiceFormModel? bookServiceFormModel = await bookCovidFormService(
          name, widget.route, mobile_number, address, for_service,age,gender, dose ,  context);
      if (bookServiceFormModel!.status == "200") {
        EasyLoading.dismiss();
        showToast(bookServiceFormModel.message.toString());
      } else {
        showToast(bookServiceFormModel.message.toString());
      }
    } catch (e) {
      showToast(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
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
