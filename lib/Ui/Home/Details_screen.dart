import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:password_manager/Components/Toast_message.dart';
import 'package:password_manager/Provider/Model_class.dart';
import 'package:password_manager/Provider/Provider_class.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final PasswordEntry entry;
  const DetailsScreen({
    super.key,
    required this.entry,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var isobscure;
  late TextEditingController updatedemailphone;
  late TextEditingController updatedpassword;

  @override
  void initState() {
    super.initState();
    isobscure = false;
    updatedemailphone = TextEditingController(text: widget.entry.emailPhone);
    updatedpassword = TextEditingController(text: widget.entry.password);
  }

  @override
  void dispose() {
    updatedemailphone.dispose();
    updatedpassword.dispose();
    super.dispose();
  }
   Future<void> deleteEntry(BuildContext context, int? entryKey) async {
    if (entryKey == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: Entry key is null!")),
      );
      return;
    }

    var passwordProvider = Provider.of<PasswordProvider>(context, listen: false);
    var box = Hive.box<PasswordEntry>(passwordBoxName);

    await box.delete(entryKey);
    passwordProvider.deletePassword(entryKey);

   //

    Navigator.pop(context);
  }

  Future<void> addPasswordEntry(PasswordEntry newEntry) async {
    var box = Hive.box<PasswordEntry>(passwordBoxName);

    int key = await box.add(newEntry); // Auto-generates a key
    print("Saved entry with key: $key"); // Debugging
  }

  Future<void> Editdetails(BuildContext context, int? entryKey) async {
    if (entryKey == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: Entry key is null!")),
      );
      return;
    }

    var passwordProvider =
        Provider.of<PasswordProvider>(context, listen: false);
    var box = Hive.box<PasswordEntry>(passwordBoxName);

    var entry = box.get(entryKey);

    if (entry == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: Entry not found in Hive!")),
      );
      return;
    }
    // If entry doesn't exist, return early

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 40, 40, 40),
          title: Text(
            'Edit your Details',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      'Username/Email/Phone No',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF7C7C7C),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: updatedemailphone, // Use existing controller
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 76, 75, 75),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(color: Color(0xFF262626))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF262626)),
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter an Email/Phone No!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Text(
                      'Password',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF7C7C7C),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: updatedpassword, // Use existing controller
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 76, 75, 75),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(color: Color(0xFF262626))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF262626)),
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a password!';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  )),
              onPressed: () async {
                if (updatedemailphone.text.isEmpty ||
                    updatedpassword.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Fields cannot be empty!")),
                  );
                  return;
                }

                // Call Provider's update function
                passwordProvider.updatePassword(
                  entryKey,
                  updatedemailphone.text,
                  updatedpassword.text,
                );

                setState(() {
                  widget.entry.emailPhone = updatedemailphone.text;
                  widget.entry.password = updatedpassword.text;
                });

                Navigator.of(context).pop();
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
      backgroundColor: Color(0x5B787880),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          child: SingleChildScrollView(
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
                      widget.entry.appName.toString(),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.29.h,
                        letterSpacing: -0.40,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (widget.entry.key == null ||
                            widget.entry.key is! int) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                              "Error: Entry key is null or invalid! Sorry Go Back This Page An Edit Next Time",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              
                                letterSpacing: -0.40.sp,
                              ),
                            )),
                          );
                          return;
                        }
                        Editdetails(context, widget.entry.key as int);
                      },
                      child: Text(
                        'Edit',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.29.h,
                          letterSpacing: -0.40,
                        ),
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
                        image: AssetImage(widget.entry.appIcon.toString()),
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
                  'Category Type',
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
                    widget.entry.category.toString(),
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
                        widget.entry.emailPhone.toString(),
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
                          FlutterClipboard.copy(
                                  widget.entry.emailPhone.toString())
                              .then(
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
                  'Passwords',
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
                              widget.entry.password.toString(),
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
                          FlutterClipboard.copy(
                                  widget.entry.password.toString())
                              .then(
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
                InkWell(
                  onTap: () {
                  
                 deleteEntry(context, widget.entry.key as int);
                  },
                  child: Row(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
