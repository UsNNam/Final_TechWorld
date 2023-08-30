import 'package:flutter/material.dart';

import 'components/body.dart';

class OrderInfoForAdminScreen extends StatelessWidget {
  static String routeName = "/orderInfoAdmin";

  @override
  Widget build(BuildContext context) {
    Map data = {};
    data = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Information"),
      ),
      body: Body(data: data,),
    );
  }
}
