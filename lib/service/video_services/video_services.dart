import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:cusipco/model/common_model.dart';
import 'package:cusipco/model/get_address_model.dart';

import 'package:cusipco/service/http_service/http_service.dart';

class VideoService with ChangeNotifier {
  Future<CommonModel?> getAgoraToken(String name, String type,
      {required BuildContext context}) async {
    try {
      var url = "save_address";
      // UserModel? model = await UserPrefService().getUserData();
      // String phone = model.data!.phoneNumber.toString();

      Map<dynamic, dynamic> data = {
        'name': name,
        'address_type': type,
      };

      var response = await HttpService.httpPost(url, data, context: context);

      if (response.statusCode == 200) {
        return CommonModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
