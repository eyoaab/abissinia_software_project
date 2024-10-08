import 'package:abissinia_mobile_project/features/add-page/add-page.dart';
import 'package:abissinia_mobile_project/features/blog/bloc/blog_bloc.dart';
import 'package:abissinia_mobile_project/features/blog/blogpage.dart';
import 'package:abissinia_mobile_project/features/faq/bloc/faq_bloc.dart';
import 'package:abissinia_mobile_project/features/faq/faq-page.dart';
import 'package:abissinia_mobile_project/features/product/bloc/product_bloc.dart';
import 'package:abissinia_mobile_project/features/product/product-page.dart';
import 'package:abissinia_mobile_project/features/service/bloc/service_bloc.dart';
import 'package:abissinia_mobile_project/features/service/srvice-page.dart';
import 'package:abissinia_mobile_project/features/slider/bloc/slider_bloc.dart';
import 'package:abissinia_mobile_project/features/slider/slider-page.dart';
import 'package:abissinia_mobile_project/features/testimoney/bloc/testimony_bloc.dart';
import 'package:abissinia_mobile_project/features/testimoney/testimony-page.dart';
import 'package:abissinia_mobile_project/features/user/bloc/user_bloc.dart';
import 'package:abissinia_mobile_project/features/user/login-page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
// //   // runApp(
// //   //   DevicePreview(
// //   //     builder: (context) => const MyApp(),
// //   //   ),
// //   // );
// //   runApp((context)=> MyApp());
  runApp(const MyApp()); 

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BlogBloc()),
        BlocProvider(create: (context) => FaqBloc()),
        BlocProvider(create: (context) => TestimonyBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => SliderBloc()),
        BlocProvider(create: (context) => ServiceBloc()),
      ],
      child: MaterialApp(
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Abissinia Software',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF5F5F5),
            elevation: 0, 
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        home:MainPage(selectedIndex: 0,isAdmin: true,),  
      ),
    );
  }
}
class MainPage extends StatefulWidget {
  final int selectedIndex;
  final bool isAdmin;

  MainPage({required this.isAdmin, required this.selectedIndex});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> _pages;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();

    // Set the initial selected index from the passed value
    _selectedIndex = widget.selectedIndex;

    // Initialize pages, with AddPage for admin users
    _pages = [
      ProductPage(isAdmin: widget.isAdmin),
      BlogPage(isAdmin: widget.isAdmin),
      FaqPage(isAdmin: widget.isAdmin),
      ServicePage(isAdmin: widget.isAdmin),
    ];

    if (widget.isAdmin) {
      _pages.add(AddPage());
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0 ? Colors.green : Colors.grey,
            ),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.article,
              color: _selectedIndex == 1 ? Colors.green : Colors.grey,
            ),
            label: 'Blogs',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.help,
              color: _selectedIndex == 2 ? Colors.green : Colors.grey,
            ),
            label: 'FAQ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.build,
              color: _selectedIndex == 3 ? Colors.green : Colors.grey,
            ),
            label: 'Services',
          ),
          // AddPage option only for admin users
          if (widget.isAdmin)
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: _selectedIndex == 4 ? Colors.green : Colors.grey,
              ),
              label: 'Add',
            ),
        ],
      ),
    );
  }
}
