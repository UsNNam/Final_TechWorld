import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<int> searchResult = ModalRoute.of(context)!.settings.arguments as List<int>;
    print(searchResult);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: 
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Container(
              height: double.infinity,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: 0.0, // Space between columns
                  mainAxisSpacing: 24.0, // Space between rows
                ),
                itemCount: searchResult.length,
                itemBuilder: (BuildContext context, int index) {
                  print("Search result: $searchResult");
                  print("Index: $index");
                  final int productIndex = searchResult[index];
                  return ProductCard(product: demoProducts[productIndex - 1], aspectRetio: 1.6);
                  
                },
              ),
            ),
          ),
      ),
    );
  }
}
