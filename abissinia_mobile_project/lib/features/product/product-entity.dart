import 'dart:convert';
import 'dart:io';


class ProductSend{
    int id;
    String title;
    String description;
    File image; 
    double price;
    final List<String> features;

    
   ProductSend({
      required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.price,
      required this.features,
 
  });}

  class ProductModel {
    final String responseMessage;
    final bool isRight;

    const ProductModel({
      required this.responseMessage,
      required this.isRight,
     });
    }

    class ProductEntity {
  final int id;
  final String title;
  final String description;
  final String image;
  final double pricing;
  final List<String> features;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.pricing,
    required this.features,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    List<String> featureList = [];
    if (json['features'] != null) {
      var featuresJson = jsonDecode(json['features']);
      for (var feature in featuresJson) {
        featureList.add(feature);
      }
    }
    return ProductEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] != null ? json['image'] as String : 'default_image_url',

      pricing: json['pricing'].toDouble(),
      features: featureList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'pricing': pricing,
      'features': json.encode(features), 
    };
  }
}