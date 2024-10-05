import 'dart:convert';

import 'package:abissinia_mobile_project/features/product/product-entity.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class ProductServices{

Future<ProductModel> addproducts(ProductSend product) async {
  try {
    var request = http.MultipartRequest('POST', Uri.parse(''));
      request.fields['title'] = product.title;
      request.fields['pricing'] = product.price.toString();
      request.fields['description'] = product.description;
      request.fields['features'] = product.features.toString();
      request.files.add(await http.MultipartFile.fromPath(
        'image', 
        product.image.path,
        contentType: MediaType('image','jpg')));
   
    var response = await request.send();
    if (response.statusCode == 201) {
      var productModel = const ProductModel(responseMessage: 'product created succesfully', isRight: true);
      return productModel;
    } else {
      var productModel =  ProductModel(responseMessage: 'product not created ${response.statusCode} ', isRight: false);
      return productModel;
    }
  } catch (e) {
     var productModel =  ProductModel(responseMessage: 'product not created ${e.toString()}', isRight: false);
      return productModel;
  }
}

  Future<List<ProductEntity>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse('/products'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;

        List<ProductEntity> products = [];
        for (var item in jsonData) {
          products.add(ProductEntity.fromJson(item));
        }

        return products;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<ProductModel> updateProduct(ProductSend product) async {
      try {
    var request = http.MultipartRequest('PUT', Uri.parse(''));
      request.fields['id'] = product.id.toString();
      request.fields['title'] = product.title;
      request.fields['pricing'] = product.price.toString();
      request.fields['description'] = product.description;
      request.fields['features'] = product.features.toString();
      request.files.add(await http.MultipartFile.fromPath(
        'image', 
        product.image.path,
        contentType: MediaType('image','jpg')));
   
    var response = await request.send();
    if (response.statusCode == 200) {
      var productModel = const ProductModel(responseMessage: 'product updated succesfully', isRight: true);
      return productModel;
    } else {
      var productModel =  ProductModel(responseMessage: 'product not updated ${response.statusCode} ', isRight: false);
      return productModel;
    }
  } catch (e) {
     var productModel =  ProductModel(responseMessage: 'product not updated ${e.toString()}', isRight: false);
      return productModel;
  }
}

  Future<ProductModel> deleteProduct(int id) async {
    try {
      final response = await http.delete(Uri.parse('/products/$id'));

      if (response.statusCode == 200) {
        return const ProductModel(
            responseMessage: 'Product deleted successfully', isRight: true);
      } else {
        return const ProductModel(
            responseMessage: 'Product not deleted', isRight: false);
      }
    } catch (e) {
      return ProductModel(
          responseMessage: 'Error deleting product: $e', isRight: false);
    }
  }
}

