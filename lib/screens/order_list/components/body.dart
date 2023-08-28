import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/order_tracker/order_tracker.dart';
import 'package:shop_app/size_config.dart';

List orderList = [];

class BlockWidget extends StatelessWidget {
  final String data;

  final Map order;

  BlockWidget(this.data, this.order);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(12),),
        Container(
          height: 50,
          width: getProportionateScreenWidth(340),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
              ),
              backgroundColor: MaterialStateProperty.all(const Color.fromARGB(115, 143, 143, 143)),
            ),
            onPressed: () {
              Navigator.pushNamed(context, OrderTrackerScreen.routeName, arguments: order);
            }, 
            child: Text(data)),
        ),
        SizedBox(height: getProportionateScreenHeight(18),),
      ],
    );
  }
}



class Body extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          int tmp = index + 1;
          return BlockWidget("Order $tmp", orderList[index]);
        },
      ),
    );
  }
}
