// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_tok/constants.dart';
import 'package:tik_tok/views/Widgets/text_input_field.dart';
import 'package:tik_tok/views/screens/auth/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);



  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            Text("Tiktok",style: TextStyle(fontSize: 35,color:buttonColor,fontWeight: FontWeight.w900,),),
              const Text("Login",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,),),
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
                      onTap: ()=>authController.loginUser(_emailcontroller.text, _passwordcontroller.text),
                     child: const  Center(child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),))),

                decoration: BoxDecoration(
                  color:buttonColor,
                  borderRadius:  BorderRadius.circular(5.0)
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Text("dont have an account",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15.0),),
                  InkWell(
                    onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpScreen()));
                    },
                      child: Text("Register",style: TextStyle(fontWeight:FontWeight.w700,color: buttonColor,fontSize: 18.0),)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
