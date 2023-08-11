import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: 
          Container(
            height: double.infinity,
            child: Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: 0.0, // Space between columns
                  mainAxisSpacing: 24.0, // Space between rows
                ),
                itemCount: demoProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(product: demoProducts[index], aspectRetio: 1.6,);
                },
              ),
            ),
          ),
      ),
    );
  }
}
