import 'dart:convert';
import 'dart:developer';
import 'package:abissinia_mobile_project/core/constants/Urls.dart';
import 'package:abissinia_mobile_project/features/faq/faq-entity.dart';
import 'package:http/http.dart' as http;


class FaqService{



Future<FaqModel> createFaq(FaqEntity faq) async {
  try {
    final response = await http.post(
      Uri.parse(Url.faqUrl()),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "question": faq.question,
        "answer": faq.answer
      }),
    );

    if (response.statusCode == 201) {
      var faqModel = const FaqModel(responseMessage: 'FAQ created successfully', isRight: true);
      return faqModel;
    } else {
      var faqModel =  FaqModel(responseMessage: 'Failed to create FAQ: ${response.statusCode}', isRight: false);
      return faqModel;
    }
  } catch (error) {
    var faqModel =  FaqModel(responseMessage: 'Error occurred: $error', isRight: false);
      return faqModel;
  }
}

Future<List<FaqEntity>> getAllFaqs() async {
  try {
    final response = await http.get(
      Uri.parse(Url.faqUrl()),
      headers: {'Content-Type': 'application/json'},
    );
    log(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['faqs'];
      List<FaqEntity> faqs = [];
      
      for (var json in data) {
        faqs.add(FaqEntity.fromJson(json));
      }

      return faqs;
    } else {
      return [];
    }
  } catch (error) {
    return [];
  }
}

Future<FaqModel> updateFaq(FaqEntity faq) async {
  try {
    final response = await http.put(
      Uri.parse(Url.faqUrlById(faq.id.toString())),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(faq.toJson()),
    );

    if (response.statusCode == 200) {
       var faqModel = const FaqModel(responseMessage: 'FAQ updated successfully', isRight: true);
      return faqModel;
      
     
    } else {
       var faqModel =  FaqModel(responseMessage: 'Failed to update FAQ: ${response.statusCode}', isRight: false);
      return faqModel;
   
    }
  } catch (error) {
     var faqModel =  FaqModel(responseMessage: 'Error occurred: $error', isRight: false);
      return faqModel;
  }
}

Future<FaqModel> deleteFaq(String id) async {
  try {
    final response = await http.delete(
      Uri.parse(Url.faqUrlById(id)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 204 || response.statusCode == 200 ) {
        var faqModel = const FaqModel(responseMessage: 'FAQ dedleted successfully', isRight: true);
      return faqModel;
    } else {
       var faqModel =  FaqModel(responseMessage: 'Failed to delete FAQ: ${response.statusCode}', isRight: false);
      return faqModel;
    }
  } catch (error) {
     var faqModel =  FaqModel(responseMessage: 'Error occurred: $error', isRight: false);
      return faqModel;
  }
}

}