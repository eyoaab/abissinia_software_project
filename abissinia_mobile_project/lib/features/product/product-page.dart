import 'package:abissinia_mobile_project/core/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abissinia_mobile_project/features/product/bloc/product_bloc.dart';
import 'package:abissinia_mobile_project/features/product/product-entity.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';
import 'package:abissinia_mobile_project/features/slider/slider-page.dart';

class ProductPage extends StatefulWidget {
  final bool isAdmin;
  const ProductPage({Key? key, required this.isAdmin}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductEntity> filteredProducts = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(LoadAllProductEvent());
  }

  void _filterProduct(String query, List<ProductEntity> products) {
    if (query.isEmpty) {
      setState(() {
        filteredProducts = products;
      });
    } else {
      setState(() {
        filteredProducts = products.where((product) {
          return product.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  'Product Page',
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
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is ProductLoadedState) {
              final products = state.loadedProducts;
              filteredProducts = filteredProducts.isEmpty ? products : filteredProducts;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: commonSerchDecoration,
                              onChanged: (value) {
                                searchQuery = value;
                                _filterProduct(searchQuery, products);
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.menu, color: Colors.green),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 350, 
                        child: SliderPage(isAdmin: widget.isAdmin),
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
                                  isAdmin: widget.isAdmin,
                                );
                              },
                            ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
