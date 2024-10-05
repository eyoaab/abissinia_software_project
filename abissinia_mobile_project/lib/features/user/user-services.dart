import 'dart:convert';  
import 'package:abissinia_mobile_project/features/user/user-entity.dart';
import 'package:http/http.dart' as http;  

class UserService{
Future<UserModel> signUpUser(UserEntity user) async {

  try {
    final response = await http.post(
      Uri.parse(''),
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
      Uri.parse(''),
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
      UserModel userModel = UserModel(responseMessage: data['token'], isRight: true);
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
}