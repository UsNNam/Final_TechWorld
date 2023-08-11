import 'package:flutter/material.dart';

import 'components/body.dart';

class OrderTrackerScreen extends StatelessWidget {
  static String routeName = "/orderTracker";
  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text("Tracking order", style: TextStyle(color: Colors.black),),
      ),
      body: Body(order: order,),
    );
  }
}
