import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_tok/constants.dart';
import 'package:tik_tok/views/screens/confirm_screen.dart';


class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);


  pickVideo(ImageSource src, BuildContext context) async
  {
    final video =await ImagePicker().pickVideo(source: src);
    if(video !=null)
      {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ConfirmScreen(
          videoFile: File(video.path),
          videoPath: video.path,
        )));
      }
  }

  showOptionsDialog(BuildContext context)
  {
    return showDialog(context: context,builder: (context)=>
      SimpleDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),

        children: [
          SimpleDialogOption(

            onPressed: ()=>pickVideo(ImageSource.gallery, context),
            child: Row(

              children: [
                Icon(Icons.image,color: Colors.black,),
                Padding(padding: EdgeInsets.all(8.0),
                child: Text('Gallery',style: TextStyle(fontSize: 20,color: Colors.black),),
                )
              ],
            ),
          ),
          SimpleDialogOption(

            onPressed: ()=>pickVideo(ImageSource.camera, context),
            child: Row(

              children: [
                Icon(Icons.camera,color: Colors.black,),
                Padding(padding: EdgeInsets.all(8.0),
                  child: Text('Camera',style: TextStyle(fontSize: 20,color: Colors.black),),
                )
              ],
            ),
          ),
          SimpleDialogOption(

            onPressed: ()=>Navigator.of(context).pop(),
            child: Row(

              children: [
                Icon(Icons.cancel,color: Colors.redAccent,),
                Padding(padding: EdgeInsets.all(8.0),
                  child: Text('cancel',style: TextStyle(fontSize: 20,color: Colors.redAccent),),
                )
              ],
            ),
          )
        ],
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        Image.network(tiktokLogo,fit: BoxFit.scaleDown,),
        SizedBox(height: 40,),
        InkWell(
          onTap: ()=>showOptionsDialog(context),
          child: Container(
            width: MediaQuery.of(context).size.width-50,
            height: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),color: buttonColor),
            child: Center(child: Text("Add Video",style: TextStyle(fontSize: 20),)),
          ),
        )
      ],
    ),
    );
  }
}
