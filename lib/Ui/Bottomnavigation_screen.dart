import 'dart:ui';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/Ui/Creating_page.dart';
import 'package:password_manager/Ui/Home/Home_screen.dart';
import 'package:password_manager/Ui/Search_screen.dart';

class BottomnavigationScreen extends StatefulWidget {
  const BottomnavigationScreen({super.key});

  @override
  State<BottomnavigationScreen> createState() => _BottomnavigationScreenState();
}

class _BottomnavigationScreenState extends State<BottomnavigationScreen> {
  final screen = [
    HomeScreen(),
    SearchScreen(),
  ];
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Color(0xFF1E1E1E),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              iconSize: 25.sp,
              // ignore: deprecated_member_use
              backgroundColor: Colors.black.withOpacity(0.10000000149011612),
              selectedItemColor: Color(0xFF0A84FF),
              showUnselectedLabels: true,
              unselectedItemColor: Color(0xFF616161),
              selectedLabelStyle: GoogleFonts.poppins(
                color: Color(0xFF0A84FF),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 0,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                  color: Color(0xFF616161),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  height: 0),
              currentIndex: currentindex,
              onTap: (index) {
                setState(() {
                  currentindex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    BootstrapIcons.house,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      BootstrapIcons.search,
                    ),
                    label: 'Search'),
              ]),
        ),
      ),
      // ),
      body: screen[currentindex],
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
            shape: CircleBorder(),
            backgroundColor: Colors.white,
            hoverElevation: 10,
            splashColor: const Color.fromARGB(255, 215, 230, 243),
            tooltip: 'Add',
            elevation: 4,
            child: Icon(
              BootstrapIcons.plus,
              color: Color(0xFF0A84FF),
              size: 30.sp,
            ),
            onPressed: () {
              showModalBottomSheet(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r))),
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return SearchBottomSheet();
                    });
                  });
            }),
      ),
    );
  }
}
