import 'package:abissinia_mobile_project/features/user/user-entity.dart';
import 'package:abissinia_mobile_project/features/user/user-services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserService userService = UserService();
  UserBloc() : super(UserInitial()) {

    on<UserLoginEvent>((event, emit) async {
      emit(LoaginLoadingState());
      try{
      final UserModel userModel = await userService.loginUser(event.userEntity);
      emit(UserLoginState(userModel: userModel));
      }catch(error)
      {
      emit(LoginErrorState(message: error.toString()));
      }

    });

       on<UserSignUpEvent>((event, emit) async {
      emit(SignupLoadingState());
      try{
      final UserModel userModel = await userService.signUpUser(event.userEntity);
      emit(UserSignUpState(userModel: userModel));
      }catch(error)
      {
      emit(SignUpErrorState(message: error.toString()));
      }

    });
  }
}
