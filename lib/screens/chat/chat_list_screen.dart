import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cusipco/model/doctors_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../model/user_model.dart';
import '../../service/prowider/main_navigaton_prowider_service.dart';
import '../../service/shared_pref_service/user_pref_service.dart';
import '../../themedata.dart';
import '../../widgets/app_bars/appbar_with_text.dart';
import 'chat_details_screen.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    print("---------------init state called of profile");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var temp = UserPrefService.preferences!.getString("userModelCustomer");
    var myDetails = UserModel.fromJson(jsonDecode(temp.toString()));
    var myUserId = myDetails.data!.id.toString(); //

    // var myUserId= "429";
    final db = FirebaseFirestore.instance;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      color: ThemeClass.safeareBackGround,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(65.0),
              child: AppBarWithTextAndBackWidget(
                onbackPress: () {
                  Navigator.pop(context);
                },
                title: "Chat with doctors",
              )),
          body: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('chatList')
                .where('client_senderid', isEqualTo: myUserId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var snapshotdata = snapshot.data!.docs;

                print("snapshotdatalenght ${snapshotdata.length}");

                return ListView.builder(
                  itemCount: snapshotdata.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: InkWell(
                      onTap: () {
                        goto(ChatDetailsScreen(drid: snapshotdata[index]['dr_senderid'], drname: snapshotdata[index]['dr_name'], drprofileimage: snapshotdata[index]['dr_profileimage'],));
                      },
                      child: ListTile(
                        title: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(snapshotdata[index]
                                          ['dr_profileimage']))),
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  snapshotdata[index]['dr_name'],
                                ),
                              ],
                            ),
                            Spacer(),
                            Stack(children: const <Widget>[
                              Icon(Icons.message),
                              Positioned(
                                // draw a red marble
                                top: 0.0,
                                right: 0.0,
                                child: Icon(Icons.brightness_1,
                                    size: 8.0, color: Colors.redAccent),
                              )
                            ]),
                          ],
                        ),
                      ),
                    ));
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  goto(Widget _screen) {
    pushNewScreen(
      context,
      screen: _screen,
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
