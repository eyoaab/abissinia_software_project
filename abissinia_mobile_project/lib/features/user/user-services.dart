import 'dart:convert';
import 'dart:developer';  
import 'package:abissinia_mobile_project/core/constants/Urls.dart';
import 'package:abissinia_mobile_project/features/user/user-entity.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;  

class UserService{
Future<UserModel> signUpUser(UserEntity user) async {

  try {
    final response = await http.post(
      Uri.parse(Url.userSignup()),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),  
    );

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      UserModel userModel = UserModel(responseMessage: data['message'], isRight: true);
      return userModel;
    } else {
      var data = jsonDecode(response.body);
      UserModel userModel = UserModel(responseMessage: data['message'], isRight: false);
      return userModel;
    }
  } catch (e) {
      UserModel userModel = UserModel(responseMessage: e.toString(), isRight: false);
      return userModel;

  }
}

Future<UserModel> loginUser(UserEntity user) async {
  try {
    final response = await http.post(
      Uri.parse(Url.userLogin()),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': user.userName,
        'password': user.password,
      }), 
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String token =  data['token'];
      // log(token);
      String role = decodeJWT(token);
      UserModel userModel = UserModel(responseMessage: role, isRight: true);
      return userModel;

    } else {
      var data = jsonDecode(response.body);
      UserModel userModel = UserModel(responseMessage: data['message'], isRight: false);
      return userModel;
    }
  } catch (e) {
      UserModel userModel =  UserModel(responseMessage:  e.toString() , isRight: false);
      return userModel;
  }
}


String decodeJWT(String token) {
  final parts = token.split('.'); 
  if (parts.length != 3) {
    throw Exception('Invalid token');
  }
  log('parts');
  log(parts.toString());
  final payload = _decodeBase64(parts[1]);
  log('paylod');
  log(payload.toString());
  final String payloadMap = json.decode(payload)['role'].toString();  
  // if (payloadMap is! Map<String, dynamic>) {
  //   throw Exception('Invalid payload');
  // }
  return payloadMap;
}

String _decodeBase64(String str) {
  String normalized = base64Url.normalize(str);
  return utf8.decode(base64Url.decode(normalized));
}
}

