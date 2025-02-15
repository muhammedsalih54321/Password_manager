import 'dart:math';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/Components/Toast_message.dart';

String generatepassword() {
  String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String lower = 'abcdefghijklmnopqrstuvwxyz';
  String number = '12345678910';
  String symbols = '!@#\$%^&*()<>,./';
  String password = '';

  int passwordlngt = 12;

  String seed = upper + lower + number + symbols;

  List<String> list = seed.split('').toList();
  Random random = Random();

  for (int i = 0; i < passwordlngt; i++) {
    int index = random.nextInt(list.length);
    password += list[index];
  }
  return password;
}


//generate content


class Generate extends StatefulWidget {
  
  const Generate({super.key});

  @override
  State<Generate> createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  final generatepasswords = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: generatepasswords,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        FlutterClipboard.copy(generatepasswords.text).then(
                          (value) {
                            ToastMessage().toastmessage(message: 'Copied');
                          },
                        );
                      },
                      child: Icon(
                        BootstrapIcons.copy,
                        color: Colors.white,
                      ),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 76, 75, 75),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Color(0xFF262626))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF262626)),
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  validator: (generatepaasword) {
                    if (generatepaasword!.isEmpty) {
                      return 'Enter a username!';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'You want refresh',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    InkWell(
                      onTap: () {
                        final passwords = generatepassword();
                        generatepasswords.text = passwords;
                      },
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            BootstrapIcons.arrow_clockwise,
                            color: Color(0xFF0A84FF),
                            size: 30.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
    
    
   


  }
}

  