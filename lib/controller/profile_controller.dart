import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tik_tok/constants.dart';
import 'package:tik_tok/models/video.dart';





class ProfileController extends GetxController
{
  
  final Rx<Map<String,dynamic>> _user =Rx<Map<String,dynamic>>({});
  Map<String,dynamic> get user =>_user.value;

 Rx<String> _uid="".obs;


 void updateUserId(String uid) async
  { _uid.value =uid;
    await getUserData();


  }


  getUserData() async {

    List<String> thumbnails =[];
    var myVideos =await firestore.collection('videos').where('uid',isEqualTo:_uid.value).get();



    for( int i=0;i<myVideos.docs.length;i++)
      {
        thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
      }



    DocumentSnapshot userDoc =await firestore.collection('users').doc(_uid.value).get();
        final data =userDoc.data() as dynamic;
        String name=data['name'];
        String profilePhoto =data['profilePhoto'];


        int likes =0;
        int followers =0;
        int following =0;
        bool isFollowing =false;

      for(var item in myVideos.docs)
        {
          likes+=(item.data()['likes'] as List).length;
        }

var followerDoc =await firestore.collection('users').doc(_uid.value).collection("followers").get();
    var followingDoc =await firestore.collection('users').doc(_uid.value).collection("following").get();


    followers= followerDoc.docs.length;
    following =followingDoc.docs.length;

    firestore.collection('users').doc(_uid.value).collection('followers').doc(authController.user!.uid).get().then((value){
      if(value.exists)
        {
          isFollowing =true;
        }
      else
        {
          isFollowing=false;
        }
    });



    _user.value={
      'followers':followers.toString(),
      'following':following.toString(),
      'isFollowing':isFollowing,
      'likes':likes.toString(),
      'profilePhoto':profilePhoto.toString(),
      'name':name.toString(),
      'thumbnails':thumbnails,
    };

update();
  }
  void followUser() async {
   var doc= await firestore.collection('users').doc(_uid.value).collection('followers').doc(authController.user!.uid).get();
   if(!doc.exists)
     {
       await firestore.collection('users').doc(_uid.value).collection('followers').doc(authController.user!.uid).set({});
       await firestore.collection('users').doc(authController.user!.uid).collection('following').doc(_uid.value).set({});
       _user.value.update('followers', (value) => (int.parse(value)+1).toString());
     }
   else
     {
       await firestore.collection('users').doc(_uid.value).collection('followers').doc(authController.user!.uid).delete();
       await firestore.collection('users').doc(authController.user!.uid).collection('following').doc(_uid.value).delete();
       _user.value.update('followers', (value) => (int.parse(value)-1).toString());
     }
   _user.value.update('isFollowing', (value) => !value);
   update();
  }
}