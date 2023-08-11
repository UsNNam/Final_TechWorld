import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/screens/checkout_screen/check_out.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/order_tracker/order_tracker.dart';
import 'package:shop_app/service/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/screens/order_list/components/body.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ConfirmCard extends StatelessWidget {
  const ConfirmCard({
    Key? key,
  }) : super(key: key);

  double? calculateTotalMoney(){
    double result = 0;
    demoCarts.forEach((element) {
      result += element.product.price * element.numOfItem;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 193, 192, 192),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "\$" + calculateTotalMoney()!.toStringAsFixed(2),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Confirm",
                    press: () async {
                      print("aAAF");
                      Map? userData = await DatabaseService(uid: user?.uid).takeUserData();
                      print(userData);
                      
                      await DatabaseServiceOrder().uploadOrderData(OrderCustom(id: '1', uid: user?.uid,
                      total: calculateTotalMoney()!.toStringAsFixed(2), listItemCart: demoCarts, address: userData['address'], status: 'Confirmed'));
                      // print(user);
                      // orderList = await DatabaseServiceOrder().loadOrderForUser(user!.uid);
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
