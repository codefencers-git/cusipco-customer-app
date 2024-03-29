import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
// import 'package:vibration/vibration.dart';
import '../screens/video_audio/video_screen.dart';
import '../themedata.dart';
import 'min_button.dart';

class VideoCallNotificationAlertWidget extends StatefulWidget {
  VideoCallNotificationAlertWidget(
      {Key? key,
        required this.isSound,
        required this.callRoom,
        required this.callType,
        required this.message,
        required this.title})
      : super(key: key);
  String isSound;
  String callRoom;
  String callType;
  String message;
  String title;

  @override
  State<VideoCallNotificationAlertWidget> createState() =>
      _VideoCallNotificationAlertWidgetState();
}

class _VideoCallNotificationAlertWidgetState
    extends State<VideoCallNotificationAlertWidget> {
  @override
  void initState() {
    // TODO: implement initState

    if (widget.isSound == "true") {
      _startVibrate();
    }

    super.initState();
  }

  _startVibrate() async {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.ringtone,
      ios: IosSounds.glass,
      looping: true,
      // Android only - API >= 28
      volume: 1,
      // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );
    // Vibration.vibrate(pattern: [
    //   500,
    //   500,
    //   500,
    //   500,
    //   500,
    //   500,
    //   500,
    //   500,
    // ], repeat: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 100,
                child: Lottie.asset('assets/animation/alert_animation.json')),
            Container(
              width: MediaQuery.of(context).size.width - 60,
              decoration: BoxDecoration(
                  color: ThemeClass.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    widget.title.toString(),
                    style:
                    TextStyle(fontSize: 16, color: ThemeClass.blackColor),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.message.toString(),
                    style:
                    TextStyle(fontSize: 14, color: ThemeClass.blackColor),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MinButton(
                          title: "Accept",
                          color: ThemeClass.greenColor,
                          heightPadding: 0,
                          fontSize: 10,
                          callBack: () {
                            // _stopRingtoneAndVibration();
                            Navigator.pop(context);
                            pushNewScreen(context,
                                screen: VideoScreen(
                                  type: widget.callType,
                                  roomId: widget.callRoom,
                                ));
                          }),
                      SizedBox(
                        width: 5,
                      ),
                      MinButton(
                          title: "Reject",
                          color: Colors.red,
                          heightPadding: 0,
                          fontSize: 10,
                          callBack: () {
                            // _stopRingtoneAndVibration();
                            Navigator.pop(context);
                          }),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  // _stopRingtoneAndVibration() async {
  //   if (widget.isSound == "true") {
  //     FlutterRingtonePlayer.stop();
  //     Vibration.cancel();
  //   } else {
  //     AwesomeNotifications().cancel(1);
  //   }
  //   var dashboardProvider =
  //   Provider.of<DashboardProvider>(context, listen: false);
  //
  //   dashboardProvider.getDashBoardData(isShowLoading: false);
  // }
}
