import 'package:cloud_firestore/cloud_firestore.dart';

class Video
{
  String username;
  String uid;
  String id;
  String songname;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilephoto;
  List likes;
  int shareCount;
  int commentCount;

  Video(
      {required this.username,
        required   this.uid,
        required this.id,
        required this.songname,
        required this.caption,
        required this.videoUrl,
        required this.thumbnail,
        required this.profilephoto,
        required this.likes,
        required this.shareCount,

        required this.commentCount});




  Map<String,dynamic> toJson()=>{
    "username":username,
    "uid":uid,
    "profilePhoto":profilephoto,
    "id":id,
    "likes":likes,
    "commentCount":commentCount,
    "shareCount":shareCount,
    "songname":songname,
    "caption":caption,
    "videoUrl":videoUrl,
    "thumbnail":thumbnail
  };
static Video fromSnap(DocumentSnapshot snap)
{   var s= snap.data() as Map<String,dynamic>;
  return Video(username: s['username'],
      uid: s['uid'],
      id: s['id'],
      songname: s['songname'],
      caption: s['caption'],
      videoUrl: s['videoUrl'],
      thumbnail: s['thumbnail'],
      profilephoto: s['profilePhoto'],
      likes:  s['likes'],
      shareCount: s['shareCount'],
      commentCount: s['commentCount']);
}

}