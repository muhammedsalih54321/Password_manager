import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/Components/Toast_message.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var isobscure;

  @override
  void initState() {
    isobscure = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x5B787880),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      BootstrapIcons.x_circle_fill,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Github',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.29.h,
                      letterSpacing: -0.40,
                    ),
                  ),
                  Text(
                    'Edit',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.29.h,
                      letterSpacing: -0.40,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60.h,
              ),
              Center(
                child: Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/adobe.png"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21.82.r),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              Text(
                'Username',
                style: GoogleFonts.poppins(
                  color: Color(0x99EBEBF5),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.33.h,
                  letterSpacing: -0.40.sp,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 230.w,
                child: Text(
                  'jane smith',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.29.h,
                    letterSpacing: -0.40.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Email/phoneNo',
                style: GoogleFonts.poppins(
                  color: Color(0x99EBEBF5),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.33.h,
                  letterSpacing: -0.40.sp,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 230.w,
                    child: Text(
                      'jane.smith@email.com',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.29.h,
                        letterSpacing: -0.40.sp,
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        FlutterClipboard.copy('jane.smith@email.com').then(
                          (value) {
                            ToastMessage().toastmessage(message: 'Copied');
                          },
                        );
                      },
                      child: Icon(
                        BootstrapIcons.copy,
                        color: Colors.white,
                      ))
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Password',
                style: GoogleFonts.poppins(
                  color: Color(0x99EBEBF5),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.33.h,
                  letterSpacing: -0.40.sp,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250.w,
                    child: isobscure
                        ? Text(
                            'jane123',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.29.h,
                              letterSpacing: -0.40.sp,
                            ),
                          )
                        : Text(
                            '********',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.29.h,
                              letterSpacing: -0.40.sp,
                            ),
                          ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          isobscure = !isobscure;
                        });
                      },
                      child: isobscure
                          ? Icon(
                              BootstrapIcons.eye,
                              color: Colors.white,
                              size: 20.sp,
                            )
                          : Icon(
                              BootstrapIcons.eye_slash,
                              color: Colors.white,
                              size: 20.sp,
                            )),
                  InkWell(
                      onTap: () {
                        FlutterClipboard.copy('jane123').then(
                          (value) {
                            ToastMessage().toastmessage(message: 'Copied');
                          },
                        );
                      },
                      child: Icon(
                        BootstrapIcons.copy,
                        color: Colors.white,
                      ))
                ],
              ),
              Text(
                'Strong',
                style: GoogleFonts.poppins(
                  color: Color(0xFF30D158),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.33.h,
                  letterSpacing: -0.40.sp,
                ),
              ),
              SizedBox(
                height: 150.h,
              ),
              Row(
                children: [
                  Icon(
                    BootstrapIcons.star,
                    color: Color(0xFF0A84FF),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Text(
                    'Add to Favorites',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF0A84FF),
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.29.h,
                      letterSpacing: -0.40.sp,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Icon(
                    BootstrapIcons.trash3,
                    color: Color(0xFFFF453A),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Text(
                    'Delete',
                    style: GoogleFonts.poppins(
                      color: Color(0xFFFF453A),
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.29.h,
                      letterSpacing: -0.40.sp,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
