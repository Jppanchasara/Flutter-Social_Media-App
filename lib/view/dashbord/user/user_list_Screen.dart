import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/View_model/services/session_manage.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view/dashbord/chat/message_Screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  DatabaseReference ref=FirebaseDatabase.instance.ref().child('User');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        centerTitle: true,
      ),
      body: FirebaseAnimatedList(
        query: ref,
         itemBuilder: (context,snapshot,animated,index){
          if(SessionContoller().userId.toString()==snapshot.child('uid').value.toString()){
            return Container();

          }
          else{
            return Card(
            child: ListTile(
              onTap: (){
                PersistentNavBarNavigator.pushNewScreen(context, screen: MessageScrren(
                  name :snapshot.child('username').value.toString(),
                  image:snapshot.child('profile').value.toString() ,
                  email:snapshot.child('email').value.toString() ,
                  recevierId: snapshot.child('uid').value.toString() ,
                  ),withNavBar: false);

              },
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryTextTextColor
                  )
                  
                ),
                child: snapshot.child('profile').value.toString()==''? Icon(Icons.person) : 
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(fit: BoxFit.cover,  image: NetworkImage(snapshot.child('profile').value.toString()))),
              ),
              title: Text(snapshot.child('username').value.toString(),style: Theme.of(context).textTheme.headline6,),
              subtitle: Text(snapshot.child('email').value.toString()),

            ),
          );
         
          }
          })
    );
  }
}