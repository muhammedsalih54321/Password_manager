import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/Provider/Model_class.dart';
import 'package:provider/provider.dart';

import '../Provider/Provider_class.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({super.key});

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  // List of items
  final search = TextEditingController();
  final appname = TextEditingController();
  final emailphoneno = TextEditingController();
  final password = TextEditingController();
  String? selectedAppName;
  String? selectedAppIcon;
  bool iscreated = false;
  String Dropdownvalue = 'Socials';

  final List<String> Appnames = [
    'Adobe',
    'Airbnb',
    'Alibank',
    'Amazon',
    'Apple',
    'Booking',
    'Bumble',
    'Doulingo',
    'Dropbox',
    'Facebook',
    'Figma',
    'Github',
    'Google Ads',
    'Google Drive',
    'Google',
    'Hotstar',
    'Instagram',
    'Linkedin',
    'Netflix',
    'Snapchat',
    'Spotify',
    'Whatsapp',
    'X',
    'Youtube',
  ];

  final List<String> Appicon = [
    'assets/images/adobe.png',
    'assets/images/airbnb.png',
    'assets/images/alibank.png',
    'assets/images/amazon.png',
    'assets/images/apple.png',
    'assets/images/booking.png',
    'assets/images/bumble.png',
    'assets/images/doulingo.png',
    'assets/images/dropbox.png',
    'assets/images/facebook.png',
    'assets/images/figma.png',
    'assets/images/github.png',
    'assets/images/google_ads.png',
    'assets/images/google_drive.png',
    'assets/images/google.png',
    'assets/images/hotstar.png',
    'assets/images/instagram.png',
    'assets/images/linkedin.png',
    'assets/images/netflix.png',
    'assets/images/snapchat.png',
    'assets/images/spotify.png',
    'assets/images/whatsapp.png',
    'assets/images/x.png',
    'assets/images/youtube.png',
  ];

  // Filtered list based on search query
  List<String> filteredAppnames = [];

  @override
  void initState() {
    super.initState();
    // Initialize filteredAppnames with all items
    filteredAppnames = List.from(Appnames);
    iscreated = false;
  }


  // Function to filter the list based on search query
  void _filterItems(String query) {
    setState(() {
      filteredAppnames = Appnames.where(
          (item) => item.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }
    void _savePassword() {
    if (selectedAppName == null || emailphoneno.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all details'))
      );
      return;
    }

  final passwordData = PasswordEntry(
  appName: selectedAppName==null?appname.text:selectedAppName!,
  emailPhone: emailphoneno.text,
  password: password.text,
  category: Dropdownvalue,
  appIcon: selectedAppIcon!,
);

    Provider.of<PasswordProvider>(context, listen: false).addPassword(passwordData);

   //
    Navigator.pop(context);
  }

  @override
  void dispose() {
    search.clear();
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
          height: iscreated ? 750.h : 700.h,
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
                  SizedBox(height: 30.h),
                  // Search TextFormField
                  Container(
                    width: 342.w,
                    height: 46.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xFFEEF0F2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: TextFormField(
                      onChanged:
                          _filterItems, // Filter the list as the user types
                      textInputAction: TextInputAction.done,
                      controller: search,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          BootstrapIcons.search,
                          size: 20.sp,
                          color: Color(0xFF7C7C7C),
                        ),
                        filled: true,
                        fillColor: Color(0xFF262626),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder:InputBorder.none ,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search Password',
                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xFF7C7C7C),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          height: 0.10.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            iscreated = !iscreated;
                          });
                        },
                        child: Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              BootstrapIcons.plus,
                              color: Color(0xFF0A84FF),
                              size: 30.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // Horizontal ListView for App Icons
                      Container(
                        height: 48.h,
                        width: 290.w,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredAppnames.length,
                          itemBuilder: (context, index) {
                             bool isSelected = selectedAppName == filteredAppnames[index];
                            return Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedAppName = filteredAppnames[index];
                                    selectedAppIcon = Appicon[
                                        Appnames.indexOf(selectedAppName!)];
                                  });
                                },
                                child: Container(
                                  width: 112.w,
                                  height: 47.h,
                                  decoration: ShapeDecoration(
                                    color:isSelected?Color(0xFF0A84FF):Color(0xFFEEF0F2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      filteredAppnames[index],
                                      style: GoogleFonts.poppins(
                                        color:isSelected?Colors.white: Color(0xFF526578),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  iscreated == true
                      ? TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: appname,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF262626),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    BorderSide(color: Color(0xFF262626))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF262626)),
                                borderRadius: BorderRadius.circular(8.r)),
                            hintText: 'Enter Appname/Sitename/Cardname',
                            hintStyle: GoogleFonts.poppins(
                              color: Color(0xFF7C7C7C),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              height: 0.10,
                            ),
                          ),
                          validator: (username) {
                            if (username!.isEmpty) {
                              return 'Enter a username!';
                            }
                            return null;
                          },
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(0xFF262626),
                  ),
                  SizedBox(
                    height: 20.h,
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
                          borderRadius: BorderRadius.circular(8.r)),
                      hintText: 'Enter Username/Email/Phone No  ',
                      hintStyle: GoogleFonts.poppins(
                        color: Color(0xFF7C7C7C),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
                    validator: (password) {
                      if (password!.isEmpty) {
                        return 'Enter a Email/Phone No!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
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
                          borderRadius: BorderRadius.circular(8.r)),
                      hintText: 'Enter password  ',
                      hintStyle: GoogleFonts.poppins(
                        color: Color(0xFF7C7C7C),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
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
                    height: 25.h,
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
                    height: 50.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print(Dropdownvalue);
                          Navigator.pop(context);
                          search.clear();
                          appname.clear();
                          emailphoneno.clear();
                          password.clear();
                        },
                        child: Container(
                          width: 160.w,
                          height: 54.h,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F3772FF),
                                blurRadius: 30.r,
                                offset: Offset(0, 16),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'CANCEL',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5.sp),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                         
                          print(selectedAppIcon);
                          print(selectedAppName);
                           print(appname);
                          print(emailphoneno);
                           print(password);
                          print(Dropdownvalue);
                          _savePassword();
                        },
                        child: Container(
                          width: 160.w,
                          height: 54.h,
                          decoration: ShapeDecoration(
                            color: Color(0xFF0A84FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F3772FF),
                                blurRadius: 30.r,
                                offset: Offset(0, 16),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'SAVE',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5.sp),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}



