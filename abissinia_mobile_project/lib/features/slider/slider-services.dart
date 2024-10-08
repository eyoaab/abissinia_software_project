import 'dart:convert';

import 'package:abissinia_mobile_project/core/constants/Urls.dart';
import 'package:http/http.dart' as http;

import 'package:abissinia_mobile_project/features/slider/slider-entity.dart';
import 'package:http_parser/http_parser.dart';

class SliderService{
Future<SliderModel> addsliders(SlidersSend Slidere) async {
  try {
    var request = http.MultipartRequest('POST', Uri.parse(Url.sliderUrl()));
      request.fields['title'] = Slidere.title;
      request.fields['description'] = Slidere.description;
      request.files.add(await http.MultipartFile.fromPath(
        'image', 
        Slidere.image.path,
        contentType: MediaType('image','jpg')));
   
    var response = await request.send();
    if (response.statusCode == 201) {
      var sliderModel = const SliderModel(responseMessage: 'slider created succesfully', isRight: true);
      return sliderModel;
    } else {
      var sliderModel =  SliderModel(responseMessage: 'slider not created ${response.statusCode} ', isRight: false);
      return sliderModel;
    }
  } catch (e) {
     var sliderModel =  SliderModel(responseMessage: 'slider not created ${e.toString()}', isRight: false);
      return sliderModel;
  }
}

Future<List<SliderEntity>> getAllSliders() async {
    try {
      final response = await http.get(Uri.parse(Url.sliderUrl()));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;

        List<SliderEntity> sliders = [];
        for (var item in jsonData) {
          sliders.add(SliderEntity.fromJson(item));
        }
        return sliders;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

Future<SliderModel> updatesliders(SlidersSend Slidere) async {
  try {
    var request = http.MultipartRequest('PUT', Uri.parse(Url.sliderUrlById(Slidere.id.toString())));
      request.fields['id'] = Slidere.id.toString();
      request.fields['title'] = Slidere.title;
      request.fields['description'] = Slidere.description;
      request.files.add(await http.MultipartFile.fromPath(
        'image', 
        Slidere.image.path,
        contentType: MediaType('image','jpg')));
   
    var response = await request.send();
    if (response.statusCode == 201) {
      var sliderModel = const SliderModel(responseMessage: 'slider updated succesfully', isRight: true);
      return sliderModel;
    } else {
      var sliderModel =  SliderModel(responseMessage: 'slider not updated ${response.statusCode} ', isRight: false);
      return sliderModel;
    }
  } catch (e) {
     var sliderModel =  SliderModel(responseMessage: 'slider not updated ${e.toString()}', isRight: false);
      return sliderModel;
  }
}

Future<SliderModel> deleteSlider(int id) async {
    try {
      final response = await http.delete(Uri.parse(Url.sliderUrlById(id.toString())));

      if (response.statusCode == 200) {
        return const SliderModel(
            responseMessage: 'Slider deleted successfully', isRight: true);
      } else {
        return const SliderModel(
            responseMessage: 'Slider not deleted', isRight: false);
      }
    } catch (e) {
      return SliderModel(
          responseMessage: 'Error deleting Slider: $e', isRight: false);
    }
  }
}