import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok/controller/search_controller.dart';
import 'package:tik_tok/views/screens/profile_screen.dart';




class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

TextEditingController   searchTextController = TextEditingController();
  final SearchController searchController =Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Obx(
       () {
        return Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: ()=>searchController.searchUser(searchTextController.text),
                child: Icon(Icons.search),
              )
            ],
            backgroundColor: Colors.red,
            title: TextFormField(
              decoration: const InputDecoration(
                filled: false,
                hintText: 'search',
                hintStyle: TextStyle(
                  fontSize: 18,color: Colors.white,

                )
              ),
controller: searchTextController,
            
            ),
          ),
          body: searchController.searchedUser.isEmpty?
          const Center(
            child: Text("search for users",style: TextStyle(fontSize: 25,color:Colors.white,fontWeight: FontWeight.bold)),
          ):ListView.builder(

          itemCount: searchController.searchedUser.length,
          itemBuilder: (context, index) {

            final searched =searchController.searchedUser[index];

          return InkWell(child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(searched.profilePhoto),),
        title: Text(searched.name,style: TextStyle(
        fontSize: 18,
        color:Colors.white,
        ),),


          ),
          onTap: (){
            
            Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ProfileScreen(uid: searched.uid) ));
          }

            
            
            
            ,);}
          ),);
      }
    );

  }
}
