import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_bars/appbar_with_text.dart';

const String appId = "8ca89082cb3f4b1ba9342d0d9e1389de";

class VideoScreen extends StatefulWidget {
  VideoScreen(
      {Key? key,
      required this.doctorId,
      required this.token,
      required this.channelName})
      : super(key: key);

  String doctorId, token, channelName;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late final AgoraClient client;
  int uid = 0; // uid of the local user

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: appId,
        channelName: widget.channelName,
        tempToken: widget.token,
        uid: uid,
      ),
    );

    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(65.0),
              child: AppBarWithTextAndBackWidget(
                onbackPress: () {
                  Navigator.pop(context);
                  // client.release();
                },
                isShowCart: false,
                title: widget.doctorId,
              )),
          body: SafeArea(
            child: Stack(
              children: [

                AgoraVideoViewer(
                  client: client,
                  layoutType: Layout.floating,
                  floatingLayoutContainerHeight: 10,
                  showNumberOfUsers: true,
                  enableHostControls: true, // Add this to enable host controls
                ),
                AgoraVideoButtons(
                  client: client,
                  onDisconnect: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}
