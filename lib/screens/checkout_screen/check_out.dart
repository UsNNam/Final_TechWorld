import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/screens/checkout_screen/components/confirm.dart';

import 'components/body.dart';

class CheckOut extends StatelessWidget {
  static String routeName = "/checkout";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    print(user);
    return Scaffold(
      appBar: AppBar(
        title: Text("Check out", style: TextStyle(color: Colors.black),),
      ),
      body: Body(user: user,),
      bottomNavigationBar: ConfirmCard(),
    );
  }
}
