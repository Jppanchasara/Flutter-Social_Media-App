import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/View_model/SignUp/SignUp_Controller.dart';
import 'package:tech_media/res/componets/input_test_field.dart';
import 'package:tech_media/res/componets/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController=TextEditingController();
  final emailFocusNode=FocusNode();

  final passwordController=TextEditingController();
  final passwordFocusNode=FocusNode();

  final usernameController=TextEditingController();
  final usernameFocusNode=FocusNode();

  final _fromkey=GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    usernameController.dispose();
    usernameFocusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height*0.1;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: ChangeNotifierProvider(
            create: (_)=>SignUpController(),
            child: Consumer<SignUpController>(
              builder: (context,provider,child){
              return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height*0.1,),
                Text('Welcome To App',style: Theme.of(context).textTheme.headline3,),
                SizedBox(height: height*0.1,),
                Text('Enter your email address \n to register your account',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,),
                SizedBox(height: height*0.1,),
                Form(
                  key: _fromkey,
                  child: Padding(
                    padding: EdgeInsets.only(top: height*0.06,bottom: height*0.06),
                    child: Column(
                      children: [
                        InputTextField(
                          myController: usernameController, 
                          focusNode: usernameFocusNode, 
                          
                          onFieldsubmmitedvalue: (value){
                                utils.fieldfocus(context, usernameFocusNode, emailFocusNode);
                          }, 
                          onValidator: (value){
                            return value.isEmpty?'Enter Your UserName':null;
                          },
                          hint: 'UserName',
                          keyBoardType: TextInputType.emailAddress,
                          obscureText: false
                        ),
                        SizedBox(height: height*0.01,),
                        InputTextField(
                          myController: emailController, 
                          focusNode: emailFocusNode, 
                          
                          onFieldsubmmitedvalue: (value){
                            utils.fieldfocus(context, emailFocusNode, passwordFocusNode);
                                  
                          }, 
                          onValidator: (value){
                            return value.isEmpty?'Enter Your Email':null;
                          },
                          hint: 'Email',
                          keyBoardType: TextInputType.emailAddress,
                          obscureText: false
                        ),
                        SizedBox(height: height*0.01,),
                        InputTextField(
                          myController: passwordController, 
                          focusNode: passwordFocusNode, 
                          
                          onFieldsubmmitedvalue: (value){
                                  
                          }, 
                          onValidator: (value){
                            return value.isEmpty?'Enter Your Password':null;
                          },
                          hint: 'Password',
                          keyBoardType: TextInputType.emailAddress,
                          obscureText: true,
                        ),
                  
                      ],
                    ),
                  )
                  ),
                  

                 SizedBox(height: height*0.5,),
                RoundButton(
                  title: "Sign Up",
                  onPress: (){
                    if(_fromkey.currentState!.validate()){
                      provider.SignUp(context,emailController.text, passwordController.text, usernameController.text);

                    }

                  },
                  loading: provider.loading,
                  ),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RouteName.LoginView);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account?  ",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 15),
                
                      children: [
                        TextSpan(
                          text: 'Log In',style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 15,decoration: TextDecoration.underline),
                          
                
                        )
                      ]
                    )
                  ),
                )
                
                
              ],

            ),
          );
        
            }),
          )
          ),
      ),
    );
  }
}