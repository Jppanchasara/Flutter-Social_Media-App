import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/View_model/services/session_manage.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view/dashbord/profile/profile_Screen.dart';
import 'package:tech_media/view/dashbord/user/user_list_Screen.dart';

class DashBordScreen extends StatefulWidget {
  const DashBordScreen({super.key});

  @override
  State<DashBordScreen> createState() => _DashBordScreenState();
}

class _DashBordScreenState extends State<DashBordScreen> {
  List<Widget> _buildScreen(){
    return [
      Center(child: Text('home')),
      Center(child: Text('message')),
      Center(child: Text('add')),
      UserListScreen(),
      ProfileScreen(),
    ];
  }
  List<PersistentBottomNavBarItem> _navItem(){
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        activeColorPrimary: AppColors.primaryTextTextColor,
        inactiveIcon: Icon(Icons.home,color:Colors.grey.shade100)
        ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message,),
        activeColorPrimary: AppColors.primaryTextTextColor,
        inactiveIcon: Icon(Icons.message,color:Colors.grey.shade100,)
        ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add,color: Colors.white,),
        activeColorPrimary: AppColors.primaryTextTextColor,
        inactiveIcon: Icon(Icons.add,color:Colors.grey.shade100,)
        ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.chat,),
        activeColorPrimary: AppColors.primaryTextTextColor,
        inactiveIcon: Icon(Icons.chat,color:Colors.grey.shade100,)),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person,),
        activeColorPrimary: AppColors.primaryTextTextColor,
        inactiveIcon: Icon(Icons.person,color:Colors.grey.shade100,)),
    ];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: PersistentTabView(
      context, 
      screens: _buildScreen(),
      items: _navItem(),
      backgroundColor: Colors.grey.shade400,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(2)
      ),
      navBarStyle: NavBarStyle.style15,
      ),
    )
    ;
     
  }
}

