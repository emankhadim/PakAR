import 'package:flutter/material.dart';
import '../providers/cart_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class OrderItem {
  final String id;
  final double amount;
  final List<CartItems> products;
  final DateTime dateTime;

  OrderItem({required this.id, required this.amount, required this.products, required this.dateTime});

}

class Orders with ChangeNotifier{
  List <OrderItem> _orders= [];
  List<OrderItem> get orders {
    return [..._orders];
  }
  Future<void> addOrder(List<CartItems> cartproducts , double total)async {
    final url = 'https://shopar-bdbba-default-rtdb.firebaseio.com/procduct/order.json';
    final timestamp = DateTime.now();
    final response = await http.post(Uri.parse(url), body: json.encode({
      'amount' : total,
      'dateTime': timestamp.toIso8601String(),
      'products': cartproducts.map((e) => {
      'id': e.id,
        'title': e.title,
        'quantity': e.quantity,
        'price': e.price,
      }).toList(),
    }), );
    _orders.insert(0, OrderItem(id: json.decode(response.body)['name'], amount: total, products: cartproducts, dateTime: DateTime.now()));
    notifyListeners();
  }
  Future<void> fetchaAndSetOrders() async {
    const url = 'https://shopar-bdbba-default-rtdb.firebaseio.com/procduct/order.json';
    final response = await http.get(Uri.parse(url));
    final List<OrderItem> loadedOrders = [];
    final extractedOrders = json.decode(response.body) as Map<String,dynamic>;
    if ( extractedOrders.isEmpty){
      return;
    }
    extractedOrders.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(id: orderId, amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>).map((item) =>
            CartItems(price: item['price'], title: item['title'], id: item['id'], img: item['img'],quantity: item['quantity'] )
          ).toList(), dateTime: orderData['dateTime']));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();

  }


}