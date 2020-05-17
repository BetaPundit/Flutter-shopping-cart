import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  Future<void> toggleFavourite(String token, String userId) async {
    final url =
        'https://flutter-shopping-cart-demo.firebaseio.com/userFavourites/$userId/$id.json?auth=$token';
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();

    // http patch, put, delete does not return any error so
    // manually throwing error when statusCode >= 400
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavourite,
        ),
      );
      if (response.statusCode >= 400) {
        throw Error;
      }
    } catch (error) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
