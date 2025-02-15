import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Buttons extends StatelessWidget {
  final Color color;
  final Color textcolor;
  final String text;
  const Buttons({
    super.key,
    required this.color,
    required this.textcolor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 54.h,
      decoration: ShapeDecoration(
        color: color,
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
          text,
          style: GoogleFonts.poppins(
              color: textcolor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5.sp),
        ),
      ),
    );
  }
}
