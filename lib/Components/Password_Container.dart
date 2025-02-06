import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordContainer extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const PasswordContainer(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
          width: 44.w,
          height: 44.h,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            height: 1.29.h,
            letterSpacing: -0.40.sp,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            color: Color(0x99EBEBF5),
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            height: 1.33.h,
            letterSpacing: -0.40.sp,
          ),
        ));
  }
}
