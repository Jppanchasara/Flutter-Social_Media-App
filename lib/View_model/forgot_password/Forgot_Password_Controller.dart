import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/utils.dart';

import '../../utils/routes/route_name.dart';
import '../services/session_manage.dart';

class ForgotPasswordController with ChangeNotifier{
  FirebaseAuth auth=FirebaseAuth.instance;
  bool _loading=false;
  bool get loading=> _loading;

  setloading(bool value){
    _loading=value;
    notifyListeners();
  }
  void forgotpassword(BuildContext context,String email,){
    setloading(true);
    try{
       auth.sendPasswordResetEmail(
        email: email, 
        
      ).then((value) { 
        setloading(false);
           Navigator.pushNamed(context, RouteName.LoginView);
           utils.ToMessage('Please check your email to recover your password');

      }).onError((error, stackTrace) {
        setloading(false);
        utils.ToMessage(error.toString());
      });


    }catch(e){
        setloading(false);
      utils.ToMessage(e.toString());
    }

  }
  
}