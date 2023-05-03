import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cusipco/model/doctors_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/user_model.dart';
import '../../service/prowider/main_navigaton_prowider_service.dart';
import '../../service/shared_pref_service/user_pref_service.dart';
import '../../themedata.dart';
import '../../widgets/app_bars/appbar_with_text.dart';

class ChatDetailsScreen extends StatefulWidget {
  final Data? doctorDetails;

  ChatDetailsScreen({Key? key, this.doctorDetails}) : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("doctorId: " +'bucket_${widget.doctorDetails!.id}');
    var messageInputController = TextEditingController();
    final db = FirebaseFirestore.instance;
    var temp = UserPrefService.preferences!.getString("userModelCustomer");
    var myDetails = UserModel.fromJson(jsonDecode(temp.toString()));
    var myUserId = myDetails.data!.id.toString(); // your user id
    return Container(
      color: ThemeClass.safeareBackGround,
      child: SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(65.0),
                child: AppBarWithTextAndBackWidget(
                  audiovideo: true,
                  onbackPress: () {
                    Provider.of<MainNavigationProwider>(context, listen: false)
                        .chaneIndexOfNavbar(0);
                  },
                  title: "${widget.doctorDetails!.title}",
                )),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: db
                        .collection('bucket_${widget.doctorDetails!.id}')
                        .orderBy('sent_time', descending: true)
                        .snapshots(),

                    // stream: db.collection('chatList').doc("bucket_${widget.doctorDetails!.id+ myDetails.data!.id.toString()}").collection("chat").orderBy('sent_time', descending: true).snapshots(),

                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView(
                            reverse: true ,
                            children: snapshot.data!.docs.map((doc) {
                              return Container(
                                  padding: EdgeInsets.only(
                                      left: 14, right: 14, top: 10, bottom: 10),
                                  child: Align(
                                    alignment: (doc["sender"] == myDetails.data!.id.toString()
                                        ? Alignment.topRight
                                        : Alignment.topLeft),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: (doc["sender"] ==
                                            myUserId
                                            ? Colors.blue[200]
                                            : Colors.grey.shade200),
                                      ),
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        doc["message"],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ));
                            }).toList());
                      }
                    },
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageInputController,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              sendMessage(
                                  messageInputController.text,
                                  widget.doctorDetails!.id.toString(),
                                  myDetails.data!.id.toString(),
                                  // myDetails.data!.name.toString()
                                  // myDetails.data!.profileImage.toString()
                              );
                              messageInputController.clear();
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.blue,
                            ))
                      ],
                    ))
              ],
            )),
      ),
    );
  }

  void sendMessage(String message, String receiverId, String senderId) {

    String currentTimestamp = DateTime.now().toString();

    Map<String, dynamic> messageRow = {
      "sender": senderId,
      "sent_time": currentTimestamp,
      "receiver": receiverId,
      "type": "sender",
      "message": message
    };

    FirebaseFirestore.instance
        .collection("bucket_${widget.doctorDetails!.id}")
        .doc(currentTimestamp)
        .set(messageRow);

    FirebaseFirestore.instance.collection('chatList').doc("bucket_${receiverId+senderId}").collection('chat')
        .doc(currentTimestamp).set(messageRow);

    FirebaseFirestore.instance.collection('chatList').doc("bucket_${receiverId+senderId}").set({
      "client_profileImage" : "",
      "client_name":"",
      "sender1" : senderId,
      "receiver1" : receiverId,
    });

    print("bucket_${senderId+receiverId}");
  }
}
