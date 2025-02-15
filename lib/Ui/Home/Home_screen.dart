import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_manager/Components/category_container.dart';
import 'package:password_manager/Provider/Model_class.dart';
import 'package:password_manager/Ui/Home/Details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<PasswordEntry> passwordBox;

  @override
  void initState() {
    super.initState();
    passwordBox = Hive.box<PasswordEntry>('passwordBox');
  }

  

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
            height: -0.1.h,
            letterSpacing: -0.40.sp,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: InkWell(
              onTap: () {
              
              },
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
                    height: 25.h,
                  ),
                  SizedBox(
                    width: 250.w,
                    child: Text(
                      'What do you want to save?',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryContainer(
                        icon: Icon(
                          Icons.people_outline,
                          color: Color(0xFF0A84FF),
                        ),
                        title: 'Social',
                      ),
                      CategoryContainer(
                        icon: Icon(
                          BootstrapIcons.app,
                          color: Color(0xFF0A84FF),
                        ),
                        title: 'Apps',
                      ),
                      CategoryContainer(
                        icon: Icon(
                          Icons.wallet,
                          color: Color(0xFF0A84FF),
                        ),
                        title: 'Wallet',
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: passwordBox.listenable(),
              builder: (context, Box<PasswordEntry> box, _) {
                if (box.isEmpty) {
                  return Center(
                    child: Text(
                      'No passwords saved!',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 16.sp),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final passwordEntry = box.getAt(index);
                    return ListTile(
                      onTap: () {
                         Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DetailsScreen(entry: passwordEntry!),
                        ));
                      },
                        leading: Container(
                          width: 44.w,
                          height: 44.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[
                                800], // Background color if image fails
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: passwordEntry?.appIcon != null &&
                                    passwordEntry!.appIcon.isNotEmpty
                                ? Image.network(
                                    passwordEntry.appIcon,
                                    fit: BoxFit
                                        .cover, // Ensures the image fills the container properly
                                    errorBuilder:
                                        (context, error, stackTrace) {
                                      return Center(
                                        child: Text(
                                          passwordEntry.appName.isNotEmpty
                                              ? passwordEntry.appName[0]
                                                  .toUpperCase()
                                              : '?',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text(
                                      passwordEntry?.appName.isNotEmpty ==
                                              true
                                          ? passwordEntry!.appName[0]
                                              .toUpperCase()
                                          : '?',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        title: Text(
                          passwordEntry?.appName ?? '',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.29.h,
                            letterSpacing: -0.40.sp,
                          ),
                        ),
                        subtitle: Text(
                          passwordEntry?.emailPhone ?? '',
                          style: GoogleFonts.poppins(
                            color: Color(0x99EBEBF5),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.33.h,
                            letterSpacing: -0.40.sp,
                          ),
                        ));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
