import 'dart:convert';

import 'package:cusipco/model/service_book_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:cusipco/Global/global_variable_for_show_messge.dart';
import 'package:cusipco/model/book_appo_model.dart';

import 'package:cusipco/service/http_service/http_service.dart';

Future<BookServiceFormModel?> bookFormService(
    String name,
    String route_name,
    String mobile_number,
    String address,
    String for_service,
    String age,
    String gender,
    String dose,
    BuildContext context) async {
  try {
    var url = route_name;

    Map<dynamic, dynamic> data;

    data = {
      'name': name,
      'mobile_number': mobile_number,
      'address': address,
      'for': for_service,
      'age': age,
      'gender' : gender,
      'dose' : dose
    };

    print("URL IS HERE $url");
    var response = await HttpService.httpPost(url, data, context: context);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == "200" && data['success'] == "1") {
        return BookServiceFormModel.fromJson(data);
      } else {
        throw data['message'].toString();
      }
    } else if (response.statusCode == 500) {
      throw GlobalVariableForShowMessage.internalservererror;
    } else {
      throw GlobalVariableForShowMessage.somethingwentwongMessage;
    }
  } catch (e) {
    rethrow;
    // debugPrint(e.toString());
  }
}

