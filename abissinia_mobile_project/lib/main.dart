import 'package:abissinia_mobile_project/features/blog/blogpage.dart';
import 'package:abissinia_mobile_project/features/blog/widgets.dart';
import 'package:abissinia_mobile_project/features/faq/faq-page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      debugShowCheckedModeBanner: false,
      title: 'Abissinia Software',
      theme: ThemeData(
        // Setting the scaffold background color for all pages
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        // Customizing the app bar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F5F5),
          elevation: 0, // Remove shadow under the AppBar
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        // Setting default text styles
      
      ),
      home:  const FaqPage()
    );
  }
}
