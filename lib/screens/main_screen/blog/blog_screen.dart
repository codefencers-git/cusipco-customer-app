import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cusipco/screens/main_screen/blog/blog_listing_model.dart';
import 'package:cusipco/screens/main_screen/common_screens/common_service.dart';
import 'package:cusipco/screens/main_screen/home/global_product_list_screen.dart';
import 'package:cusipco/service/prowider/vaccination_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:cusipco/screens/main_screen/home/Doctor/doctor_list_screen.dart';
import 'package:cusipco/service/animation_service.dart';
import 'package:cusipco/service/prowider/doctor_category_provider.dart';
import 'package:cusipco/widgets/app_bars/appbar_with_text.dart';
import 'package:cusipco/widgets/online_offline_bottom_sheet.dart';

import 'package:cusipco/widgets/slider_widget.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../service/prowider/checkup_category_provider.dart';
import '../../../../themedata.dart';
import 'blog_prowider_service.dart';

class BlogScreen extends StatefulWidget {
  final Data blogItem;
  const BlogScreen({Key? key, required this.blogItem}) : super(key: key);

  @override
  State<BlogScreen> createState() =>
      _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CommonServiceProwider>(context);
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
                  title: "",
                  isShowCart: false,
                )),
            body: Container(
              color: ThemeClass.whiteColor,
              height: height,
              width: width,
              child: Column(
                children: [
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
                      child: Text(model.errorMessage)
                    ),
                  )
                      : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(height: 10,),
                          _buildBlogListtile(widget.blogItem),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
  Container _buildBlogListtile(Data blogItem) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            height: 150,
            imageUrl:
            blogItem.image.toString(),
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
                  blogItem.date.toString(),
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
                  blogItem.author.toString(),
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
            blogItem.title.toString(),
            style: TextStyle(
              color: ThemeClass.blackColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          HtmlWidget(
            blogItem.description.toString(),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
