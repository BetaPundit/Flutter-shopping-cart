import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/providers/orders.dart' show Orders;
import 'package:shopping_cart/widgets/app_drawer.dart';
import 'package:shopping_cart/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
        },
        child: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.error != null) {
                return Center(
                  child: Text('An error occurred!'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (context, orders, child) => ListView.builder(
                    itemCount: orders.orders.length,
                    itemBuilder: (context, i) => OrderItem(orders.orders[i]),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
