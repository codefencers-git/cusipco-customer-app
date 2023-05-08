import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:cusipco/model/common_model.dart';
import 'package:cusipco/model/get_address_model.dart';

import 'package:cusipco/service/http_service/http_service.dart';

import '../../model/agora_token_model.dart';

class VideoService with ChangeNotifier {

  AgoraTokenModel? agoraTokenModel;

  Future<AgoraTokenModel?> takeACall(
      String callToId, String type,
      {required BuildContext context}) async {
    try {
      var url = "api/take-a-call";
      // UserModel? model = await UserPrefService().getUserData();
      // String phone = model.data!.phoneNumber.toString();

      Map<dynamic, dynamic> data = {
        'call_to': callToId,
        'type': type,
      };

      var response = await HttpService.httpPostForCallToken(url, data, context: context);

      if (response.statusCode == 200) {
        return AgoraTokenModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
