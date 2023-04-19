


import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/View_model/services/session_manage.dart';
import 'package:tech_media/utils/routes/route_name.dart';
class SplashServices{
  void isLogin(BuildContext context){

    FirebaseAuth auth=FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user !=null){
      SessionContoller().userId=user.uid.toString();
     
      Timer(Duration(seconds: 10),()=> Navigator.pushNamed(context, RouteName.DashBordView));


    }else{
      Timer(Duration(seconds:10),()=> Navigator.pushNamed(context, RouteName.LoginView));


    }
  }
    

}