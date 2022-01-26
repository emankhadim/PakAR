import 'package:flutter/foundation.dart';

class CartItems{
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String img;

  CartItems({required this.id, required this.title, required this.quantity, required this.price, required this.img});
}
class Cart with ChangeNotifier{
  Map <String, CartItems> _items = {};
  Map<String, CartItems> get items {
    return {..._items};
  }
  void addItem (String productId, String title, double price, String img){
    if(_items.containsKey(productId)){
      _items.update(productId, (value) => CartItems(id:value.id,title: value.title,quantity: value.quantity +1, price: value.price,img: value.img));
    }else{
      _items.putIfAbsent(productId, () => CartItems(id:DateTime.now().toString(), title:title,quantity: 1, price:price,img: img),);
    }
    notifyListeners();
  }
  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  double totalAmount(){
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }
  void clear()
  {
    _items = {};
    notifyListeners();
  }
}