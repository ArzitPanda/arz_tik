import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tik_tok/constants.dart';
import 'package:tik_tok/controller/auth_controller.dart';
import 'package:tik_tok/models/video.dart';



class VideoController extends GetxController{
      final Rx<List<Video>> _videoList =Rx<List<Video>>([]);
      List<Video> get videoList => _videoList.value;
      
      
      @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _videoList.bindStream(firestore.collection('videos').snapshots().map((QuerySnapshot query){

      List<Video> retVal =[];
      for(var element in query.docs){
        print(element);
        retVal.add(

          Video.fromSnap(element),
        );


      }

      return retVal;
    }));
  }
  
  void likeVideo(String id) async
  {
    String uid =authController.user!.uid;
   DocumentSnapshot vid= await firestore.collection('videos').doc(id).get();
   if((vid.data() as dynamic)['likes'].contains(uid))
     {
        await firestore.collection('videos').doc(id).update(
        {
          "likes":  FieldValue.arrayRemove([uid]),
        }
        );
     }
   else
     {
       await firestore.collection('videos').doc(id).update({
         "likes":FieldValue.arrayUnion([uid]),

       });
     }
  }
  
  
  
}
    
    