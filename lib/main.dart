import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task/services/api_services.dart';
import 'package:task/utils/theme.dart';
import 'package:task/view%20model/home_view_model.dart';
import 'package:task/view/homepage.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(ApiService()),
        ),
      ],
      child: ScreenUtilInit(
        child: MaterialApp(
          showSemanticsDebugger: false,
          debugShowCheckedModeBanner: false,
          title: 'WAC Assignment',
          theme: lightTheme,
          home: const HomePage(),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
