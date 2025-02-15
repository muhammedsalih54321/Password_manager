import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:password_manager/Provider/Model_class.dart';
import 'package:password_manager/Provider/PasswordEntryadapter.dart';
import 'package:password_manager/Provider/Provider_class.dart';
import 'package:password_manager/Ui/Splash_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
// Import your model

const String passwordBoxName = "passwordBox";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Get the correct directory for Hive storage
  final directory = await getApplicationDocumentsDirectory();
  
  // ✅ Initialize Hive with a writable path
  await Hive.initFlutter();
  Hive.init(directory.path);

  // ✅ Register the adapter
  Hive.registerAdapter(PasswordEntryAdapter());
  print("Hive Storage Path: ${directory.path}");

  // ✅ Open the box (Ensure it opens without errors)
  await Hive.openBox<PasswordEntry>(passwordBoxName);

  runApp(
    ChangeNotifierProvider(
      create: (context) => PasswordProvider(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 845),
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              splashColor: Colors.transparent),
            home: SplashScreen(),
          );
        });
  }
}
