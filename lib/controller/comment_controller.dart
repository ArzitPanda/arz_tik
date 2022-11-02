
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tik_tok/constants.dart';

import '../models/comment.dart';

class CommentController extends GetxController
{

  final Rx<List<Comment>> _comments= Rx<List<Comment>>([]);

  List<Comment> get comments => _comments.value;


  String _postId="";



  void setPostId(String id)
  {
    _postId=id;
    getComments();
  }



  void InterActComment(String commentId) async
  {
    DocumentReference ref =firestore.collection('videos').doc(_postId).collection('comments').doc(commentId);
    DocumentSnapshot commentSnap = await firestore.collection('videos').doc(_postId).collection('comments').doc(commentId).get();
    if((commentSnap.data()! as dynamic)['likes'].contains(authController.user!.uid))
      {
      await  ref.update({
          'likes':FieldValue.arrayRemove([authController.user!.uid])
        });
      }
    else
      {
        await  ref.update({
          'likes':FieldValue.arrayUnion([authController.user!.uid])
        });
      }



  }


  getComments() async
  {

    _comments.bindStream(
      firestore.collection('videos').doc(_postId).collection('comments').snapshots().map((QuerySnapshot query) {
        List<Comment> retValue=[];
        for(var element in query.docs)
          {
            retValue.add(Comment.fromSnap(element));
          }

        return retValue;
      })
    );


  }








  postComments(String messageText) async
  {
    try
        {
          if(messageText.isNotEmpty)
          {
            DocumentSnapshot userDoc =await firestore.collection('users').doc(authController.user!.uid).get();
            var allDocs = await firestore.collection('videos').doc(_postId).collection('comments').get();
            int length = allDocs.docs.length;

            Comment comment = Comment(username: (userDoc.data() as dynamic)['name'], comment: messageText.trim(), datePublished: DateTime.now(), likes: [], profilePhoto:(userDoc.data() as dynamic)['profilePhoto'], uid: (userDoc.data() as dynamic)['uid'], id: "comment $length");

            await firestore.collection('videos').doc(_postId).collection('comments').doc("comment $length").set(
                comment.toJson()
            );

   DocumentSnapshot commentsSnap =await firestore.collection('videos').doc(_postId).get();

   await firestore.collection('videos').doc(_postId).update({
     'commentCount':(commentsSnap.data() as dynamic)['commentCount']+1,

   });





          }
        }
        catch(e)
    {
      Get.snackbar("comment error", e.toString());
    }

  }



}