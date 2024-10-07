import 'package:abissinia_mobile_project/features/blog/add-blog.dart';
import 'package:abissinia_mobile_project/features/faq/add-faq-page.dart';
import 'package:abissinia_mobile_project/features/product/add-product-page.dart';
import 'package:abissinia_mobile_project/features/service/add-services-page.dart';
import 'package:abissinia_mobile_project/features/slider/add-slider-page.dart';
import 'package:abissinia_mobile_project/features/testimoney/add-testimony-page.dart';
import 'package:flutter/material.dart';
import 'package:abissinia_mobile_project/features/add-page/widget.dart';
import 'package:abissinia_mobile_project/features/user/sign-up-page.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cardItems = [
      {'icon': Icons.person, 'name': 'John Doe'},
      {'icon': Icons.shopping_cart, 'name': 'Shopping'},
      {'icon': Icons.home, 'name': 'Home'},
      {'icon': Icons.work, 'name': 'Work'},
      {'icon': Icons.school, 'name': 'School'},
      {'icon': Icons.settings, 'name': 'Settings'},
    ];

    final List<VoidCallback> navigations = [
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  AddProductPage()),
      ),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  AddServicePage()),
      ),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  AddBlogPage()),
      ),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  AddTestimonyPage()),
      ),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  AddFaqPage()),
      ),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  AddSliderPage()),
      ),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Cards Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: cardItems.length,
            itemBuilder: (context, index) {
              return AddCard(
                icon: cardItems[index]['icon'],
                name: cardItems[index]['name'],
                onTap: navigations[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
