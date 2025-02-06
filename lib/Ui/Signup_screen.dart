import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/Ui/Bottomnavigation_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final Username = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isobscure;
  bool ischecked = false;
  @override
  void initState() {
    isobscure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 239.h,
            ),
            Container(
              width: double.infinity,
              height: 491.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(38.r),
                    topRight: Radius.circular(38.r)),
                border: Border(top: BorderSide(color: Colors.white)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 70.h,
                        ),
                        Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            color: Color(0xFFFAFAFA),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            height: 0.07,
                          ),
                        ),
                        Text(
                          'Enter your user name to login for this app',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF616161),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            height: 4,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: Username,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF262626),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide:
                                      BorderSide(color: Color(0xFF262626))),
                              focusedBorder: InputBorder.none,
                              labelText: 'User Name',
                              labelStyle: GoogleFonts.poppins(
                                color: Color(0xFF7C7C7C),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                height: 0.10.h,
                              )),
                          validator: (email) {
                            if (email!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email)) {
                              return 'Enter a valid email!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          controller: password,
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
                              labelText: 'Enter password  ',
                              labelStyle: GoogleFonts.poppins(
                                color: Color(0xFF7C7C7C),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isobscure = !isobscure;
                                    });
                                  },
                                  icon: isobscure
                                      ? Icon(
                                          BootstrapIcons.eye,
                                          color: Colors.white,
                                          size: 20.sp,
                                        )
                                      : Icon(
                                          BootstrapIcons.eye_slash,
                                          color: Colors.white,
                                          size: 20.sp,
                                        ))),
                          obscureText: isobscure,
                          validator: (password) {
                            if (password!.isEmpty || password.length < 6) {
                              return 'Enter a valid password!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'forget password',
                              style: GoogleFonts.poppins(
                                color: Color(0xFF7C7C7C),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                height: 0.12,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BottomnavigationScreen()));
                          },
                          child: Container(
                            height: 50.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Color(0xFF0A84FF)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Login',
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 0.10),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Icon(
                                    BootstrapIcons.arrow_right,
                                    color: Colors.white,
                                    size: 20.sp,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // void token(String token) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('Token', token);
  // }
}
