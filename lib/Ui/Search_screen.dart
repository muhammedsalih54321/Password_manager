import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/Provider/Provider_class.dart';
import 'package:password_manager/Ui/Home/Details_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Search = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List filteredPasswords = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final passwordProvider =
        Provider.of<PasswordProvider>(context, listen: false);
    final query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredPasswords =
            passwordProvider.passwords; // Show all when search is empty
      } else {
        filteredPasswords = passwordProvider.passwords.where((entry) {
          return entry.appName.toLowerCase().contains(query) ||
              entry.emailPhone.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordProvider = Provider.of<PasswordProvider>(context);
    final passwords = passwordProvider.passwords;

    // Initialize the list with all passwords if empty
    if (filteredPasswords.isEmpty) {
      filteredPasswords = passwords;
    }

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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Color(0xFF7C7C7C)),
                fillColor: Color(0x3D787880),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF262626)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF262626)),
                ),
                hintText: 'Search Password',
                hintStyle: GoogleFonts.poppins(
                  color: Color(0xFF7C7C7C),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
      body: filteredPasswords.isEmpty
          ? Center(
              child: Text(
                "No results found",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: filteredPasswords.length,
              itemBuilder: (context, index) {
                final entry = filteredPasswords[index];
                return ListTile(
                  onTap: () {
                         Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DetailsScreen(entry: entry!),
                        ));
                      },
                    leading: Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        color:
                            Colors.grey[800], // Background color if image fails
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child:
                            entry.appIcon != null && entry!.appIcon.isNotEmpty
                                ? Image.network(
                                    entry.appIcon,
                                    fit: BoxFit
                                        .cover, // Ensures the image fills the container properly
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Text(
                                          entry.appName.isNotEmpty
                                              ? entry.appName[0].toUpperCase()
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
                                      entry?.appName.isNotEmpty == true
                                          ? entry!.appName[0].toUpperCase()
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
                      entry?.appName ?? '',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.29.h,
                        letterSpacing: -0.40.sp,
                      ),
                    ),
                    subtitle: Text(
                      entry?.emailPhone ?? '',
                      style: GoogleFonts.poppins(
                        color: Color(0x99EBEBF5),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.33.h,
                        letterSpacing: -0.40.sp,
                      ),
                    ));
              },
            ),
    );
  }
}
