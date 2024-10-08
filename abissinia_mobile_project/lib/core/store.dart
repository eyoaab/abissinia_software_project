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
