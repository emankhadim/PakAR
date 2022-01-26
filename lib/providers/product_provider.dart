import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:untitled/models/http_cutsom_exception.dart';
import '../models/products.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier{
  List<Products> _items =[]; /*[ Products(
    id: 'p1',
    title: 'Red Shirt',
    description: 'A red shirt - it is pretty red!',
    price: 29.99,
    imageurl:
    'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  ),
    Products(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageurl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Products(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageurl:
      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Products(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageurl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),];*/

  List<Products> get items {
    return  [..._items];//copy
  }
  Products findById (String id){
    return _items.firstWhere((element) => element.id == id);
  }
  Future<void> fetchandsetProduct() async {
    final url = 'https://shopar-bdbba-default-rtdb.firebaseio.com/procduct.json';
    try{

      final response = await http.get(Uri.parse(url));
      final extracteddata = json.decode(response.body) as Map<String,dynamic>;
      if(extracteddata.isEmpty) {
        return;
      }
      final List<Products>loadedProducts = [];
      extracteddata.forEach((productID, prodData) {
        loadedProducts.add(Products(
          id: productID,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageurl: prodData['imageurl'],
          isFavorite: prodData['isFavorite'],

        ));
        _items = loadedProducts;
        notifyListeners();
      });
    }catch(error){
      print(error);
    }
  }
  Future<void> addProduct(Products product) async {
    const url = 'https://shopar-bdbba-default-rtdb.firebaseio.com/procduct.json';
    try {
      final value = await http.post(Uri.parse(url), body: json.encode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageurl': product.imageurl,
        'isfavorite': product.isFavorite,
      }),
      );
          final newProduct = Products(id: json.decode(value.body)['name'], title: product.title, description: product.description, price: product.price, imageurl: product.imageurl);
          _items.add(newProduct);
          notifyListeners();
    } catch(error) {
      throw error;
    }
  }
  Future <void> updateproduct(String id, Products newproduct) async{
    final productid = _items.indexWhere((element) => element.id==id);
    if(productid >= 0) {
      final url = 'https://shopar-bdbba-default-rtdb.firebaseio.com/procduct/$id.json';
      await http.patch(Uri.parse(url), body: json.encode({
        'title': newproduct.title,
        'description': newproduct.description,
        'price': newproduct.price,
        'imageurl': newproduct.imageurl,
      }));
      _items[productid] = newproduct;
      notifyListeners();
    }
        else{
          print('....');
    }

  }
  Future<void> deleteproduct(String id) async{
    final url = 'https://shopar-bdbba-default-rtdb.firebaseio.com/procduct/$id.json';
    final existingProductIndex = _items.indexWhere((prodId) => prodId.id == id);
    Products? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if(response.statusCode>=400){
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existingProduct= null;
  }
}