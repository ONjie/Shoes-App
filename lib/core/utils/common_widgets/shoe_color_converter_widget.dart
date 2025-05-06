import 'package:flutter/material.dart';

Color shoeColorConverterWidget({required String colorValue}){
  return Color(
    int.parse('0xFF$colorValue')
  );
}