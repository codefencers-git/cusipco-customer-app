// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import 'package:cusipco/main.dart';
//
// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());
//
//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);
//
//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();
//
//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

//videoscreenbackupcode
// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:flutter/material.dart';
//
// import '../../widgets/app_bars/appbar_with_text.dart';
//
// const String appId = "8ca89082cb3f4b1ba9342d0d9e1389de";
//
// class VideoScreen extends StatefulWidget {
//   VideoScreen(
//       {Key? key,
//         required this.doctorId,
//         required this.token,
//         required this.channelName})
//       : super(key: key);
//
//   String doctorId, token, channelName;
//
//   @override
//   State<VideoScreen> createState() => _VideoScreenState();
// }
//
// class _VideoScreenState extends State<VideoScreen> {
//   late final AgoraClient client;
//   int uid = 0; // uid of the local user
//
//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }
//
//   void initAgora() async {
//     client = AgoraClient(
//       agoraConnectionData: AgoraConnectionData(
//         appId: appId,
//         channelName: widget.channelName,
//         tempToken: widget.token,
//         uid: uid,
//       ),
//     );
//
//     await client.initialize();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           appBar: PreferredSize(
//               preferredSize: Size.fromHeight(65.0),
//               child: AppBarWithTextAndBackWidget(
//                 onbackPress: () {
//                   Navigator.pop(context);
//                   // client.();
//                 },
//                 isShowCart: false,
//                 title: widget.doctorId,
//               )),
//           body: SafeArea(
//             child: Stack(
//               children: [
//
//                 AgoraVideoViewer(
//                   client: client,
//                   layoutType: Layout.floating,
//                   floatingLayoutContainerHeight: 10,
//                   showNumberOfUsers: true,
//                   enableHostControls: true, // Add this to enable host controls
//                 ),
//                 AgoraVideoButtons(
//                   client: client,
//                   onDisconnect: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         )
//     );
//   }
// }


//audioscreenbackupcode
// import 'dart:async';
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:flutter/material.dart';
//
// class CallingScreen extends StatefulWidget {
//   String? channelName;
//   String? token;
//   bool? isCaller;
//
//   CallingScreen({
//     Key? key,
//     this.channelName,
//     this.token,
//     this.isCaller,
//   }) : super(key: key);
//
//   @override
//   State<CallingScreen> createState() => _CallingScreenState();
// }
//
// class _CallingScreenState extends State<CallingScreen> {
//
//   Widget body = Container();
//   bool _localUserJoined = false;
//   bool remoteUserJoined = false;
//   bool _showStats = false;
//   int? _remoteUid;
//   RtcStats? _stats;
//   late RtcEngine engine;
//
//   // Timer for call (when 40 seconds pass then the user is not responding)
//   Timer? callingTimer;
//   int callingTimerStart = 40;
//   // Timer for call duration (to show the seconds on the screen)
//   Timer? callTimeTimer;
//   int callTimeTimerStart = 0;
//
//   bool micMuted = false;
//   bool camOn = true;
//
//   bool userDeclinedCall = false;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     userDeclinedCall = false;
//
//     body = Container();
//
//     // Initialize agora rtc engine
//     initRTC();
//   }
//
//   initRTC() async {
//     // Inititialize agora engine params
//     await initAgora();
//
//     if (widget.isCaller!) {
//       // await initCall();
//     } else {
//       // await joinCall();
//     }
//   }
//
//   initAgora() async {
//     // Create engine with app id
//     engine = await RtcEngine.create(Utils.agoraAppId);
//
//     // Set the callbacks for the engine
//     engine!.setEventHandler(RtcEngineEventHandler(
//       joinChannelSuccess: (String channel, int uid, int elapsed) {
//         // This is called when current user joins channel
//         print('$uid successfully joined channel: $channel ');
//         setState(() {
//           _localUserJoined = true;
//         });
//       },
//       userJoined: (int uid, int elapsed) {
//         // This is called when the other user joins the channel
//         print('remote user $uid joined channel');
//         setState(() {
//           remoteUserJoined = true;
//           _remoteUid = uid;
//           body = Stack(
//             children: [
//               Container(
//                 child: renderRemoteVideo(),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Align(
//                   alignment: Alignment.topLeft,
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.3,
//                     height: MediaQuery.of(context).size.width * 0.4,
//                     child: renderLocalPreview(),
//                   ),
//                 ),
//               )
//             ],
//           );
//           callingTimer!.cancel();
//         });
//         // Other user joined call then start call duration counter
//         startCallTimerTimer();
//       },
//       userOffline: (int uid, UserOfflineReason reason) async {
//         // If the other user hangs up or disconnects
//         print('remote user $uid left channel');
//         setState(() {
//           _remoteUid = null;
//         });
//
//         // Leave channel as well and go back to dialing page
//         await engine!.leaveChannel();
//
//         Navigator.of(context).pop();
//       },
//       rtcStats: (stats) {
//         // TODO: show stats here if you want
//       },
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

