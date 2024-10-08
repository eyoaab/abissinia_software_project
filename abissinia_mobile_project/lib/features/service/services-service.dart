
import 'dart:convert';

import 'package:abissinia_mobile_project/core/constants/Urls.dart';
import 'package:http/http.dart' as http;

import 'package:abissinia_mobile_project/features/service/service-entity.dart';
import 'package:http_parser/http_parser.dart';

class ServicesServise{

Future<ServiceModel> addServices(ServiceSend service) async {
  try {
    var request = http.MultipartRequest('POST', Uri.parse(Url.servicesUrl()));
      request.fields['title'] = service.title;
      request.fields['pricing'] = service.price.toString();
      request.fields['description'] = service.description;
      request.fields['catagory'] = service.category.toString();
      request.fields['time'] = service.time.toString();
      request.files.add(await http.MultipartFile.fromPath(
        'image', 
        service.image.path,
        contentType: MediaType('image','jpg')));
   
    var response = await request.send();
    if (response.statusCode == 201) {
      var serviceModel = const ServiceModel(responseMessage: 'service created succesfully', isRight: true);
      return serviceModel;
    } else {
      var serviceModel =  ServiceModel(responseMessage: 'service not created ${response.statusCode} ', isRight: false);
      return serviceModel;
    }
  } catch (e) {
     var serviceModel =  ServiceModel(responseMessage: 'service not created ${e.toString()}', isRight: false);
      return serviceModel;
  }
}

Future<List<ServiceEntity>> getAllServices() async {
    try {
      final response = await http.get(Uri.parse(Url.servicesUrl()));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;

        List<ServiceEntity> services = [];
        for (var item in jsonData) {
          services.add(ServiceEntity.fromJson(item));
        }
        return services;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

Future<ServiceModel> updateServices(ServiceSend service) async {
  try {
    var request = http.MultipartRequest('PUT', Uri.parse(Url.servicesUrlById(service.id.toString())));
      request.fields['id'] = service.id.toString();
      request.fields['title'] = service.title;
      request.fields['pricing'] = service.price.toString();
      request.fields['description'] = service.description;
      request.fields['catagory'] = service.category.toString();
      request.fields['time'] = service.time.toString();
      request.files.add(await http.MultipartFile.fromPath(
        'image', 
        service.image.path,
        contentType: MediaType('image','jpg')));
   
    var response = await request.send();
    if (response.statusCode == 201) {
      var serviceModel = const ServiceModel(responseMessage: 'service updated succesfully', isRight: true);
      return serviceModel;
    } else {
      var serviceModel =  ServiceModel(responseMessage: 'service not updated ${response.statusCode} ', isRight: false);
      return serviceModel;
    }
  } catch (e) {
     var serviceModel =  ServiceModel(responseMessage: 'service not created ${e.toString()}', isRight: false);
      return serviceModel;
  }
}

Future<ServiceModel> deleteServic(int id) async {
    try {
      final response = await http.delete(Uri.parse(Url.servicesUrlById(id.toString())));

      if (response.statusCode == 200) {
        return const ServiceModel(
            responseMessage: 'Servic deleted successfully', isRight: true);
      } else {
        return const ServiceModel(
            responseMessage: 'Servic not deleted', isRight: false);
      }
    } catch (e) {
      return ServiceModel(
          responseMessage: 'Error deleting Servic: $e', isRight: false);
    }
  }
}