import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryContainer extends StatelessWidget {
  final Icon icon;
  final String title;
 
  const CategoryContainer({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 120.h,
      decoration: ShapeDecoration(
        color: Color(0xFF111111),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: .5.w, color: Colors.white),
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 215, 230, 243),
            radius: 23.r,
            child: Center(
              child: icon
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.20.sp,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
         
        ],
      ),
    );
  }
}
