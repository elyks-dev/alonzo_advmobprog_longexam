import 'package:alonzo_advmobprog_longexam1/constants.dart';
import 'package:alonzo_advmobprog_longexam1/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alonzo_advmobprog_longexam1/providers/theme_provider.dart';

void main() => runApp(ChangeNotifierProvider(create: (_) => ThemeProvider(), child: const CCITBookApp()));

class CCITBookApp extends StatelessWidget {
  const CCITBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 715),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        final themeProvider = context.watch<ThemeProvider>();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: APP_NAME,
          theme: ThemeData(primaryColor: APP_PRIMARY, brightness: themeProvider.isDark ? Brightness.dark : Brightness.light, useMaterial3: false),
          home: const SplashScreen(),
        ); // MaterialApp
      },
    ); // ScreenUtilInit
  }
}
