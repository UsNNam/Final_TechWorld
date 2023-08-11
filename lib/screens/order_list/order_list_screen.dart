import 'package:flutter/material.dart';

import 'components/body.dart';

class OrderListScreen extends StatelessWidget {
  static String routeName = "/orderList";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order List"),
      ),
      body: Body(),
    );
  }
}
