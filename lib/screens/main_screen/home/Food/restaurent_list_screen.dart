import 'package:flutter/material.dart';
import 'package:cusipco/screens/main_screen/home/Food/resturent_list_widget.dart';
import 'package:cusipco/themedata.dart';
import 'package:cusipco/widgets/app_bars/appbar_with_location.dart';

class RestaurentListScreen extends StatefulWidget {
  RestaurentListScreen({Key? key}) : super(key: key);

  @override
  State<RestaurentListScreen> createState() => _RestaurentListScreenState();
}

class _RestaurentListScreenState extends State<RestaurentListScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBarWithLocationWidget(
            isBackShow: true,
            onbackPress: () {
              Navigator.pop(context);
            },
          )),
      body: Container(
        color: ThemeClass.whiteColor,
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: ResturentListItemWidget(),
        ),
      ),
    );
  }
}
