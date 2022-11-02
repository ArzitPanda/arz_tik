import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tik_tok/constants.dart';

import '../models/user.dart';



class SearchController extends GetxController
{
  final Rx<List<User>> _searchedUser =Rx<List<User>>([]);


  List<User> get searchedUser => _searchedUser.value;

  searchUser(String typedUser) async
  {

    _searchedUser.bindStream(
        firestore.collection('users').where('name',isGreaterThanOrEqualTo: typedUser).snapshots().map((QuerySnapshot search){
          List <User> retVal =[];
          for(var elem in search.docs)
          {
            retVal.add(User.fromSnap(elem));
          }

          return retVal;

        })
    );


  print(searchedUser);

  }



}