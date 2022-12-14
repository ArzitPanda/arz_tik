import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok/controller/upload_video_controller.dart';
import 'package:tik_tok/views/Widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';


class ConfirmScreen extends StatefulWidget {
    final File videoFile;
    final String videoPath;


  const ConfirmScreen({Key? key, required this.videoFile, required this.videoPath}) : super(key: key);

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  TextEditingController songController =TextEditingController();
  TextEditingController captionController =TextEditingController();
UploadVideoController uploadVideoController = Get.put(UploadVideoController());



  @override
  void initState(){
    super.initState();
    setState(() {
      controller= VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.5,
              child: VideoPlayer(controller),

            ),
            const SizedBox(height: 30,),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width:MediaQuery.of(context).size.width-20,
                    child: TextInputField(
                      controller: songController,
                      labeltext: "song name",
                      isObsecure: false,
                      icon: Icons.music_note,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width:MediaQuery.of(context).size.width-20,
                    child: TextInputField(
                      controller: captionController,
                      labeltext: "caption",
                      icon: Icons.closed_caption, isObsecure: false,
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: ()=>uploadVideoController.uploadVideo(songController.text,captionController.text,widget.videoPath), child: Text('share',style: TextStyle(fontSize: 20,color: Colors.white),))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

