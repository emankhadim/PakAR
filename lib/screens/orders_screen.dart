import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/orders_providers.dart';
import 'package:untitled/widgets/orders_item.dart';
import '../widgets/app_drawer.dart';

class OrderScreens extends StatefulWidget {
  static const routeName = '/orders';
  const OrderScreens({Key? key}) : super(key: key);

  @override
  _OrderScreensState createState() => _OrderScreensState();
}

class _OrderScreensState extends State<OrderScreens> {
  late Future _ordersFuture;
  Future _getOrdersFuture (){
    return Provider.of<Orders>(context, listen: false).fetchaAndSetOrders();
  }
  @override
  void initState() {
    _ordersFuture = _getOrdersFuture();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My orders'),),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: _ordersFuture,
          builder: (ctx, dataSnapshot){
            if(dataSnapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }else{
              if(dataSnapshot.hasError){
                return Center(child:Text("An error occured in orders fetching"));
                }
              else{
                return Consumer<Orders>(builder: (ctx, orderData, child)=>
                  ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx,index) => OrdersItems(orders: orderData.orders[index])
                  ), );
                }
            }
          },
      ),
    );
  }
}
