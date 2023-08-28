import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';



class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _voucherController = TextEditingController();

  void _submitVoucher() {
    String voucherCode = _voucherController.text;
    print('Submitted Voucher Code: $voucherCode');
    Navigator.pushReplacementNamed(context, CartScreen.routeName, arguments: voucherCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              style: TextStyle(color: kTextColor),
              controller: _voucherController,
              decoration: InputDecoration(
                labelText: 'Voucher Code',
                labelStyle: TextStyle(color: kTextColor)
                
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitVoucher,
              child: Text('Submit'),
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
