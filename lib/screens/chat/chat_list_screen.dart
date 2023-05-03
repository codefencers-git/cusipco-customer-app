import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cusipco/model/doctors_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../service/prowider/doctor_details_provider.dart';
import '../../service/prowider/main_navigaton_prowider_service.dart';
import '../../themedata.dart';
import '../../widgets/app_bars/appbar_with_text.dart';
import 'chat_details_screen.dart';

class ChatScreen extends StatefulWidget {

  ChatScreen({Key? key }) : super(key: key);

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

    var myUserId= "429";
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
                  Provider.of<MainNavigationProwider>(context, listen: false)
                      .chaneIndexOfNavbar(0);
                },
                title: "Chat with client",
              )),
          body: StreamBuilder<QuerySnapshot>(
            stream: db.collection('chatList').snapshots(),
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
                          onTap: (){
                            // goto(ChatDetailsScreen(doctorDetails: );
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
                                    image:
                                        NetworkImage("http://cusipco.codefencers.com/uploads/2023/04/df6cd269bc93d75f8cbb9a1a30a90b61.jpg"))
                                  ),
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      // "${doc["name"]}",
                                      // "${snapshotdata[index]['name']}",
                                      "demo",
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Stack(
                                    children: const <Widget>[
                                      Icon(Icons.message),
                                      Positioned(  // draw a red marble
                                        top: 0.0,
                                        right: 0.0,
                                        child: Icon(Icons.brightness_1, size: 8.0,
                                            color: Colors.redAccent),
                                      )
                                    ]
                                ),
                              ],
                            ),
                          ),
                        ));

                },);
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
