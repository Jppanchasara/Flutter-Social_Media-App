
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/View_model/services/session_manage.dart';
import 'package:tech_media/res/color.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:tech_media/res/componets/input_test_field.dart';
import 'package:tech_media/utils/utils.dart';

class ProfileController with ChangeNotifier{
  final nameController =TextEditingController();
  final namelFocusNode=FocusNode();

  final phoneController =TextEditingController();
  final phoneFocusNode=FocusNode();

  DatabaseReference ref=FirebaseDatabase.instance.ref(  ).child('User');
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;

   bool _loading=false;
  bool get loading=> _loading;

  setloading(bool value){
    _loading=value;
    notifyListeners();
  }
  final picker=ImagePicker();

  XFile? _image;
  XFile? get image=>_image;
  
  Future pickGalleryImage(BuildContext context)async{
    final PickedFile=await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);
    if(PickedFile!=null){
      _image=XFile(PickedFile.path);
      ImageUpload(context);
      notifyListeners();
    }
  }
  Future pickCameraImage(BuildContext context)async{
    final PickedFile=await picker.pickImage(source: ImageSource.camera,imageQuality: 100);
    if(PickedFile!=null){
      _image=XFile(PickedFile.path);
      ImageUpload(context);
      notifyListeners();
    }
  }


  void PickImage(context){
    showDialog(
      context: context,
       builder:(BuildContext context){
        return AlertDialog(
          content: Container(
            height: 130,
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    onTap: (){
                      pickGalleryImage(context);
                
                    },
                    leading: Icon(Icons.image,color: AppColors.primaryIconColor,),
                    title: Text('Gallery'),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: (){
                      pickCameraImage(context);
                
                    },
                    leading: Icon(Icons.camera,color: AppColors.primaryIconColor,),
                    title: Text('Camera'),
                  ),
                )
              ],
            ),
          ),

        );
       }
    );
  }
  void ImageUpload(BuildContext context)async{
    setloading(true);
    firebase_storage.Reference storageRef=firebase_storage.FirebaseStorage.instance.ref('/profileImage'+SessionContoller().userId.toString());
    firebase_storage.UploadTask uploadTask=storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl=await storageRef.getDownloadURL();
    ref.child(SessionContoller().userId.toString()).update({
      'profile':newUrl
    }).then((value) {
      utils.ToMessage('Profile Image Update');
      setloading(false);
      _image=null;

    }).onError((error, stackTrace) {
      utils.ToMessage(error.toString());
      setloading(false);
    });
  }

  Future<void>showUserNameDialogBox(BuildContext context,String name){
    nameController.text=name;
    return showDialog(context: context,
     builder: (context){
      return AlertDialog(
        title: Center(child: Text('Update UserName'),),
        content: SingleChildScrollView(
          child: Column(
            children: [
              InputTextField(
                myController: nameController, 
                focusNode: namelFocusNode, 
                onFieldsubmmitedvalue: (value){

                }, 
                onValidator: (value){
                  
                }, 
                hint: "Enter name",
                keyBoardType: TextInputType.name,
                obscureText: false)
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel',style: Theme.of(context).textTheme.subtitle2,)),
          TextButton(onPressed: (){
            ref.child(SessionContoller().userId.toString()).update({
              'username':nameController.text.toString(),

            }).then((value) {
              utils.ToMessage('Update UserName');

            }).onError((error, stackTrace) {
              nameController.clear();
              utils.ToMessage(error.toString());

            });
             Navigator.pop(context);
          }, child: Text('Ok',style: Theme.of(context).textTheme.subtitle2,)),

        ],

      );
    });
  }

Future<void>showPhoneDialogBox(BuildContext context,String phone){
    phoneController.text=phone;
    return showDialog(context: context,
     builder: (context){
      return AlertDialog(
        title: Center(child: Text('Update UserName'),),
        content: SingleChildScrollView(
          child: Column(
            children: [
              InputTextField(
                myController: phoneController, 
                focusNode: phoneFocusNode, 
                onFieldsubmmitedvalue: (value){

                }, 
                onValidator: (value){
                  
                }, 
                hint: "Enter PhoneNumber",
                keyBoardType: TextInputType.number,
                obscureText: false)
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel',style: Theme.of(context).textTheme.subtitle2,)),
          TextButton(onPressed: (){
            ref.child(SessionContoller().userId.toString()).update({
              'phoneNumber':phoneController.text.toString(),

            }).then((value) {
              utils.ToMessage('Update PhoneNumber');

            }).onError((error, stackTrace) {
              nameController.clear();
              utils.ToMessage(error.toString());

            });
             Navigator.pop(context);
          }, child: Text('Ok',style: Theme.of(context).textTheme.subtitle2,)),

        ],

      );
    });
  }

}