import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/screens/add_product/add_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'components/body.dart';

class AllProducts extends StatelessWidget {
  static String routeName = "/allProduct";
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    bool isAdmin = user?.email == "namnam@gmail.com";
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products', style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(onPressed: isAdmin ? () {
            Navigator.pushNamed(context, AddProduct.routeName);
          } : null, 
          icon: Icon(FontAwesomeIcons.circlePlus))
        ],
      ),
      body: Body(),
    );
  }
}
