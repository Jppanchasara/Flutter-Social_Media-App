import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/utils.dart';

import '../../utils/routes/route_name.dart';
import '../services/session_manage.dart';

class LoginController with ChangeNotifier{
  FirebaseAuth auth=FirebaseAuth.instance;
  bool _loading=false;
  bool get loading=> _loading;

  setloading(bool value){
    _loading=value;
    notifyListeners();
  }
  void LogIn(BuildContext context,String email,String password,){
    setloading(true);
    try{
       auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      ).then((value) {
        SessionContoller().userId=value.user!.uid.toString();
        
        setloading(false);
           Navigator.pushNamed(context, RouteName.DashBordView);
           utils.ToMessage('Login Scussfully');

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