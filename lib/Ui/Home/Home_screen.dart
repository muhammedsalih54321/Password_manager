import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/Components/Password_Container.dart';
import 'package:password_manager/Ui/Home/Details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            child: InkWell(
              onTap: () {},
              child: Icon(
                BootstrapIcons.plus_circle,
                color: Color(0xFF0A84FF),
                size: 24.sp,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(38.r),
                  bottomRight: Radius.circular(38.r)),
              border: Border(bottom: BorderSide(color: Colors.white)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 136.w,
                    height: 100.h,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Manage',
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your passwords',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    height: 124.h,
                    width: double.infinity.w,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: 24.w,
                          ),
                          child: Container(
                            width: 100.w,
                            height: 124.h,
                            decoration: ShapeDecoration(
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: .5.w, color: Colors.white),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 16.h,
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 215, 230, 243),
                                  radius: 23.r,
                                  child: Center(
                                    child: Icon(
                                      Icons.people_outline,
                                      color: Color(0xFF0A84FF),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  'Socials',
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
                                Text(
                                  '10 passwords',
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF8F8F8F),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.20.sp,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DetailsScreen()));
                  },
                  child: PasswordContainer(
                      image: "assets/images/adobe.png",
                      title: 'Adobe',
                      subtitle: 'jane.smith@email.com'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
