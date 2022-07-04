import 'package:flutter/material.dart';

class FavorModel with ChangeNotifier {
  final String id, productId;

  FavorModel({required this.id, required this.productId});
}
