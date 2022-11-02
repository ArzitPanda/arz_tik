
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tik_tok/constants.dart';
import 'package:tik_tok/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController{
  final supabase = Supabase.instance.client;
// late Rx<bool> videoUploading;
  _compressVideo(String videopath) async
  {
 final compressedVideo= await VideoCompress.compressVideo(videopath,quality: VideoQuality.MediumQuality,);

 return compressedVideo!.file;

  }

  Future<String> _uploadVideoStorage(String id,String path) async
  {
    // Reference ref =firebaseStorage.ref().child('videos').child(id);



    File data =await _compressVideo(path);
await supabase.storage.from('tiktok-123').upload("video/$id.mp4", data,
fileOptions: const FileOptions(cacheControl: '3600', upsert: false)

);


    final String publicUrl = supabase
        .storage
        .from('tiktok-123')
        .getPublicUrl("video/$id.mp4");

    // UploadTask task =ref.putFile() ;
    // TaskSnapshot snap = await task;
    // String downloadUrl = await snap.ref.getDownloadURL();
    return publicUrl;
  }


  Future<String> _uploadImageToStorage(String id,String path) async
  {
    Reference ref =firebaseStorage.ref().child('thumbnails').child(id);

      final thumbnail =await VideoCompress.getFileThumbnail(path);

    // File data =await _compressVideo(path);
    await supabase.storage.from('tiktok-123').upload("image/$id", thumbnail,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false)

    );


    final String publicUrl = supabase
        .storage
        .from('tiktok-123')
        .getPublicUrl("image/$id");

    // UploadTask task =ref.putFile() ;
    // TaskSnapshot snap = await task;
    // String downloadUrl = await snap.ref.getDownloadURL();
    return publicUrl;
  }



  uploadVideo(String songname,String caption,String videoPath,) async
  {
    // videoUploading =true as Rx<bool>;
    // ever(videoUploading, _loadingButton(context,videoUploading));
    try
        {

          String uid =firebaseAuth.currentUser!.uid;
          DocumentSnapshot useDoc =await firestore.collection('users').doc(uid).get();

          var allDocs =await firestore.collection('videos').get();
          int len =allDocs.docs.length;
         String videoUrl = await _uploadVideoStorage("video $len",videoPath);
         String thumbnail =await _uploadImageToStorage("image $len",videoPath);
Video vid = Video(username: (useDoc.data()! as Map<String,dynamic>)['name'], uid: uid, id: "video $len", songname: songname, caption: caption, videoUrl: videoUrl, thumbnail: thumbnail, profilephoto: (useDoc.data()! as Map<String,dynamic>)['profilePhoto'], likes: [], shareCount: 0, commentCount: 0);


await firestore.collection('videos').doc('video $len').set(vid.toJson());
          // videoUploading =false as Rx<bool>;
Get.back();
        }
        catch(e)
    {

      Get.snackbar("error uploading", e.toString());
    }
    
    
  }
  
  
  
  
}

