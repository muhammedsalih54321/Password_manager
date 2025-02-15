import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_manager/Components/Password_Container.dart';
import 'package:password_manager/Components/Toast_message.dart';
import 'package:password_manager/Components/category_container.dart';
import 'package:password_manager/Components/generate_password.dart';
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

  final generatepasswords = TextEditingController();
  Future<void> _Generatepassword() async {
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
              onTap: () {
                _Generatepassword();
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
                  SizedBox(height: 16.h,),
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
                          color: Colors.white, fontSize: 16),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final passwordEntry = box.getAt(index);
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailsScreen(entry: passwordEntry!),
                          ),
                        );
                      },
                      child: PasswordContainer(
                        image: "${passwordEntry?.appIcon}",
                        title: passwordEntry?.appName ?? '',
                        subtitle: passwordEntry?.emailPhone ?? '', 
                        icon: '',
                        
                      ),
                    );
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
