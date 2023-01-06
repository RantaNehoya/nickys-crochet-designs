import 'package:flutter/material.dart';

class ProductModel {
  final String name;
  final String price;
  final String size;
  final dynamic image;

  ProductModel({
    @required this.name,
    @required this.price,
    @required this.size,
    this.image,
  });
}
