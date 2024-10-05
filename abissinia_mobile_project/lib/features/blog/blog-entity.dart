class BlogEntity {
  final int id;
  final String title;
  final String description;
  final String date;
  final String category;

  BlogEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });

  factory BlogEntity.fromJson(Map<String, dynamic> json) {
    return BlogEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,  
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'category': category
    };
  }

 
}

class BlogModel {
  final String responseMessage;
  final bool isRight;

  const BlogModel({
    required this.responseMessage,
    required this.isRight,
  });
}