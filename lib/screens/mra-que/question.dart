import 'dart:convert';

import 'package:cusipco/model/ans_que_model.dart';
import 'package:cusipco/model/get_question_model.dart';
import 'package:cusipco/widgets/app_bars/appbar_with_text.dart';
import 'package:flutter/material.dart';

import '../../Global/global_variable_for_show_messge.dart';
import '../../notification_backGround/notification_service.dart';
import '../../service/http_service/http_service.dart';
import '../../service/navigation_service.dart';
import '../../service/shared_pref_service/user_pref_service.dart';

class question extends StatefulWidget {
  var data;
  question({required this.data});

  @override
  State<question> createState() => _questionState();
}

class _questionState extends State<question> {

  ans_que_model? ansmodel;
  var grplist = [];

  Future<ans_que_model?> _ansQue(question_id, answer_id, score)async{

    try {
      Map<String, String> queryParameters = {
        "question_id": question_id,
        "answer_id": answer_id,
        "score": score
      };

      print(queryParameters);

      var response = await HttpService.httpPost(
          "hra-question-answer", queryParameters,
          context: context);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = json.decode(response.body);
        ansmodel = ans_que_model.fromJson(body);


        if (body['success'].toString() == "1" &&
            body['status'].toString() == "200") {
          showToast('Ans Submitted SuccessFully');

          ansmodel = ans_que_model();
          return ans_que_model.fromJson(body);
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

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBarWithTextAndBackWidget(title: 'Mra-Question', onbackPress: (){
          Navigator.pop(context);
        },),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: height,
        width: width,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.data![index].title.toString(),
                        textAlign: TextAlign.justify,
                      ) ,
                      ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        // return a custom ItemCard
                        itemBuilder: (context, grindex) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  visualDensity: VisualDensity.compact,
                                  activeColor: Colors.black,
                                  fillColor: MaterialStateColor.resolveWith(
                                          (states) => Colors.black),
                                  value: grindex + 1,
                                  groupValue: grplist[index],
                                  onChanged: (indexs) {

                                    setState(() {
                                      grplist[index] = indexs;
                                    });

                                    print(widget!.data![index].id.toString());
                                    print(widget!.data![index].options![grindex].id.toString());
                                    print(widget!.data![index].options![grindex].score.toString());
                                    _ansQue( widget!.data![index].id.toString(),  widget!.data![index].options![grindex].id.toString(),  widget!.data![index].options![grindex].score.toString());
                                  },
                                ),
                                Container(
                                  width: height * 0.7,
                                  child: Text(
                                    widget!.data![index].options![grindex].title.toString(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: widget!.data![index].options!.length,
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext conqtext, int index) {
                  return SizedBox(
                    height: 0,
                  );
                },
                itemCount: widget.data.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
super.initState();
grplist = List.generate(widget.data!.length, (index) => 0);
  }
}
