import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cusipco/model/new_category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:cusipco/Global/global_variable_for_show_messge.dart';
import 'package:cusipco/model/category_model.dart';

import 'package:cusipco/service/http_service/http_service.dart';

class VaccinationCategoryService with ChangeNotifier {
  late CategoryModel categoryModel;
  bool loading = false;
  String errorMessage = "";
  bool isError = false;

  Future<void> getCategories({required BuildContext context}) async {
    Map<String, String> temp = {
      'module': "Vaccine",
    };
    try {
      var url = "categories";

      loading = true;
      var response = await HttpService.httpPostWithoutToken(url, temp, context: context);
      print(response.body);
      if (response.statusCode == 200) {}

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = json.decode(response.body);
        if (body['success'].toString() == "1" &&
            body['status'].toString() == "200") {
          categoryModel = CategoryModel.fromJson(jsonDecode(response.body));
          loading = false;
          isError = false;
          errorMessage = "";
          notifyListeners();
        } else {
          isError = true;
          errorMessage = body['message'].toString();
        }
      } else {
        isError = true;
        errorMessage = GlobalVariableForShowMessage.internalservererror;
      }
    } catch (e) {
      debugPrint(e.toString());
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
