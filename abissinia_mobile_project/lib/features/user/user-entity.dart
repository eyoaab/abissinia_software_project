class UserEntity {
  final String userName;
  final String password;
  final String fullName;
  final String role;

  UserEntity({
    required this.userName,
    required this.password,
    required this.fullName,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
      'fullName': fullName,
      'role': role,
    };
  }
}

class UserModel {
  final String responseMessage;
  final bool isRight;

  const UserModel({
    required this.responseMessage,
    required this.isRight,
  });


}