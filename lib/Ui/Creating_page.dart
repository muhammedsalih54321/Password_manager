import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/Components/Toast_message.dart';
import 'package:password_manager/Components/generate_password.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({super.key});

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  // List of items
  final search = TextEditingController();
  final username = TextEditingController();
  final emailphoneno = TextEditingController();
  final password = TextEditingController();
  final generatepasswords = TextEditingController();

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
  }

  // Function to filter the list based on search query
  void _filterItems(String query) {
    setState(() {
      filteredAppnames = Appnames.where(
          (item) => item.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  Future<void> _showMyDialog() async {
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
          content: SingleChildScrollView(
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
                        borderRadius: BorderRadius.circular(8.r)),
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
          ),
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
    search.clear();
    username.clear();
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
          height: 750.h,
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
                      Container(
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
                      SizedBox(width: 12.w),
                      // Horizontal ListView for App Icons
                      Container(
                        height: 48.h,
                        width: 290.w,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredAppnames.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: Container(
                                width: 112.w,
                                height: 47.h,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFEEF0F2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    filteredAppnames[index],
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF526578),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
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
                  SizedBox(height: 26.h),
                  Divider(
                    thickness: 1,
                    color: Color(0xFF262626),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Username',
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
                    controller: username,
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
                      hintText: 'Enter Username  ',
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
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Email/phone No',
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
                      hintText: 'Enter Email/Phone No  ',
                      hintStyle: GoogleFonts.poppins(
                        color: Color(0xFF7C7C7C),
                        fontSize: 14.sp,
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
                        fontSize: 14.sp,
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
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Generate your Password',
                        style: TextStyle(
                          color: Color(0xFF7C7C7C),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showMyDialog();
                        },
                        child: Container(
                          width: 180.w,
                          height: 47.h,
                          decoration: ShapeDecoration(
                            color: Color(0xFFEEF0F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Password Generator',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                          print('clicked');
                          Navigator.pop(context);
                          search.clear();
                          username.clear();
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
                      Container(
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
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
