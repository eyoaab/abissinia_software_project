import 'dart:convert';
import 'package:abissinia_mobile_project/features/testimoney/testimony-entity.dart';
import 'package:http/http.dart' as http;

class TestimonyService {

  Future<TestimonyModel> createTestimony(TestimonyEntity testimony) async {
    try {
      final response = await http.post(
        Uri.parse('/testimonies'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "description": testimony.description,
          "service": testimony.service,
          "company": testimony.company,
        }),
      );

      if (response.statusCode == 201) {
        return const TestimonyModel(
            responseMessage: 'Testimony created successfully', isRight: true);
      } else {
        return const TestimonyModel(
            responseMessage: 'Testimony not created', isRight: false);
      }
    } catch (e) {
      return TestimonyModel(
          responseMessage: 'Error creating testimony: $e', isRight: false);
    }
  }

  Future<List<TestimonyEntity>> getAllTestimonies() async {
    try {
      final response = await http.get(
        Uri.parse('/testimonies'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['testimonies'] as List;

        List<TestimonyEntity> testimonies = [];
        for (var item in jsonData) {
          testimonies.add(TestimonyEntity.fromJson(item));
        }

        return testimonies;
      } else {
        throw Exception('Failed to load testimonies');
      }
    } catch (e) {
      throw Exception('Error loading testimonies: $e');
    }
  }

  Future<TestimonyModel> updateTestimony(int id, TestimonyEntity testimony) async {
    try {
      final response = await http.put(
        Uri.parse('/testimonies/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(testimony.toJson()),
      );

      if (response.statusCode == 200) {
        return const TestimonyModel(
            responseMessage: 'Testimony updated successfully', isRight: true);
      } else {
        return const TestimonyModel(
            responseMessage: 'Testimony not updated successfully', isRight: false);
      }
    } catch (e) {
      return TestimonyModel(
          responseMessage: 'Error updating testimony: $e', isRight: false);
    }
  }

  Future<TestimonyModel> deleteTestimony(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('/testimonies/$id'),
      );

      if (response.statusCode == 200) {
        return const TestimonyModel(
            responseMessage: 'Testimony deleted successfully', isRight: true);
      } else {
        return const TestimonyModel(
            responseMessage: 'Testimony not deleted successfully', isRight: false);
      }
    } catch (e) {
      return TestimonyModel(
          responseMessage: 'Error deleting testimony: $e', isRight: false);
    }
  }
}
