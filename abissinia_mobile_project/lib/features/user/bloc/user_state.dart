part of 'user_bloc.dart';

@immutable
sealed class UserState {}
final class UserInitial extends UserState {}

final class LoaginLoadingState extends UserState{}
final class UserLoginState extends UserState{
  final UserModel userModel;
  UserLoginState({required this.userModel});
}
class LoginErrorState extends UserState{
  final String message;
  LoginErrorState({required this.message});
}


final class UserSignUpState extends UserState{
  final UserModel userModel;
  UserSignUpState({required this.userModel});
}
class SignUpErrorState extends UserState{
  final String message;
  SignUpErrorState({required this.message});
}
final class SignupLoadingState extends UserState{}


