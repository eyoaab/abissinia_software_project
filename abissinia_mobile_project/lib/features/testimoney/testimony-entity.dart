class TestimonyEntity {
  final int id;
  final String description;
  final String service;
  final String company;

  TestimonyEntity({
    required this.id,
    required this.description,
    required this.service,
    required this.company,
  });

  factory TestimonyEntity.fromJson(Map<String, dynamic> json) {
    return TestimonyEntity(
      id: json['id'] as int,
      description: json['description'] as String,
      service: json['service'] as String,
      company: json['company'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'service': service,
      'company': company,
    };
  }
}

class TestimonyModel {
    final String responseMessage;
    final bool isRight;

    const TestimonyModel({
      required this.responseMessage,
      required this.isRight,
     });
    }