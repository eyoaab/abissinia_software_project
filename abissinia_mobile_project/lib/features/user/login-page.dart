import 'package:abissinia_mobile_project/core/network-info.dart';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/user/bloc/user_bloc.dart';
import 'package:abissinia_mobile_project/features/user/sign-up-page.dart';
import 'package:abissinia_mobile_project/features/user/user-entity.dart';
import 'package:abissinia_mobile_project/features/user/wiget.dart';
import 'package:abissinia_mobile_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // NetworkInfo networkInfo = NetworkInfo();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String? _emailError;
  Color _borderColor = Colors.grey;
  bool _isLoading = false; 


  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _logInUser() async{
    // if (await networkInfo.isConnected == false){
    //   showCustomSnackBar(context, 'No internet! please cheack your Connection', false);
    //   return;
    // }
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (_emailError != null || _isLoading ) {
      return; 
    }

    UserEntity userEntity = UserEntity(
      userName: username,
      password: password,
      fullName: '',
      role: 'user',
    );

    BlocProvider.of<UserBloc>(context).add(UserLoginEvent(userEntity: userEntity));
  }

  void _goToSignUpPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoginState) {
               setState(() {
                _isLoading = false;
              });
              if (state.userModel.isRight) {
                String role = state.userModel.responseMessage;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(isAdmin: role == 'admin', selectedIndex: 0),
                  ),
                );
              } else {
                setState(() {
                  _isLoading = false;
                });
                showCustomSnackBar(context, state.userModel.responseMessage, state.userModel.isRight);
              }
            }else if (state is LoaginLoadingState) {
              setState(() {
                _isLoading = true;
              });
            }
             else if (state is LoginErrorState) {
               setState(() {
                _isLoading = false;
              });
              showCustomSnackBar(context, state.message, false);
            }
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
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'assets/logo.jpeg',
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
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: Icon(Icons.email, color: commonColor),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _borderColor, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: commonColor, width: 2.0),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
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
                        filled: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: commonColor,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: commonColor, width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _logInUser,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: commonColor,
                        ),
                        child: _isLoading ? const CircularProgressIndicator(color:Colors.white):const Text(
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
                      onPressed: _goToSignUpPage,
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
        ),
      ),
    );
  }
}
