import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tik_tok/constants.dart';
import 'package:tik_tok/views/Widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int pageIdx =0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx){
          setState(() {
            pageIdx=idx;
          });
        },
          backgroundColor: backgroundColor,
          type: BottomNavigationBarType.fixed,
          // backgroundColor: Colors.blue,
          selectedIconTheme: IconThemeData(color: buttonColor),
currentIndex: pageIdx,

          items:const [
            BottomNavigationBarItem(icon: Icon(Icons.home,size:30),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search,size:30),label: 'search'),
            BottomNavigationBarItem(icon: CustomIcon(),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.message,size:30),label: 'message'),
            BottomNavigationBarItem(icon: Icon(Icons.person,size:30),label: 'person'),

          ]),
      body: Center(child: pages[pageIdx]),
    );
  }
}

