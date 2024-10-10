import 'package:abissinia_mobile_project/core/network-info.dart';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/user/bloc/user_bloc.dart'; 
import 'package:abissinia_mobile_project/features/user/login-page.dart';
import 'package:abissinia_mobile_project/features/user/user-entity.dart';
import 'package:abissinia_mobile_project/features/user/wiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // NetworkInfo networkInfo = NetworkInfo();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String? _emailError;
  Color _borderColorForEmail = Colors.grey;
  String? _passwordError;
  bool _isLoading = false; 

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
 void goToLogInPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
  void clearFields() {
    _usernameController.clear();
    _confirmPasswordController.clear();
    _passwordController.clear();
    _nameController.clear();
  }
 void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }
  void signUpUser()  {
    //   if (await networkInfo.isConnected == false){
    //   showCustomSnackBar(context, 'No internet! please cheack your Connection', false);
    //   return;
    // }
    if (_emailError != null || _isLoading) {
      return;
    }

    final name = _nameController.text;
    final username = _usernameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() {
        _passwordError = 'Passwords do not match';
      });
      return;
    }
  
    UserEntity userEntity = UserEntity(userName: username, password: password, fullName: name, role: 'user');
    BlocProvider.of<UserBloc>(context).add(UserSignUpEvent(userEntity: userEntity));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is SignupLoadingState) {
              setState(() {
                _isLoading = true; 
              });
            } else if (state is UserSignUpState) {
              showCustomSnackBar(context, state.userModel.responseMessage, state.userModel.isRight);
              if (state.userModel.isRight) {
                goToLogInPage();
              }
              setState(() {
                _isLoading = false; 
              });
            } else if (state is SignUpErrorState) {
              showCustomSnackBar(context, state.message, false);
              setState(() {
                _isLoading = false; 
              });
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 5),
                  Text(
                    'Create An Account for Free',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: commonColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'assets/logo.jpeg',
                      height: 230,
                      width: 270, 
                      fit: BoxFit.cover, 
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: _nameController,
                    decoration: customInputDecoration(
                      labelText: 'Name',
                      suffixIcon: Icon(Icons.person, color: commonColor),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Email',
                      suffixIcon: Icon(Icons.email, color: commonColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: _borderColorForEmail, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: commonColor, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.red, width: 2.0),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _emailError = 'Please enter your email address';
                          _borderColorForEmail = Colors.red;
                        });
                      } else if (!isValidEmail(value)) {
                        setState(() {
                          _emailError = 'Please enter a valid email';
                          _borderColorForEmail = Colors.red;
                        });
                      } else {
                        setState(() {
                          _emailError = null;
                          _borderColorForEmail = commonColor;
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
                    decoration: passwordInputDecoration(
                      labelText: 'Password',
                      isPasswordVisible: _isPasswordVisible,
                      togglePasswordVisibility: _togglePasswordVisibility,
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: passwordInputDecoration(
                      labelText: 'Confirm Password',
                      isPasswordVisible: _isConfirmPasswordVisible,
                      togglePasswordVisibility: _toggleConfirmPasswordVisibility,
                    ),
                  ),
                  if (_passwordError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _passwordError!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: signUpUser, 
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: commonColor,
                      ),
                      child:  _isLoading ? const CircularProgressIndicator(color:Colors.white,):
                          const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextButton(
                    onPressed: goToLogInPage,
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: 'Log in',
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
    );
  }
}
