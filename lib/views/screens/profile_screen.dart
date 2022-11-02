import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:tik_tok/constants.dart';
import 'package:get/get.dart';



import 'package:tik_tok/controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  ProfileScreen({Key? key, required this.uid}) : super(key: key);


  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final ProfileController profileController =Get.put(ProfileController());

  @override
  void initState()
  { print(widget.uid);
    super.initState();
    profileController.updateUserId(widget.uid);

  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(

        init: ProfileController(),

        builder: (controller) {

          if(controller
          .user.isEmpty)
            {
             return const Center(
                child: CircularProgressIndicator(),
              );
            }


          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                leading: Icon(Icons.person_add_alt_1_outlined),
                actions: [
                  Icon(Icons.more_horiz_rounded)
                ],
                title: Center(
                  child: Text(controller.user['name'] ,style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),),
                ),
              ),
              body:SafeArea(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child:  CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: controller.user['profilePhoto'],
                                height: 100,
                                width: 100,
                                placeholder: ((context, url) => CircularProgressIndicator()),
                                errorWidget: ((context, url, error) => const Icon(
                                    Icons.error
                                )),

                              ),
                            ),


                          ],
                        ),
                        SizedBox(
                          height: 38,
                        ),
                        Row(

                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Column(
                              children: [
                                Text(controller.user['likes'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('likes',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),

                              ],
                            ),
                            SizedBox(width: 15,),
                            Column(
                              children: [
                                Text(controller.user['following'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('Following',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),)
                              ],
                            ),
                            SizedBox(width: 15,),
                            Column(
                              children: [
                                Text(controller.user['followers'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('Followers',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: 140,
                          height:47,
                          padding: EdgeInsets.symmetric(horizontal: 14,vertical: 7),
                          decoration: BoxDecoration(border:Border.all(
                              color: Colors.black12,
                              width: 4
                          )),
                          child: authController.user!.uid == widget.uid?
                          Center(
                            child: InkWell(child: Text('sign out',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Chalkboard SE")),
                                onTap: (){

                              if(widget.uid ==authController.user!.uid)
                                {
                                  authController.signOut();
                                }

                                }),
                          ):
                          controller.user['isFollowing']?
                          Center(
                            child: InkWell(child: Text("unfollow",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Chalkboard SE",color:Colors.grey
                             )),
                                onTap: ()=>controller.followUser()),
                          ):
                          Center(
                            child: InkWell(child: Text("follow",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Chalkboard SE",color:Colors.redAccent
                            )),
                                onTap: ()=>controller.followUser())),
                          ),


                      ],
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: (controller.user['thumbnails'] as List).length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1,crossAxisSpacing: 5), itemBuilder: (context, index) {
                      String thumbnail= controller.user['thumbnails'][index];
                      return CachedNetworkImage(imageUrl: thumbnail,
                          fit:BoxFit.cover);
                    }),


                  ],
                ),
              )
          );
        }
    );
  }
}

