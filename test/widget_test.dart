// // // This is a basic Flutter widget test.
// // //
// // // To perform an interaction with a widget in your test, use the WidgetTester
// // // utility that Flutter provides. For example, you can send tap and scroll
// // // gestures. You can also use WidgetTester to find child widgets in the widget
// // // tree, read text, and verify that the values of widget properties are correct.
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_test/flutter_test.dart';
// //
// // import 'package:cusipco/main.dart';
// //
// // void main() {
// //   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
// //     // Build our app and trigger a frame.
// //     await tester.pumpWidget(const MyApp());
// //
// //     // Verify that our counter starts at 0.
// //     expect(find.text('0'), findsOneWidget);
// //     expect(find.text('1'), findsNothing);
// //
// //     // Tap the '+' icon and trigger a frame.
// //     await tester.tap(find.byIcon(Icons.add));
// //     await tester.pump();
// //
// //     // Verify that our counter has incremented.
// //     expect(find.text('0'), findsNothing);
// //     expect(find.text('1'), findsOneWidget);
// //   });
// // }
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cusipco/model/doctors_detail_model.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../service/prowider/main_navigaton_prowider_service.dart';
// import '../../themedata.dart';
// import '../../widgets/app_bars/appbar_with_text.dart';
// import 'chat_details_screen.dart';
//
// class ChatScreen extends StatefulWidget {
//
//   ChatScreen({Key? key }) : super(key: key);
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   void initState() {
//     print("---------------init state called of profile");
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var myUserId= "429";
//     final db = FirebaseFirestore.instance;
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Container(
//       color: ThemeClass.safeareBackGround,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: PreferredSize(
//               preferredSize: Size.fromHeight(65.0),
//               child: AppBarWithTextAndBackWidget(
//                 onbackPress: () {
//                   Provider.of<MainNavigationProwider>(context, listen: false)
//                       .chaneIndexOfNavbar(0);
//                 },
//                 title: "Chat with client",
//               )),
//           body: StreamBuilder<QuerySnapshot>(
//             stream: db.collection('chatList').snapshots(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else {
//                 return ListView(
//                     children: snapshot.data!.docs.map((doc) {
//                       print("ddcdcdcdcdc"+ doc.toString());
//                       return Card(
//                           child: InkWell(
//                             onTap: (){
//
//                             },
//                             child: ListTile(
//                               title: Row(
//                                 children: [
//                                   Container(
//                                     margin: EdgeInsets.all(5),
//                                     decoration: BoxDecoration(
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(100)),
//                                       /* image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image:
//                                         NetworkImage("${doc["profileImage"]}"))*/),
//                                     width: 50,
//                                     height: 50,
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Column(
//                                     children: [
//                                       Text(
//                                         // "${doc["name"]}",
//                                         "${doc["name"]}",
//                                       ),
//                                     ],
//                                   ),
//                                   Spacer(),
//                                   Stack(
//                                       children: const <Widget>[
//                                         Icon(Icons.message),
//                                         Positioned(  // draw a red marble
//                                           top: 0.0,
//                                           right: 0.0,
//                                           child: Icon(Icons.brightness_1, size: 8.0,
//                                               color: Colors.redAccent),
//                                         )
//                                       ]
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ));
//                     }).toList());
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
