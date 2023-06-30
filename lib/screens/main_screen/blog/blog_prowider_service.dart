import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cusipco/screens/main_screen/blog/blog_listing_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../Global/global_variable_for_show_messge.dart';
import '../../../notification_backGround/notification_service.dart';
import '../../../service/http_service/http_service.dart';
import '../../../service/navigation_service.dart';
import '../../../service/shared_pref_service/user_pref_service.dart';

class BlogProviderService with ChangeNotifier {
  BlogListingModel? blogListingData;
  BlogListingModel? allBlogListingData;

  bool isError = false;
  String errorMessage = "";
  bool loading = true;

  bool isLoadBlogDetails = false;
  bool isLoadStoreBlogDetails = false;

  Future getBlog(BuildContext context, dynamic params) async {
    try {
      var response = await HttpService.httpPostWithoutHeaders("blog", params, context: context );

      loading = true;
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = json.decode(response.body);

        if (body['success'].toString() == "1" &&
            body['status'].toString() == "200") {
          BlogListingModel data = BlogListingModel.fromJson(body);

          isError = false;
          errorMessage = "";
          blogListingData = data;
          isLoadBlogDetails = true;
          isLoadStoreBlogDetails = true;
          Future.delayed(Duration(seconds: 1), () {
            isLoadBlogDetails = false;
            isLoadStoreBlogDetails = false;
          });
          notifyListeners();
          return;
        } else {
          print("---------- issue in get blog -----------");
          blogListingData = null;
          print("blog issue--------------------------");
          isLoadBlogDetails = true;
          isLoadStoreBlogDetails = true;
          Future.delayed(Duration(seconds: 1), () {
            isLoadBlogDetails = false;
            isLoadStoreBlogDetails = false;
          });
          notifyListeners();
          isError = true;
          errorMessage = body['message'].toString();

          return;
        }
      } else if (response.statusCode == 401) {
        showToast(GlobalVariableForShowMessage.unauthorizedUser);
        await UserPrefService().removeUserData();
        NavigationService().navigatWhenUnautorized();
      } else {
        isError = true;
        errorMessage = GlobalVariableForShowMessage.somethingwentwongMessage;
      }
    } catch (e) {
      debugPrint("--- getCart --- ${e.toString()}");

      isError = true;
      if (e is SocketException) {
        errorMessage = GlobalVariableForShowMessage.socketExceptionMessage;
      } else if (e is TimeoutException) {
        errorMessage = GlobalVariableForShowMessage.timeoutExceptionMessage;
      } else {
        errorMessage = e.toString();
      }
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future getAllBlog(BuildContext context, dynamic params) async {
    try {
      var response = await HttpService.httpPostWithoutHeaders("blog", params, context: context );

      loading = true;
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = json.decode(response.body);

        if (body['success'].toString() == "1" &&
            body['status'].toString() == "200") {
          BlogListingModel data = BlogListingModel.fromJson(body);

          isError = false;
          errorMessage = "";
          allBlogListingData = data;
          isLoadBlogDetails = true;
          isLoadStoreBlogDetails = true;
          Future.delayed(Duration(seconds: 1), () {
            isLoadBlogDetails = false;
            isLoadStoreBlogDetails = false;
          });
          notifyListeners();
          return;
        } else {
          print("---------- issue in get blog -----------");
          allBlogListingData = null;
          print("blog issue--------------------------");
          isLoadBlogDetails = true;
          isLoadStoreBlogDetails = true;
          Future.delayed(Duration(seconds: 1), () {
            isLoadBlogDetails = false;
            isLoadStoreBlogDetails = false;
          });
          notifyListeners();
          isError = true;
          errorMessage = body['message'].toString();

          return;
        }
      } else if (response.statusCode == 401) {
        showToast(GlobalVariableForShowMessage.unauthorizedUser);
        await UserPrefService().removeUserData();
        NavigationService().navigatWhenUnautorized();
      } else {
        isError = true;
        errorMessage = GlobalVariableForShowMessage.somethingwentwongMessage;
      }
    } catch (e) {
      debugPrint("--- getCart --- ${e.toString()}");

      isError = true;
      if (e is SocketException) {
        errorMessage = GlobalVariableForShowMessage.socketExceptionMessage;
      } else if (e is TimeoutException) {
        errorMessage = GlobalVariableForShowMessage.timeoutExceptionMessage;
      } else {
        errorMessage = e.toString();
      }
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
