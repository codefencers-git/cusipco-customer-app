import 'dart:convert';

import 'package:cusipco/service/shared_pref_service/user_pref_service.dart';
import 'package:flutter/cupertino.dart';

import '../Global/global_variable_for_show_messge.dart';
import '../notification_backGround/notification_service.dart';
import 'http_service/http_service.dart';
import 'navigation_service.dart';

class CommonApiCall {

  Future getData(api_end_point)async{

    try {

      var response = await HttpService.httpGet(
          api_end_point,
          );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = json.decode(response.body);
        if (body['success'].toString() == "1" &&
            body['status'].toString() == "200") {
          print("body::"+body.toString());
          return body;
        } else {
          throw body['message'].toString();
        }
      } else if (response.statusCode == 401) {
        showToast(GlobalVariableForShowMessage.unauthorizedUser);
        await UserPrefService().removeUserData();
        NavigationService().navigatWhenUnautorized();
      } else if (response.statusCode == 500) {
        throw GlobalVariableForShowMessage.internalservererror;
      } else {
        throw GlobalVariableForShowMessage.internalservererror;
      }
    } catch (e) {
      // if (e is SocketException) {
      //   throw GlobalVariableForShowMessage.socketExceptionMessage;
      // } else if (e is TimeoutException) {
      //   throw GlobalVariableForShowMessage.timeoutExceptionMessage;
      // } else {
      //   throw e.toString();
      // }
    }
    return null;
  }

  Future postData(api_end_point, params, context)async{
    
    print("params : "+params.toString());

    try {

      var response = await HttpService.httpPost(
        api_end_point,params,context: context
      );
      print("responseMethod ::"+response.body.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = json.decode(response.body);
        if (body['success'].toString() == "1" &&
            body['status'].toString() == "200") {
          print("body::"+body.toString());
          return body;
        } else {
          throw body['message'].toString();
        }
      } else if (response.statusCode == 401) {
        showToast(GlobalVariableForShowMessage.unauthorizedUser);
        await UserPrefService().removeUserData();
        NavigationService().navigatWhenUnautorized();
      } else if (response.statusCode == 500) {
        throw GlobalVariableForShowMessage.internalservererror;
      } else {
        throw GlobalVariableForShowMessage.internalservererror;
      }
    } catch (e) {
      // if (e is SocketException) {
      //   throw GlobalVariableForShowMessage.socketExceptionMessage;
      // } else if (e is TimeoutException) {
      //   throw GlobalVariableForShowMessage.timeoutExceptionMessage;
      // } else {
      //   throw e.toString();
      // }
    }
    return null;
  }
}