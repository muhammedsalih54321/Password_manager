import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/Components/Buttons.dart';
import 'package:password_manager/Components/generate_password.dart';
import 'package:password_manager/Provider/Model_class.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../Provider/Provider_class.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({super.key});

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  // List of items

  final appname = TextEditingController();
  final emailphoneno = TextEditingController();
  final password = TextEditingController();

  bool iscreated = false;
  String Dropdownvalue = 'Socials';
  String? appIconUrl;

  void _fetchAppIcon(String appName) async {
    final String apiUrl =
        'https://logo.clearbit.com/${appName.toLowerCase().replaceAll('', '')}.com';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        appIconUrl = apiUrl;
      });
    } else {
      setState(() {
        appIconUrl = null;
      });
    }
  }

  void _savePassword() {
    if (appname.text.isEmpty ||
        emailphoneno.text.isEmpty ||
        password.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill in all details')));
      return;
    }

    final passwordData = PasswordEntry(
      appName: appname.text,
      emailPhone: emailphoneno.text,
      password: password.text,
      category: Dropdownvalue,
      appIcon: appIconUrl ?? '',
    );

    Provider.of<PasswordProvider>(context, listen: false)
        .addPassword(passwordData);

    //
    Navigator.pop(context);
  }
  final generatepasswords = TextEditingController();
  Future<void> _Generatepassword() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 40, 40, 40),
          title: Text(
            'Generate your Password',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Generate(),
          actions: <Widget>[
            TextButton(
              child: Text('Cancle',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
                generatepasswords.clear();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    appname.clear();
    emailphoneno.clear();
    password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            color: Color(0xFF111111),
          ),
          width: double.infinity.w,
          height: 730.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  Container(
                    width: 120.w,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10.r),
                          right: Radius.circular(10.r),
                        ),
                        side: BorderSide(
                          width: 2.w,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFBAC1C9),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  // Search TextFormField
                  Row(
                    children: [
                      Text(
                        'Appname',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF7C7C7C),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: appname,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF262626),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Color(0xFF262626))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF262626)),
                          borderRadius: BorderRadius.circular(10.r)),
                      hintText: 'Enter Appname',
                      hintStyle: GoogleFonts.poppins(
                        color: Color(0xFF7C7C7C),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        height: 0.10.h,
                      ),
                    ),
                    validator: (appname) {
                      if (appname!.isEmpty) {
                        return 'Enter Your appname';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        _fetchAppIcon(value);
                      }
                    },
                  ),
                  SizedBox(
                    height: 24.h,
                  ),

                  Row(
                    children: [
                      Text(
                        'Username/Email/phone No',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF7C7C7C),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: emailphoneno,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF262626),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Color(0xFF262626))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF262626)),
                          borderRadius: BorderRadius.circular(10.r)),
                      hintText: 'Enter Username/Email/Phone No  ',
                      hintStyle: GoogleFonts.poppins(
                        color: Color(0xFF7C7C7C),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        height: 0.10.h,
                      ),
                    ),
                    validator: (email) {
                      if (email!.isEmpty) {
                        return 'Enter a Email/Phone No!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Password',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF7C7C7C),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: password,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF262626),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Color(0xFF262626))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF262626)),
                          borderRadius: BorderRadius.circular(10.r)),
                      hintText: 'Enter password  ',
                      hintStyle: GoogleFonts.poppins(
                        color: Color(0xFF7C7C7C),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        height: 0.10.h,
                      ),
                    ),
                    validator: (password) {
                      if (password!.isEmpty) {
                        return 'Enter a password!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select App Categories',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF7C7C7C),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                          width: 150.w,
                          height: 47.h,
                          decoration: ShapeDecoration(
                            color: Color(0xFFEEF0F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: Center(
                            child: DropdownButton<String>(
                              value: Dropdownvalue,
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.black,
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: 'Socials',
                                  child: Text(
                                    'Socials',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Apps',
                                  child: Text(
                                    'Apps',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Wallets',
                                  child: Text(
                                    'Wallets',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                              onChanged: (value) {
                                setState(() {
                                  Dropdownvalue = value!;
                                });
                              },
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  InkWell(
                    onTap: () {
                      _Generatepassword();
                    },
                    child: Container(
                      width: 250.w,
                      height: 50.h,
                      decoration: ShapeDecoration(
                        color: Color(0xFFEEF0F2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Generate Your Password',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(BootstrapIcons.arrow_clockwise)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            appname.clear();
                            emailphoneno.clear();
                            password.clear();
                          },
                          child: Buttons(
                              color: Colors.white,
                              textcolor: Colors.black,
                              text: 'CANCEL')),
                      InkWell(
                          onTap: () {
                            _savePassword();
                          },
                          child: Buttons(
                              color: Color(0xFF0A84FF),
                              textcolor: Colors.white,
                              text: 'SAVE')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
