import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cusipco/screens/main_screen/common_screens/grid_item.dart';
import 'package:cusipco/screens/main_screen/home/Doctor/doctors_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:cusipco/Global/global_variable_for_show_messge.dart';
import 'package:cusipco/model/category_model.dart';
import 'package:cusipco/screens/main_screen/home/store/store_product_list_screen.dart';
import 'package:cusipco/service/http_service/http_service.dart';
import 'package:cusipco/service/navigation_service.dart';
import 'package:cusipco/service/shared_pref_service/user_pref_service.dart';
import 'package:cusipco/themedata.dart';
import 'package:cusipco/widgets/app_bars/appbar_with_text.dart';
import 'package:cusipco/widgets/general_widget.dart';
import 'package:cusipco/widgets/grid_list_tile_widget.dart';
import 'package:cusipco/widgets/slider_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CommonGridScreen extends StatefulWidget {
  final String title;
  final List itemList;
  final SliderWidget? slider;
  final Null Function(Map<String, Object> data, BuildContext context)? onClickModule;
  CommonGridScreen({Key? key, required this.title, required this.itemList, this.onClickModule, this.slider}) : super(key: key);

  @override
  State<CommonGridScreen> createState() => _StoreGridScreenState();
}

class _StoreGridScreenState extends State<CommonGridScreen> {
  CarouselController buttonCarouselController = CarouselController();
  var _futureCall;
  @override
  void initState() {
    super.initState();
    _futureCall = getCategoryData();
  }

  Future<List<CategoryData>?> getCategoryData() async {
    try {
      Map<String, String> queryParameters = {
        "module": "Store",
      };

      var response = await HttpService.httpPost("categories", queryParameters,
          context: context);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = json.decode(response.body);
        CategoryModel data = CategoryModel.fromJson(body);

        if (data != null && data.status == "200") {
          return data.data;
        } else {
          throw GlobalVariableForShowMessage.internalservererror;
        }
      } else if (response.statusCode == 401) {
        showToast(GlobalVariableForShowMessage.unauthorizedUser);
        await UserPrefService().removeUserData();
        NavigationService().navigatWhenUnautorized();
      } else {
        throw GlobalVariableForShowMessage.internalservererror;
      }
    } catch (e) {
      if (e is SocketException) {
        throw GlobalVariableForShowMessage.socketExceptionMessage;
      } else if (e is TimeoutException) {
        throw GlobalVariableForShowMessage.timeoutExceptionMessage;
        ;
      } else {
        throw e.toString();
      }
    }
    return null;
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
                title: widget.title,
                isShowCart: true,
              )),
          body: Container(
              color: ThemeClass.whiteColor,
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   widget.slider != null ? SliderWidget(
                      type: "store",
                    ) : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildGrid(width, context, widget.itemList),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Container _buildDataNotFound1(
      String text,
      ) {
    return Container(
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 3,
              bottom: MediaQuery.of(context).size.width / 3),
          child: Center(child: Text(text)),
        ));
  }

  Padding _buildGrid(
      double width, BuildContext context, List data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio:
              (width - 60) / (MediaQuery.of(context).size.height / 1.8),
              crossAxisSpacing: 0,
              mainAxisSpacing: 0),
          itemCount: data.length,
          itemBuilder: (BuildContext ctx, index) {
            return GridItem(
                data: data[index],
                callback: () {
                  widget.onClickModule!(data[index], context);
                  // pushNewScreen(
                  //   context,
                  //   screen: data[index]["id"] == 1 || data[index]["id"] == 2 || data[index]["id"] == 3 ? EmergencyServicesScreen() : data[index]["id"] == 4 ? DoctorsCategoryScreen() : DoctorsCategoryScreen(),
                  //   withNavBar: true,
                  //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  // );
                });
            // _buildCardItem(data[index]);
          }),
    );
  }

  InkWell _buildCardItem(CategoryData data) {
    return InkWell(
      onTap: () {
        pushNewScreen(
          context,
          screen: StoreproductListScreen(
            categoryId: data.id.toString(),
            routeName: "products",
          ),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Column(
        children: [
          Container(
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
              ),
              child: Image.network(
                data.image.toString(),
              ),
            ),
          ),
          Center(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: Text(
                  data.title.toString(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
