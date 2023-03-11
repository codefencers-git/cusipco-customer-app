import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:cusipco/Global/global_variable_for_show_messge.dart';
import 'package:cusipco/model/order_history_model.dart';
import 'package:cusipco/service/http_service/http_service.dart';
import 'package:cusipco/service/navigation_service.dart';
import 'package:cusipco/service/shared_pref_service/user_pref_service.dart';
import 'package:cusipco/widgets/general_widget.dart';

class OrderHistoryServices with ChangeNotifier {
  OrderHistoryModel? orderHistoryModel;

  bool isError = false;
  String errorMessage = "";
  bool loading = false;
  Future<void> getOrderHistoryData() async {
    try {
      var url = "purchase-history";
      loading = true;
      var response = await HttpService.httpGet(url);
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (body['success'].toString() == "1" &&
            body['status'].toString() == "200") {
          isError = false;
          errorMessage = "";
          orderHistoryModel = OrderHistoryModel.fromJson(body);
          loading = false;
        } else {
          isError = true;
          errorMessage = body['message'].toString();
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
      debugPrint("------order history catch ---- ${e.toString()}");
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
