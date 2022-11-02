import 'package:flutter/material.dart';
import 'package:tik_tok/constants.dart';
import 'package:tik_tok/views/Widgets/text_input_field.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({Key? key}) : super(key: key);
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: ListView(
        children: [

          SizedBox(height: MediaQuery.of(context).size.height*0.15,),
          Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("Tiktok",style: TextStyle(fontSize: 35,color:buttonColor,fontWeight: FontWeight.w900,),),
              const Text("sign up",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,),),
              const SizedBox(height: 15,),
              Stack(

                children: [
                  CircleAvatar(
                    radius:64,
                    backgroundImage: NetworkImage("https://thumbs.dreamstime.com/b/user-icon-flat-style-person-icon-user-icon-web-site-user-icon-vector-illustration-user-icon-flat-style-person-icon-user-131140097.jpg"),
                  ),
                  Positioned(
                    bottom: -10,
                      left:80,
                      child:IconButton(
                        icon:Icon(Icons.add_a_photo_sharp,color: buttonColor,) , onPressed: ()=> authController.pickImage(),
                      ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextInputField(
                    controller: _usercontroller,
                    icon: Icons.person,
                    isObsecure: false,
                    labeltext: "username",
                  ),
                ),
              ),
              const SizedBox(height: 35,),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextInputField(
                    controller: _emailcontroller,
                    icon: Icons.email_outlined,
                    isObsecure: false,
                    labeltext: "email",
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextInputField(
                    controller: _passwordcontroller,
                    icon: Icons.key,
                    isObsecure: true,
                    labeltext: "password",
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                width:MediaQuery.of(context).size.width-40,
                height: 50,
                child:
                InkWell(
                    onTap: ()=>authController.registerUser(
                        _usercontroller.text, _emailcontroller.text,
                        _passwordcontroller.text,
                        authController.profilePhoto),
                    child: const  Center(child: Text("sign up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),))),

                decoration: BoxDecoration(
                    color:buttonColor,
                    borderRadius:  BorderRadius.circular(5.0)
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Text("already have an account",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15.0),),
                  InkWell(
                      onTap: (){
                        print("mavigation user");
                      },
                      child: Text("Login",style: TextStyle(fontWeight:FontWeight.w700,color: buttonColor,fontSize: 18.0),)),
                ],
              )
            ],
          ),
        ),
      ),],
      )
    );;
  }
}
