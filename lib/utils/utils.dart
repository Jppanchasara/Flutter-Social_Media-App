import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class utils{
  static void fieldfocus(BuildContext context,FocusNode currentNode,FocusNode nextNode){
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
    
  }
  static ToMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }
}