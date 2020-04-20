import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping_cart/providers/products.dart';
import 'package:shopping_cart/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, i) => ProductItem(
        products[i].id,
        products[i].title,
        products[i].imageUrl,
      ),
    );
  }
}
