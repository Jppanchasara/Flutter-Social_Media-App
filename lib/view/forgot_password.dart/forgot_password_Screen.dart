import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/View_model/LogIn/Login_Controller.dart';
import 'package:tech_media/res/componets/input_test_field.dart';
import 'package:tech_media/res/componets/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';

import '../../View_model/forgot_password/Forgot_Password_Controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController=TextEditingController();
  final emailFocusNode=FocusNode();
  final _fromkey=GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height*0.1;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*0.1,),
              Text('Forgot Password',style: Theme.of(context).textTheme.headline3,),
              SizedBox(height: height*0.01,),
              Text('Enter your email address \n to recover your account',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,),
              SizedBox(height: height*0.2,),
              Form(
                key: _fromkey,
                child: Padding(
                  padding: EdgeInsets.only(top: height*0.06,bottom: height*0.06),
                  child: Column(
                    children: [
                      InputTextField(
                        
                        myController: emailController, 
                        focusNode: emailFocusNode, 
                        
                        onFieldsubmmitedvalue: (value){
                          
                                
                        }, 
                        onValidator: (value){
                          return value.isEmpty?'Enter Your Email':null;
                        },
                        hint: 'Email',
                        keyBoardType: TextInputType.emailAddress,
                        obscureText: false
                      ),
                      SizedBox(height: height*0.01,),
                      
                    ],
                  ),
                )
                ),
                

               SizedBox(height: height*0.5,),
               ChangeNotifierProvider(
                create: (_)=>ForgotPasswordController(),
                child: Consumer<ForgotPasswordController>(
                  builder: (context,provider,child){
                  return RoundButton(title: "Recover",
                  onPress: (){
                    if(_fromkey.currentState!.validate()){
                      provider.forgotpassword(context,emailController.text);

                    }
                  },
                  loading: provider.loading,
                  );
                }),
               ),
              
            ],

          ),
        ),
      ),
    );
  }
}