import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_manager/Ui/Bottomnavigation_screen.dart';

class Authchecking extends StatefulWidget {
  const Authchecking({super.key});

  @override
  State<Authchecking> createState() => _AuthcheckingState();
}

class _AuthcheckingState extends State<Authchecking> {
  final LocalAuthentication auth = LocalAuthentication();
  bool isauthenticate = false;
  checkAuth() async {
    bool isAvailable;
    isAvailable = await auth.canCheckBiometrics;
    print(isAvailable);
    if (isAvailable) {
      bool result = await auth.authenticate(
          localizedReason: 'Scan your fingerprint to proceed',
          options: AuthenticationOptions(biometricOnly: true));
      if (result) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BottomnavigationScreen()));
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color.fromARGB(255, 40, 40, 40),
              title: Column(
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xFF0A84FF),
                    size: 30.sp,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Password Manager is Locked',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              content: Text('For Your security Please unlock The app and Use',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  )), // Format total price with two decimal places
              actions: [
                TextButton(
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else {
                      exit(0);
                    }
                  },
                  child: Text('Close',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF0A84FF),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Authchecking()));
                  },
                  child: Text('Unlock',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF0A84FF),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ],
            );
          },
        );
      }
    } else {
      print("No biometric detected");
    }
  }

  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
    );
  }
}
