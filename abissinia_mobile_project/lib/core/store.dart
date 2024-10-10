import 'package:abissinia_mobile_project/features/user/login-page.dart';
import 'package:flutter/material.dart';

InputDecoration commonSerchDecoration = InputDecoration(
  hintText: 'Search...',
  filled: true,
  fillColor: Colors.white, 
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide:  const BorderSide(color: Colors.grey),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.green), 
  ),
  suffixIcon: const Icon(
    Icons.search,
    color: Colors.green,
  ),
);

Color commonColor =  Colors.green;

void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
  final Color backgroundColor = isSuccess ? Colors.green : Colors.red;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating, 
      duration: const Duration(seconds: 3), 
    ),
  );
}



void showLogoutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: const Text('No'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.green, 
            ),
            onPressed: () {
              Navigator.of(context).pop(); 
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}