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