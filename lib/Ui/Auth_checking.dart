import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_manager/Ui/Signup_screen.dart';


class Authchecking extends StatefulWidget {
  const Authchecking({super.key});

  @override
  State<Authchecking> createState() => _AuthcheckingState();
}

class _AuthcheckingState extends State<Authchecking> {
  final LocalAuthentication auth = LocalAuthentication();
  bool isauthenticate=false;
  

  Authbutton()async{
   if (!isauthenticate) {
   try {
      final bool canauthenticateWithBiometrics =await auth.canCheckBiometrics;
    if (canauthenticateWithBiometrics) {
      final bool didauthenticate= await auth.authenticate(localizedReason: 'Please Authenticate open your App',options: AuthenticationOptions(biometricOnly: true));
       setState(() {
      isauthenticate=didauthenticate;
    });
    }
      Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignupScreen()));
   } catch (e) {
     print(e);
   }
   }else{
    setState(() {
      isauthenticate=false;
    });
   }
  }

  checkAuth() async {
    bool isAvailable;
    isAvailable = await auth.canCheckBiometrics;
    print(isAvailable);
    if (isAvailable) {
      bool result = await auth.authenticate(
          localizedReason: 'Scan your fingerprint to proceed',
          options: AuthenticationOptions(biometricOnly: true));
      if (result) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignupScreen()));
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error Occured'),
              content: Text(
                  'Permission Denied'), // Format total price with two decimal places
              actions: [
                TextButton(
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    }else{
                      exit(0);
                    }
                   
                  },
                  child: Text('Close'),
                ),
                 TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Authchecking()));
                  },
                  child: Text('unlouck'),
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
