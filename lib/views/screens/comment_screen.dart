import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_tok/constants.dart';
import 'package:tik_tok/controller/comment_controller.dart';
import 'package:tik_tok/views/Widgets/text_input_field.dart';
import 'package:get/get.dart';



class CommentScreen extends StatelessWidget {
  final String id;
  const CommentScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {

TextEditingController specCommentController =TextEditingController();
CommentController commentController =Get.put(CommentController());
    final size =MediaQuery.of(context).size;
commentController.setPostId(id);
    return Scaffold(
      body:SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child:
          Column(
            children: [
              Expanded(child:
              Obx(

                 () {
                  return ListView.builder(itemCount: commentController.comments.length,itemBuilder: (context,index){
final commentData= commentController.comments[index];
                    
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: size.width,
                        child: Container(

                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.pinkAccent,
                                width: 2
                              ),
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey.shade900
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(commentData.profilePhoto),
                               ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(commentData.username,style:
                                        TextStyle(fontWeight: FontWeight.bold,fontSize:25,color: Colors.redAccent),),
                                        SizedBox(width: 4,),
                                        Text(commentData.comment,style: TextStyle(fontWeight: FontWeight.w500,fontSize:15,color: Colors.white),)




                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        Text("2 days",style: const TextStyle(fontWeight: FontWeight.w300,fontSize:9,color: Colors.white70)),
                                        const SizedBox(width: 7,),
                                        Text(commentData.likes.length.toString()+" likes",style: const TextStyle(fontWeight: FontWeight.w200,fontSize:9,color: Colors.white70)),
                                      ],
                                    )
                                  ],
                                ),
                                Padding(child: InkWell(
                                    
                                    onTap: ()=>commentController.InterActComment(commentData.id),
                                    child: Icon(Icons.favorite,color: commentData.likes.contains(authController.user!.uid)?Colors.pinkAccent:Colors.white,size: 40,)),
                                  padding: EdgeInsets.only(bottom: 10,left:6),
                               )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                }
              )),
              TextField(
                controller:specCommentController ,
                // isObsecure: false,
                obscureText: false,

                decoration: InputDecoration(

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(

                      width: 3
                    ),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(7),

                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 6),
                    suffixIcon: InkWell(child: Icon(Icons.send),onTap: ()=>commentController.postComments(specCommentController.text)),
                  label: Text("type a message",style: TextStyle(
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold
                  ),)
                ),


              ),
            ],
          ),
        ),
      )
    );
  }
}
