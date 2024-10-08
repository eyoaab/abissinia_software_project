import 'dart:io';

class ServiceSend{
    int id;
    String title;
    String description;
    File image; 
    double price;
    String category;
    String time;

    
   ServiceSend({
      required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.price,
      required this.category,
      required this.time,
 
  });}

  class ServiceModel {
    final String responseMessage;
    final bool isRight;

    const ServiceModel({
      required this.responseMessage,
      required this.isRight,
     });
    }

      class ServiceEntity {
            final int id;
            final String title;
            final String description;
            final String image;
            final double pricing;
            final String category;
            final String time;

  ServiceEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.pricing,
    required this.category,
    required this.time,
  });

  factory ServiceEntity.fromJson(Map<String, dynamic> json) {
  
    return ServiceEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] != null ? json['image'] as String : 'default_image_url',

      pricing: json['pricing'].toDouble(),
      category: json['category'].toString(),
      time: json['time'].toString()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'pricing': pricing,
      'category': category, 
      'time':time
    };
  }
}