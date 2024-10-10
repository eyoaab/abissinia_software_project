import 'package:abissinia_mobile_project/features/blog/add-blog-page.dart';
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
      {'icon': Icons.add_shopping_cart, 'name': 'Add Product'},
      {'icon': Icons.business_center, 'name': 'Add Service'},
      {'icon': Icons.article, 'name': 'Add Blog'},
      {'icon': Icons.rate_review, 'name': 'Add Testimony'},
      {'icon': Icons.question_answer, 'name': 'Add FAQ'},
      {'icon': Icons.slideshow, 'name': 'Add Slider'},
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
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.06),
          child: Container(
            color: Colors.green,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add Page',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0,right:8.0,top:25),
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
