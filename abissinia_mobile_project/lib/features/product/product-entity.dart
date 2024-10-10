import 'dart:convert';
import 'dart:io';


class ProductSend{
    int id;
    String title;
    String description;
    File image; 
    double price;
    final String features;

    
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
  final String? image;
  final double pricing;
  final String features;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.pricing,
    required this.features,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
  
    return ProductEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String? ?? 'No description provided',
      image: json['image'] != null ? json['image'] as String : null,
      pricing: (json['pricing'] as num).toDouble(),
      features: json['features']
        
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