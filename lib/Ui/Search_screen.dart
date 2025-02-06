import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/Components/Password_Container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          'Password manager',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 25.sp,
            fontWeight: FontWeight.w500,
            height: -0.1,
            letterSpacing: -0.40.sp,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Icon(
              BootstrapIcons.plus_circle,
              color: Color(0xFF0A84FF),
              size: 24.sp,
            ),
          )
        ],
        bottom: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Container(
            width: 361.w,
            height: 40.h,
            decoration: ShapeDecoration(
              color: Color(0x3D787880),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              controller: Search,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    BootstrapIcons.search,
                    size: 20.sp,
                    color: Color(0xFF7C7C7C),
                  ),
                  fillColor: Color(0x3D787880),
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: InputBorder.none,
                  hintText: 'Search Password',
                  hintStyle: GoogleFonts.poppins(
                    color: Color(0xFF7C7C7C),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 0.10.h,
                  )),
              validator: (email) {
                if (email!.isEmpty) {
                  return 'Search something';
                }
                return null;
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return PasswordContainer(
              image: "assets/images/adobe.png",
              title: 'Adobe',
              subtitle: 'jane.smith@email.com');
        },
      ),
    );
  }
}
