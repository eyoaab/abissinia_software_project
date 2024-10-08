import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/user/bloc/user_bloc.dart';
import 'package:abissinia_mobile_project/features/user/sign-up-page.dart';
import 'package:abissinia_mobile_project/features/user/user-entity.dart';
import 'package:abissinia_mobile_project/features/user/wiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  String? _emailError;
  Color _borderColor = Colors.grey;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void LogInUser() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (_emailError != null) {
      return;
    }
    UserEntity userEntity = UserEntity(userName: username, password: password, fullName: '', role: 'user');

    BlocProvider.of<UserBloc>(context).add(UserLoginEvent(userEntity: userEntity));


  }

  void goToSignUpPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(


        body:BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoginState) {
              // showCustomSnackBar(context, state.userModel.responseMessage, state.userModel.isRight);
              if(state.userModel.isRight){
                String role = state.userModel.responseMessage;
                if (role == 'admin'){
                  
                }
                else{

                }

              }  
              else{
              showCustomSnackBar(context, state.userModel.responseMessage, state.userModel.isRight);

              }            
               
            }else if(state is LoginErrorState){
              showCustomSnackBar(context, state.message, false);}
          },

      child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: commonColor,
                    ),
                  ),
                  const SizedBox(height:20),
                   ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    'logo.jpeg',
                    height: 230,
                    width: 270, 
                    fit: BoxFit.cover, 
                  ),
                ),
                  
                  const SizedBox(height: 60),

                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      fillColor:Colors.white,
                      filled:true,
                      suffixIcon: Icon(Icons.email, color: commonColor,),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _borderColor,width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: commonColor,width: 2.0),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red,width: 2.0),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red,width: 2.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _emailError = 'Please enter your email';
                          _borderColor = Colors.red;
                        });
                      } else if (!isValidEmail(value)) {
                        setState(() {
                          _emailError = 'Please enter a valid email';
                          _borderColor = Colors.red;
                        });
                      } else {
                        setState(() {
                          _emailError = null;
                          _borderColor = commonColor;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  if (_emailError != null)
                    Text(
                      _emailError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      fillColor: Colors.white,
                      filled:true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: commonColor,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color:Colors.grey,width: 2.0),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: commonColor,width: 2.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: LogInUser,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: commonColor,
                      ),
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: goToSignUpPage,
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: commonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),)
    );
  }
}
