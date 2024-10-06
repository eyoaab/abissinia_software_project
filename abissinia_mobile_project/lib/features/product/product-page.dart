import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/product/product-entity.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<ProductEntity> dammyProsduct = [
    ProductEntity(id: 1, 
    title: 'Producr1',
     description: 'In Flutter, navigating between pages (or screens) is commonly done using the Navigator class. Pages in Flutter are usually widgets, and you can push a new page onto the stack (navigate to another page) or pop a page off the stack (go back to the previous page).',
      image: 'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200', 
      pricing: 500, 
      features: ['navigating between','navigating between ','is commonly done using ']),
        ProductEntity(id: 1, 
    title: 'one dummy',
     description: '',
      image: 'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200', 
      pricing: 1, 
      features: ['d,d']),
        ProductEntity(id: 1, 
    title: 'two dummy',
     description: '',
      image: 'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200', 
      pricing: 1, 
      features: ['d,d']),
        ProductEntity(id: 1, 
    title: 'three dummy',
     description: '',
      image: 'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200', 
      pricing: 1, 
      features: ['d,d']),

  ];

  List<ProductEntity> filteredProduct = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredProduct = dammyProsduct;
  }

  void _filterproduct(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProduct = dammyProsduct; 
      });
    } else {
      setState(() {
        filteredProduct = dammyProsduct.where((blog) {
          return blog.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 20.0
          
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: commonSerchDecoration,
                    onChanged: (value) {
                      searchQuery = value;
                      _filterproduct(searchQuery);
                    },
                  ),
                ),
                const SizedBox(width: 8), 
                const Icon(
                  Icons.menu,
                  color: Colors.green,
                ),
              ],
            ),
              const SizedBox(height: 16), 
              filteredProduct.isEmpty 
                  ? const Center(
                      child: Text(
                        'No product found',
                        style: TextStyle(color: Colors.grey, fontSize: 20), 
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: filteredProduct.length,
                        itemBuilder: (context, index) {
                          return ProductCard(productEntity: filteredProduct[index],isAdmin:true);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
