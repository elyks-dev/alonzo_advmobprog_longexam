import 'package:facebook_replication/constants.dart';
import 'package:facebook_replication/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(const CCITBookApp());

class CCITBookApp extends StatelessWidget {
  const CCITBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 715),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: APP_NAME,
          theme: ThemeData(primaryColor: APP_PRIMARY, useMaterial3: false),
          home: const HomeScreen(),
        ); // MaterialApp
      },
    ); // ScreenUtilInit
  }
}
