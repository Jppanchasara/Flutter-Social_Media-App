import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tech_media/View_model/services/splash_services.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:lottie/lottie.dart';
import '../../res/color.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices services=SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    services.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Lottie.asset('assets/images/name.json'),
             
               Padding(
                padding:  EdgeInsets.symmetric(vertical: 20),
                child: Center(child: Lottie.asset('assets/images/logo.json'),)),
            
              
            ],
          )
      ),
    );
  }
}
