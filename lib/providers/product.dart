import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    final url =
        'https://shopapp-86281-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json';
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      await http.patch(
        Uri.parse(url),
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
    } catch (e) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
