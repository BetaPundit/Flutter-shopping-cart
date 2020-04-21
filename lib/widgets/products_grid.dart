import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping_cart/providers/products.dart';
import 'package:shopping_cart/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;
  const ProductsGrid({this.showFav});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFav ? productsData.favouriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),

      // use ChangeNotifierProvider.value when building lists/grids
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ),
    );
  }
}
