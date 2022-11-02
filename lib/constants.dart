import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tik_tok/controller/auth_controller.dart';
import 'package:tik_tok/views/screens/add_video_screen.dart';
import 'package:tik_tok/views/screens/profile_screen.dart';
import 'package:tik_tok/views/screens/search_screen.dart';
import 'package:tik_tok/views/screens/video_screen.dart';


List pages= [
  VideoScreen(),
  SearchScreen(),
  AddScreen(),
  Text("messages screen"),
  ProfileScreen(uid: firebaseAuth.currentUser!.uid),
];

const tiktokLogo ="https://www.freepnglogos.com/uploads/tik-tok-logo-png/tik-tok-how-use-tiktok-create-cool-videos-with-iphone-14.png";

//colors
const backgroundColor= Colors.black;
var buttonColor =Colors.red[400];
const borderColor= Colors.grey;

//firebase
var firebaseAuth= FirebaseAuth.instance;
var firebaseStorage =FirebaseStorage.instance;
var firestore =FirebaseFirestore.instance;


//contoleer
var authController =AuthController.instance;