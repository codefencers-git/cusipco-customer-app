import 'dart:convert';

import 'package:cusipco/model/ans_que_model.dart';
import 'package:cusipco/model/get_question_model.dart';
import 'package:cusipco/service/common_api_service.dart';
import 'package:cusipco/widgets/app_bars/appbar_with_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../Global/global_variable_for_show_messge.dart';
import '../../notification_backGround/notification_service.dart';
import '../../service/http_service/http_service.dart';
import '../../service/navigation_service.dart';
import '../../service/prowider/main_navigaton_prowider_service.dart';
import '../../service/shared_pref_service/user_pref_service.dart';
import '../../themedata.dart';
import '../../widgets/button_widget/rounded_button_widget.dart';
import '../../widgets/button_widget/small_blue_button_widget.dart';

class question extends StatefulWidget {
  var data;

  question();

  @override
  State<question> createState() => _questionState();
}

class _questionState extends State<question> {
  int hrascore = -0;
  String hrascoreText = "";
  bool isLoading = false;
  ans_que_model? ansmodel;
  var grplist = [];
  get_question_model? questionData;
  var allQuestion = get_question_model();
  bool allQuestionsAnswered = true;

  Future<ans_que_model?> _ansQue(question_id, answer_id, score) async {
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
        child: AppBarWithTextAndBackWidget(
          title: 'Mra-Question',
          onbackPress: () {
            Provider.of<MainNavigationProwider>(context, listen: false)
                .chaneIndexOfNavbar(0);
          },
        ),
      ),
      body: !isLoading
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: height,
              width: width,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    hrascore == -0
                        ? ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    questionData!.data![index].title.toString(),
                                    textAlign: TextAlign.justify,
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    // return a custom ItemCard
                                    itemBuilder: (context, grindex) {
                                      return Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              activeColor: Colors.black,
                                              fillColor: MaterialStateColor
                                                  .resolveWith(
                                                      (states) => Colors.black),
                                              value: grindex + 1,
                                              groupValue: grplist[index],
                                              onChanged: (indexs) {
                                                print("indexs" +
                                                    grplist[index].toString());
                                                setState(() {
                                                  grplist[index] = indexs;
                                                });

                                                print(widget.data![index].id
                                                    .toString());
                                                print(widget.data![index]
                                                    .options![grindex].id
                                                    .toString());
                                                print(widget.data![index]
                                                    .options![grindex].score
                                                    .toString());
                                                _ansQue(
                                                    widget.data![index].id
                                                        .toString(),
                                                    widget.data![index]
                                                        .options![grindex].id
                                                        .toString(),
                                                    widget.data![index]
                                                        .options![grindex].score
                                                        .toString());
                                              },
                                            ),
                                            Container(
                                              width: height * 0.12,
                                              child: Text(
                                                questionData!.data![index]
                                                    .options![grindex].title
                                                    .toString(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: questionData!
                                        .data![index].options!.length,
                                  ),
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext conqtext, int index) {
                              return SizedBox(
                                height: 0,
                              );
                            },
                            itemCount: questionData!.data!.length,
                          )
                        : _buildHraScoreBar(),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    //   child: ButtonWidget(
                    //       title: "BACK",
                    //       color: ThemeClass.blueColor,
                    //       callBack: () async {
                    //         setState(() {
                    //           hrascore = -0;
                    //         });
                    //       }),
                    // ),
                    hrascore == -0
                        ? SizedBox(
                            child: ButtonWidget(
                            width: width - 20,
                            title: "Know Your HRA Score",
                            callBack: () {
                              setState(() {
                                _loadQuestion().then((value) {
                                  setState(() {
                                    getHraScore();
                                  });
                                });
                              });
                            },
                            color: ThemeClass.blueColor,
                          ))
                        : Container(),
                    Container(
                      height: 30,
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
    );
  }

  _buildHraScoreBar() {
    return hrascore != -0
        ? Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 10,
                ),
                Text(
                  "YOUR HRA SCORE",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 15,
                ),
                CircularPercentIndicator(
                  radius: 100.0,
                  animation: true,
                  lineWidth: 10.0,
                  percent: hrascore / 1000,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        hrascore.toString() + "/ 1000",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        hrascoreText,
                        style: TextStyle(
                            fontSize: 15,
                            color: _getHraColor().withOpacity(0.7),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  progressColor: _getHraColor(),
                ),
                Container(
                  height: 20,
                ),
                SizedBox(
                    child: ButtonWidget(
                  width: MediaQuery.of(context).size.width - 100,
                  title: "Recheck Your HRA Score",
                  callBack: () {
                    setState(() {
                      _loadQuestion().then((value) {
                        hrascore = -0;
                      });
                    });
                  },
                  color: ThemeClass.blueDarkColor,
                ))
              ],
            ),
          )
        : Container();
  }

  MaterialColor _getHraColor() {
    if (hrascore >= 800) {
      setState(() {
        hrascoreText = "Excellent!";
      });
      return Colors.green;
    } else if (hrascore >= 650) {
      setState(() {
        hrascoreText = "Good!";
      });
      return Colors.orange;
    } else if (hrascore < 650) {
      setState(() {
        hrascoreText = "Average!";
      });
      return Colors.red;
    } else {
      setState(() {
        hrascoreText = "Bad!";
      });
      return Colors.grey;
    }
  }

  _getHraString() {
    if (hrascore >= 800) {
      setState(() {
        hrascoreText = "Excellent!";
      });
    } else if (hrascore >= 650) {
      setState(() {
        hrascoreText = "Good!";
      });
    } else if (hrascore < 650) {
      setState(() {
        hrascoreText = "Average!";
      });
    } else {
      setState(() {
        hrascoreText = "Bad!";
      });
    }
  }

  Future<get_question_model?> _loadQuestion() async {
    try {
      Map<String, String> queryParameters = {
        "page": "1",
        "count": "100",
        "search": ""
      };

      print(queryParameters);

      var response = await HttpService.httpPost(
          "hra-questions", queryParameters,
          context: context);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = json.decode(response.body);
        questionData = get_question_model.fromJson(body);
        if (questionData != null && questionData?.status == "200") {
          print("Here all question");
          setState(() {
            widget.data = questionData!.data;
          });
          print(questionData?.data);
        } else {
          throw GlobalVariableForShowMessage.internalservererror;
        }

        if (body['success'].toString() == "1" &&
            body['status'].toString() == "200") {
          allQuestion = get_question_model(data: body);
          return get_question_model.fromJson(body);
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


  getHraScore() async {
    var result = await CommonApiCall().getData("hra-report");
    setState(() {
      hrascore = int.parse(result["data"]["score"]);
    });
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
      _loadQuestion().then((value) {
        setState(() {
          isLoading = false;
        });

        questionData!.data!.forEach((element) {
          if (element.isAnswered.toString() == "1") {
            allQuestionsAnswered = true;
            element.options!.asMap().forEach((key, value) {
              if (value.id == element.answeredId.toString()) {
                grplist.add(key + 1);
              }
            });
          } else if (element.isAnswered.toString() == "0") {
            allQuestionsAnswered = false;
            grplist.add(0);
          }
        });
        if (allQuestionsAnswered == true) {
          getHraScore();
          _getHraString();
        }
      });
    });
    super.initState();
  }
}
