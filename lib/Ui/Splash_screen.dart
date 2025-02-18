import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:password_manager/Ui/Auth_checking.dart';
import 'package:password_manager/Ui/Onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateotherscreen();
  }

  _navigateotherscreen() async {
    await Future.delayed(Duration(seconds: 3), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey("Token")) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Authchecking()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Onbording()));
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Image.asset('assets/images/img.png',height: 500.h,width: 500.w,fit: BoxFit.cover,),),
    );
  }
}
