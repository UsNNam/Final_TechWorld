import 'package:flutter/material.dart';

import 'components/body.dart';

class AddVoucherScreen extends StatelessWidget {
  static String routeName = "/addVoucher";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add voucher', style: TextStyle(color: Colors.black),),
      ),
      body: Body(),
    );
  }
}
