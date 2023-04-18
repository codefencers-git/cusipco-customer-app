import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  AgoraClient client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
          appId: "8af20c120eca4ce18a3e0aac2ee847fa", channelName: "cusipco", tempToken: "007eJxTYHj0pphrXn7gK+9thxbFT5eKzJNwfsH55rjusprw+LOO7wsUGCwS04wMkg2NDFKTE02SUw0tEo1TDRITk41SUy1MzNMSJRbbpTQEMjIcUpFgZmSAQBCfnSG5tDizIDmfgQEA86YhHQ=="),
      enabledPermission: [Permission.camera, Permission.microphone]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async {
    await client.initialize();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AgoraVideoViewer(client: client),
          AgoraVideoButtons(client: client)
        ],
      ),
    );
  }
}
