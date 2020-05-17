import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/providers/products.dart';
import 'package:shopping_cart/screens/edit_product_screen.dart';
import 'package:shopping_cart/widgets/app_drawer.dart';
import 'package:shopping_cart/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Consumer<Products>(
                        builder: (_, products, child) => ListView.builder(
                          itemCount: products.items.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              UserProductItem(
                                id: products.items[i].id,
                                title: products.items[i].title,
                                imageUrl: products.items[i].imageUrl,
                              ),
                              Divider(
                                indent: 8,
                                endIndent: 8,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
