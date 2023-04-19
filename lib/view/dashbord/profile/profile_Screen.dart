

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/View_model/profile/profile_controller.dart';
import 'package:tech_media/res/componets/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/View_model/services/session_manage.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view/login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref= FirebaseDatabase.instance.ref('User');
  final auth = FirebaseAuth.instance;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (_)=>ProfileController(),
          child: Consumer<ProfileController>(
            builder: (context,provider,child){
              return SafeArea(
                
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: StreamBuilder(
                    stream: ref.child(SessionContoller().userId.toString()).onValue,
                    builder: (context,AsyncSnapshot snapshot){
              
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator(color:AppColors.primaryTextTextColor ,),);
              
                      }else if(snapshot.hasData){
                        Map<dynamic,dynamic>map=snapshot.data.snapshot.value;
                        
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              
                              SizedBox(
                                height: 20,
                              ),
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  child: Center(
                                    child: Container(
                                      height: 130,
                                      width: 130,
                                      
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.primaryTextTextColor,
                                          width:1
                                        )
                                        
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: provider.image==null? map['profile'].toString()==""? Icon(Icons.person,size: 40,):
                                        Image(
                                          fit: BoxFit.cover ,
                                          image:NetworkImage(
                                              map['profile'].toString()
                                            )
                                        ,loadingBuilder: (context,child,loadingProgress){
                                          if(loadingProgress==null) return child;
                                          return Center(child: CircularProgressIndicator(color: Colors.black,));
                                        },
                                        errorBuilder:(context, error, stack) {
                                          return Container(
                                            child: Center(child: Icon(Icons.error_outline,color: AppColors.alertColor,)),
                                          );
                                        },
                                        ):
                                        Stack(
                                          children: [
                                            Image.file(
                                              File(provider.image!.path).absolute
                                            ),
                                            Center(child: CircularProgressIndicator(color: AppColors.primaryTextTextColor,),)
                                          ],
                                        )
                                        
                                      ),
                                      
                                    ),
                                    
                                  ),
                                ),
                              InkWell(
                                onTap: (){
                                  provider.PickImage(context);
                                  
                                },
                                child: const  CircleAvatar(
                                  radius: 14,
                                  backgroundColor: AppColors.primaryIconColor,
                                  child: Icon(Icons.add,size: 25 ,color: Colors.white,),
                                                  ),
                              ),
                              ]
                              ),
                              
                              
                              GestureDetector(
                                onTap: (){
                                  provider.showUserNameDialogBox(context,map['username']);
                                },
                                child: ReusebalRow(title: 'UserName', value: map['username'], iconData: Icons.person_outlined)),
                              GestureDetector(
                                onTap: (){
                                  provider.showPhoneDialogBox(context,map['phoneNumber'] );
                                },
                                child: ReusebalRow(title: 'Phone', value: map['phoneNumber']==''? 'xxxx-xxx-xxx':map['phoneNumber'], iconData: Icons.phone)),
              
                              ReusebalRow(title: 'Email', value: map['email'], iconData: Icons.email_outlined),
                              SizedBox(height: 80,),
                              RoundButton(onPress: (){
                                FirebaseAuth auth=FirebaseAuth.instance;
                                  auth.signOut().then((value) {
                                    SessionContoller().userId='';
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context, screen: LoginScreen(),
                                      withNavBar: false);
                                  }).onError((error, stackTrace) {
                                    utils.ToMessage(error.toString());
                                  });
      
                              }, title: "Log Out")
                              
                              
                            ],
                          );
                      }
                      else{
                        return Center(child: Text('SomeThing went wrong time',style: Theme.of(context).textTheme.subtitle1,));
              
                      }
                    }
                    )),
              );
          
      
            }
            ),),
      ));
  }
}
class ReusebalRow extends StatelessWidget {
   final String title,value;
   final IconData iconData;
  const ReusebalRow({super.key,
  required this.title,
  required this.value,
  required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            trailing: Text(value,style: Theme.of(context).textTheme.subtitle2,),
            title: Text(title,style: Theme.of(context).textTheme.subtitle1,),
            leading: Icon(iconData),
          ),
        ),
        // Divider(color: AppColors.dividedColor.withOpacity(0.4),)
      ],
    );
  }
}