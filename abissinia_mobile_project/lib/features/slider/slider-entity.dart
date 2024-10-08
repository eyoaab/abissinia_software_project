import 'dart:io';

class SlidersSend{
    int id;
    String title;
    String description;
    File image; 
   SlidersSend({
      required this.id,
      required this.title,
      required this.description,
      required this.image,
 
  });}

    class SliderModel {
    final String responseMessage;
    final bool isRight;

    const SliderModel({
      required this.responseMessage,
      required this.isRight,
     });
    }


 class SliderEntity {
  final int id;
  final String title;
  final String description;
  final String image;
  SliderEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  
  });

  factory SliderEntity.fromJson(Map<String, dynamic> json) {
  
    return SliderEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] != null ? json['image'] as String : 'default_image_url',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
    };
  }
}