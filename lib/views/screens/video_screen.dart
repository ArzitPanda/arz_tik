// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok/constants.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tik_tok/controller/video_controller.dart';
import 'package:tik_tok/views/Widgets/circle_animation.dart';
import 'package:tik_tok/views/screens/comment_screen.dart';
import 'package:tik_tok/views/screens/video_player_home.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  VideoController videoController =Get.put(VideoController());



  Widget buildProfile(String profilePhoto)
  {
    return SizedBox(
      height: 60,
      width: 60,
      child:
      Stack(
        children: [
          Positioned(child:
          Container(width: 50,height: 50,padding: EdgeInsets.all(1),decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:BorderRadius.circular(25),

          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child:
              Image(image:
              NetworkImage(profilePhoto),
                  fit: BoxFit.cover)
          )
            ,)
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx(() {
          return PageView.builder(
              itemCount: videoController.videoList.length,
            controller: PageController(initialPage: 0,viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder:(context,index){
                print(videoController.videoList.length);
              final data = videoController.videoList[index];
            return Stack(
              children: [
                VideoPlayerHome(videoUrl:data.videoUrl),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    const SizedBox(height: 100,),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(child: Container(padding: EdgeInsets.only(left: 20,),

                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(data.username,style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),),
                              Text(data.caption,style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16),),
                              Row(
                                children: [
                                  Icon(Icons.music_note,color: Colors.white,),
                                Text(data.caption)


                                ],
                              )
                            ],
                          ),)),
                          Container(
                            width: 100,
                            height: MediaQuery.of(context).size.height*.6,
                            margin: EdgeInsets.only(top: 10),
                            child: Column(

                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildProfile(data.profilephoto),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: ()=>videoController.likeVideo(data.id),
                                      child: Icon(Icons.favorite,size: 40,color:data.likes.contains(authController.user!.uid)?Colors.red:Colors.white),
                                    ),
                                    const SizedBox(height: 7,),
                                    Text(data.likes.length.toString() +"likes",style: const TextStyle(fontSize: 17,color: Colors.white),)

                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CommentScreen(id:data.id)));
                                      },
                                      child: Icon(Icons.comment,size: 40,color: Colors.white),
                                    ),
                                    const SizedBox(height: 7,),
                                    Text(data.commentCount.toString(),style: const TextStyle(fontSize: 17,color: Colors.white),)

                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: (){},
                                      child: Icon(Icons.share,size: 40,color: Colors.white),
                                    ),
                                    const SizedBox(height: 7,),
                                    Text(data.commentCount.toString(),style: const TextStyle(fontSize: 17,color: Colors.white),)

                                  ],
                                ),
                                CircleAnimation(child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: CircleAvatar(

                                    child: Container(
                                      decoration: BoxDecoration(borderRadius:  BorderRadius.circular(20),),
                                      child:
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(data.profilephoto,width: 40,height: 40,fit: BoxFit.cover,),
                                      ),
                                    ),
                                  )
                                ))
                              ],
                            ),
                          )
                        ],
                      ),

                    )
                  ],
                )
              ],
            );
    },
          );
        }
      ));
  }
}
