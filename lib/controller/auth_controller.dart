

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as fireauth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tik_tok/constants.dart';
import 'package:tik_tok/models/user.dart' as model;
import 'package:tik_tok/views/screens/home_screen.dart';
import 'package:tik_tok/views/screens/auth/login_screen.dart';

class AuthController extends GetxController
{
    static AuthController instance = Get.find();
    late Rx<fireauth.User?> _user;
    late Rx<File?> _pickedImage;
final supabase =Supabase.instance.client;

    File? get profilePhoto => _pickedImage.value;
    fireauth.User? get user => _user.value;

    @override
    void onReady()
    {
      super.onReady();
      _user =Rx<fireauth.User?>(firebaseAuth.currentUser);
      _user.bindStream(firebaseAuth.authStateChanges());
      ever(_user,_setInitialScreen);

    }
    _setInitialScreen(fireauth.User? user)
    {
      if(user==null)
        {
          Get.offAll(()=>LoginScreen());
        }
      else
        {
          Get.offAll(()=>const HomeScreen());
        }
    }




    void pickImage() async{
    final pickedImage =await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage!=null)
      {
        Get.snackbar('profile picture', "you have sucessfully selected your picture");
      }
    _pickedImage =Rx<File?>(File(pickedImage!.path));
    }


  Future<String> _uploadToStorage(File image) async {

   String id =user!.uid;
    await supabase.storage.from('tiktok-123').upload("profile/$id", image,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false)

    );


    final String publicUrl = supabase
        .storage
        .from('tiktok-123')
        .getPublicUrl("profile/$id");

    // UploadTask task =ref.putFile() ;
    // TaskSnapshot snap = await task;
    // String downloadUrl = await snap.ref.getDownloadURL();
    return publicUrl;
  }

  void registerUser(String username,String email,String password,File? image) async
  {
    try{
      if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image!=null)
        {
        fireauth.UserCredential cred= await firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password);
       String downloadUrl = await _uploadToStorage(image);
       model.User user = model.User(name: username,uid: cred.user!.uid,profilePhoto:downloadUrl,email: email );
      await firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

        }
      else
        {
          Get.snackbar("Error", "please enter all the field");
        }
    }
    catch(e)
    {
      Get.snackbar("Error", e.toString());
    }
  }
void loginUser(String email,String password) async
{
 try{
   if(email.isNotEmpty && password.isNotEmpty)
     {
       await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
       Get.snackbar("login", "sucessfully");
     }
   else
     {
       Get.snackbar("login error", "type all the field");
     }
 }
 catch(e)
  {
    Get.snackbar('login error', e.toString());
  }

}
void signOut() async{
      await firebaseAuth.signOut();
}





}
