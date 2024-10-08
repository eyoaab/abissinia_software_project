part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UserSignUpEvent extends UserEvent{
  UserEntity userEntity;
  UserSignUpEvent({required this.userEntity});
}

class UserLoginEvent extends UserEvent{
  UserEntity userEntity;
  UserLoginEvent({required this.userEntity});
}
