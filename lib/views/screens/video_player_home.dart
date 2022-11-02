import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerHome extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerHome({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerHomeState createState() => _VideoPlayerHomeState();
}

class _VideoPlayerHomeState extends State<VideoPlayerHome> {
  late VideoPlayerController vidcontroller;



  @override
  void initState()
  {
    super.initState();
    vidcontroller=VideoPlayerController.network(widget.videoUrl)..initialize().then((value) {
      vidcontroller.setVolume(1);
      vidcontroller.play();
      vidcontroller.setLooping(true);
    }
    );
  }


  @override
  void dispose()
  {
    super.dispose();
    vidcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.black,
      ),

      child:  VideoPlayer(vidcontroller),
    );
  }
}
