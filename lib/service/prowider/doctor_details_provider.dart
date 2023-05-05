import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:cusipco/Global/global_variable_for_show_messge.dart';
import 'package:cusipco/model/doctors_detail_model.dart';

import 'package:cusipco/service/http_service/http_service.dart';

import '../../model/agora_token_model.dart';

class DoctorsDetailsServices with ChangeNotifier {
  DoctorDetailsModel? doctorDetailsModel;

  bool loading = false, buttonLoading = false;
  String errorMessage = "";
  bool isError = false;

  Future<void> getDoctorDetails(
    String id,
  ) async {
    try {
      var url = "doctor/$id";
      loading = true;

      var response = await HttpService.httpGet(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = json.decode(response.body);
        if (body['success'].toString() == "1" &&
            body['status'].toString() == "200") {
          doctorDetailsModel =
              DoctorDetailsModel.fromJson(jsonDecode(response.body));

          isError = false;
          errorMessage = "";
        } else {
          isError = true;
          errorMessage = body['message'].toString();
        }
      } else {
        isError = true;
        errorMessage = GlobalVariableForShowMessage.internalservererror;
      }
    } catch (e) {
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

  Future<AgoraTokenModel?> getAgoraToken(String callToId, String type,
      {required BuildContext context}) async {
    try {
      buttonLoading = true;
      notifyListeners();
      var url = "api/take-a-call";
      // UserModel? model = await UserPrefService().getUserData();
      // String phone = model.data!.phoneNumber.toString();

      Map<dynamic, dynamic> data = {
        'call_to': callToId,
        'type': type,
      };

      var response =
      await HttpService.httpPostForCallToken(url, data, context: context);

      if (response.statusCode == 200) {
        AgoraTokenModel agoraTokenModel =
        AgoraTokenModel.fromJson(jsonDecode(response.body));
        print("AGORA TOKEN : ${agoraTokenModel.data.call_token}");
        print("AGORA ROOM : ${agoraTokenModel.data.call_room}");
        return agoraTokenModel;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      buttonLoading = false;
      notifyListeners();
    }
  }
}
