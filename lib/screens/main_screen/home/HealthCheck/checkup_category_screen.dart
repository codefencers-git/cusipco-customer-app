import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:cusipco/screens/main_screen/home/Doctor/doctor_list_screen.dart';
import 'package:cusipco/service/animation_service.dart';
import 'package:cusipco/service/prowider/doctor_category_provider.dart';
import 'package:cusipco/widgets/app_bars/appbar_with_text.dart';
import 'package:cusipco/widgets/online_offline_bottom_sheet.dart';

import 'package:cusipco/widgets/slider_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../service/prowider/checkup_category_provider.dart';
import '../../../../themedata.dart';
import '../global_product_list_screen.dart';
import '../skin_and_care/global_product_detail_screen.dart';

class CheckupCategoryScreen extends StatefulWidget {
  const CheckupCategoryScreen({Key? key}) : super(key: key);

  @override
  State<CheckupCategoryScreen> createState() => _CheckupCategoryScreenState();
}

class _CheckupCategoryScreenState extends State<CheckupCategoryScreen> {
  @override
  void initState() {
    Provider.of<CheckupCategoryService>(context, listen: false)
        .getCheckupCategories(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              title: "Health Checkup Categories",
              isShowCart: true,
            )),
        body: Container(
          color: ThemeClass.whiteColor,
          height: height,
          width: width,
          child: Column(
            children: [
              // SliderWidget(
              //   type: "ConsultWithDoctor",
              // ),
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
                              itemCount: model.categoryModel.data!.length,
                              physics: BouncingScrollPhysics(),
                              options: AnimationService.animationOption,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index,
                                  Animation<double> animation) {
                                final data = model.categoryModel.data![index];

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
                                            _checkNavigation(data);
                                          },
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Image.network(
                                              data.image.toString(),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          title: Text(
                                            data.title.toString(),
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

  goto(Widget _screen) {
    pushNewScreen(
      context,
      screen: _screen,
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
  _checkNavigation(data) async {

    pushNewScreen(
      context,
      screen: GlobalProductdetails(
        id: data! .id.toString(),
        urlPerameter: "LabTest",
        title: data!.title.toString(),

        // fitnessId: _productData![index].id.toString(),
        // fitnessId: "29",
      ),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );

    // var res = await showModalBottomSheet(
    //     context: context,
    //     useRootNavigator: true,
    //     builder: (context) {
    //       return BottomSheetForOnlineOffLineDoctore();
    //     });
    // // pushNewScreen(context,
    // //     screen: DoctorListScreen(
    // //       mode: "",
    // //       categoryId: data.id.toString(),
    // //     ),
    // //     withNavBar: true);
    //
    // print(res);
    // if (res != null) {
    //   pushNewScreen(context,
    //       screen: DoctorListScreen(
    //         mode: res,
    //         categoryId: data.id.toString(),
    //       ),
    //       withNavBar: true);
    //   print(res);
    // }
  }
}
