import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/providers/orders_providers.dart';

class OrdersItems extends StatefulWidget {
  final OrderItem orders;


  const OrdersItems({Key? key,required this.orders}) : super(key: key);

  @override
  _OrdersItemsState createState() => _OrdersItemsState();
}

class _OrdersItemsState extends State<OrdersItems> {
  var _expanded=false;
  @override
  Widget build(BuildContext context) {

    return Card(
      child: Card(
          child: Column(
              children: <Widget> [
          ListTile(
          title: Text(widget.orders.amount.toString()),
      subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.orders.dateTime)),
      trailing: IconButton(icon: Icon( _expanded ? Icons.expand_less: Icons.expand_more),
        onPressed: (){
          setState(() {
            _expanded = !_expanded;
          });
        },),
    ),
    if(_expanded)
      Container(
    height: min(widget.orders.products.length*20 + 100, 180),
    child: ListView(children:
    widget.orders.products.map((e) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(e.title),
    Text('${e.quantity} X \$${e.price}'),]
    )
    ).toList(),
    ),
    ),
    ],),),
    );
  }
}
