import 'package:flutter/material.dart';
import 'package:abissinia_mobile_project/features/product/product-entity.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';
import 'package:abissinia_mobile_project/features/slider/slider-page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<ProductEntity> dammyProducts = [
    ProductEntity(
        id: 1,
        title: 'Product 1',
        description: 'Description of Product 1',
        image:
            'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200',
        pricing: 500,
        features: ['Feature 1', 'Feature 2', 'Feature 3']),
    ProductEntity(
        id: 2,
        title: 'Product 2',
        description: 'Description of Product 2',
        image:
            'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200',
        pricing: 300,
        features: ['Feature A', 'Feature B']),
  ];

  List<ProductEntity> filteredProducts = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredProducts = dammyProducts;
  }

  void _filterProduct(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProducts = dammyProducts;
      });
    } else {
      setState(() {
        filteredProducts = dammyProducts.where((product) {
          return product.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                        ),
                        onChanged: (value) {
                          searchQuery = value;
                          _filterProduct(searchQuery);
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
                const SizedBox(
                  height: 350, 
                  child: SliderPage(),
                ),
                const SizedBox(height: 16),
                filteredProducts.isEmpty
                    ? const Center(
                        child: Text(
                          'No product found',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(), 
                        shrinkWrap: true,
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                              productEntity: filteredProducts[index],
                              isAdmin: false);
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
