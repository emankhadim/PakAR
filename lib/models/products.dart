import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
class Products with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageurl;
  bool isFavorite;

  Products({required this.id, required this.title, required this.description, required this.price, required this.imageurl, this.isFavorite=false});
  void _setFavorite(bool newValue){
    isFavorite = newValue;
    notifyListeners();
  }
  Future<void> isfavorite () async
  {
    final oldstatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = 'https://shopar-bdbba-default-rtdb.firebaseio.com/procduct/$id.json';
    try {
      final response = await http.patch(Uri.parse(url), body: json.encode({
        'isfavorite': isFavorite,
      }),
      );
      if(response.statusCode >=400){
        _setFavorite(oldstatus);
      }
    } catch (error){
      _setFavorite(oldstatus);
    }
  }


}