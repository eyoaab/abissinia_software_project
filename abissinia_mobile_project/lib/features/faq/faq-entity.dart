class FaqEntity {
  final int id;
  final String question;
  final String answer;

  FaqEntity({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FaqEntity.fromJson(Map<String, dynamic> json) {
    return FaqEntity(
      id: json['id'] as int,
      question: json['question'] as String,
      answer: json['answer'] as String,
    );
  }
   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };

  }}

  class FaqModel {
    final String responseMessage;
    final bool isRight;

    const FaqModel({
      required this.responseMessage,
      required this.isRight,
     });
    }
