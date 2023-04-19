import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tech_media/View_model/services/session_manage.dart';
import 'package:tech_media/utils/utils.dart';

import '../../../res/color.dart';

class MessageScrren extends StatefulWidget {
  final String name,image,email,recevierId;
  const MessageScrren({super.key,
  required this.email,
  required this.recevierId,
  required this.image,
  required this.name});

  @override
  State<MessageScrren> createState() => _MessageScrrenState();
}

class _MessageScrrenState extends State<MessageScrren> {
  final messageController=TextEditingController();
  final DatabaseReference ref=FirebaseDatabase.instance.ref().child('Chat');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
        
      ),
      body: SafeArea(
        child: Column(
          children: [
            Align( alignment: Alignment.bottomRight, child: Text(widget.email.toString())),
            Expanded(child: ListView.builder(itemBuilder: (context,index){
              return Text('');
            })),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextFormField(
                      controller: messageController,
                      cursorColor:Colors.black,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0,fontSize: 19),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.textFieldDefaultFocus),
                            borderRadius: BorderRadius.all(Radius.circular(50))
                    
                          ),
                        hintText: 'Enter Message',
                        contentPadding: const EdgeInsets.all(15),
                        suffixIcon: InkWell(
                          onTap: (){
                            sendMessage();
                          },
                          child:const Padding(

                            padding:  EdgeInsets.only(right: 15),
                            child:  CircleAvatar(
                                  backgroundColor: AppColors.primaryIconColor,
                                  child: Icon(Icons.send,color: Colors.white,),
                                            
                                ),
                          ),
                        )
                      
                      ),
                                
                    ),
                  ),),
                 
                  
                  
                ],
              ),
            )
          ],
        ),
      )
    );
  }
  sendMessage(){
    if(messageController.text.isEmpty){
      utils.ToMessage('Enter Message');
    }
    else{
      final timestmp=DateTime.now().microsecondsSinceEpoch.toString();
      ref.child(timestmp).set({
        'isSeen': false,
        'sender': SessionContoller().userId.toString(),
        'receiver':widget.recevierId,
        'message':messageController.text.toString(),
        'type':'text',


      }).then((value) {
        messageController.clear();
        utils.ToMessage('Send to server');

      }).onError((error, stackTrace) {
        utils.ToMessage(error.toString());

      });
    }
  }
}