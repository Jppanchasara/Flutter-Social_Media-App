import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';

import '../services/session_manage.dart';

class SignUpController with ChangeNotifier{
  FirebaseAuth auth=FirebaseAuth.instance;
  DatabaseReference ref=FirebaseDatabase.instance.ref().child("User");
  bool _loading=false;
  bool get loading=> _loading;

  setloading(bool value){
    _loading=value;
    notifyListeners();
  }
  void SignUp(BuildContext context,String email,String password,String userName)async{
    setloading(true);
    try{
      final user= await auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      ).then((value) {
        SessionContoller().userId=value.user!.uid.toString();
        
        ref.child(value.user!.uid.toString(),).set({
           'uid':value.user!.uid.toString(),
           'email':value.user!.email.toString(),
           'phoneNumber': '',
           'username':userName,
           'password':password,
           'emailStats':'noOne',
           'profile':'',


        }).then((value) {
           setloading(false);
           Navigator.pushNamed(context, RouteName.LoginView);
           utils.ToMessage('Registion Scussfully');

        }).onError((error, stackTrace) {
           setloading(false);
          utils.ToMessage(error.toString());

        });

        

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