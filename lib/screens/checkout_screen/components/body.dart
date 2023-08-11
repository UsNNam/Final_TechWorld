import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/screens/checkout_screen/components/order_summary.dart';
import 'package:shop_app/service/database.dart';
import 'package:shop_app/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../size_config.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/screens/cart/components/cart_card.dart';



class Body extends StatelessWidget {
  
  final User? user;

  const Body({Key? key, required this.user}) : super(key: key);

  Future<List> takeInfo() async {
    Map<String, dynamic> tmp = await DatabaseService(uid: user?.uid).takeUserData();
    List<String> info = [tmp['address'], tmp['firstName'] + " " + tmp['lastName'],tmp['phoneNumber']];
    return info;
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.black,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: 
            Padding(padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,),
                    child: Text('Deliver to', style: TextStyle(fontSize: 20, color: kTextColor, fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child: Stack(
                      children: [
                        Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4.0,
                        shadowColor: Colors.white.withOpacity(0.5),
                        color: Colors.white.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              FutureBuilder<List>(
                                future: takeInfo(),
                                builder: (context, snapshot){
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      // If we got an error
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                            '${snapshot.error} occurred',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        );
                                        
                                        // if we got our data
                                      } else if (snapshot.hasData) {
                                        // Extracting data from snapshot object
                                        final data = snapshot.data as List;
                                        final address = data[0];
                                        final fullName = data[1];
                                        final phone = data[2];
                                        return Center(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 12),
                                                child: Text(
                                                  '$address',
                                                  style: TextStyle(fontSize: 16, color: kPrimaryColor, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('$fullName', style: TextStyle(color: kTextColor),),
                                                  Text('$phone', style: TextStyle(color: kTextColor)),
                                                ],
                                              )
                              
                                            ],
                                          ),
                                        );
                                      }
                                      
                                    }
                                    return Text('Loading...');
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 5,
                        bottom: 0,            
                        child: Icon(
                            FontAwesomeIcons.angleRight,
                            color: Color.fromARGB(59, 79, 79, 79),
                          )
                        )
                      ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Payment', style: TextStyle(fontSize: 20, color: kTextColor, fontWeight: FontWeight.bold),),
                  ),
                  SelectionCard(),
                  Container(
                    height: 400,                   
                    child: OrderSummary()
                    ),
                ],
              ) 
            ),
          ),
        ),
      ) 
    );
  }

}

class SelectionCard extends StatefulWidget {
  @override
  _SelectionCardState createState() => _SelectionCardState();
}

class _SelectionCardState extends State<SelectionCard> {
  int _selectedRadioValue = 1; // Specify the type explicitly

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Replace with your desired width
      height: 200, // Replace with your desired height
      child: Card(
        color: Colors.white.withOpacity(0.1),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            SizedBox(height: 12,),
            _buildRadioListTileWithImage(
              imagePath: 'assets/images/VNPay.png', // Replace with your image path
              title: 'VNPay',
              value: 1,
            ),
            _buildRadioListTileWithImage(
              imagePath: 'assets/images/Momo.png', // Replace with your image path
              title: 'Momo e-wallet',
              value: 2,
            ),
            _buildRadioListTileWithImage(
              imagePath: 'assets/images/PayInCash.jpg', // Replace with your image path
              title: 'Pay in cash',
              value: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioListTileWithImage({
    required String imagePath,
    required String title,
    required int value,
  }) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: kTextColor),
      child: RadioListTile(
        title: Row(
          children: [
            Image.asset(
              imagePath,
              width: 30, // Adjust the width of the image as needed
              height: 30, // Adjust the height of the image as needed
            ),
            SizedBox(width: 16), // Add some spacing between image and text
            Text(title, style: TextStyle(color: kTextColor),),
          ],
        ),
        value: value,
        groupValue: _selectedRadioValue,
        onChanged: (newValue) {
          setState(() {
            _selectedRadioValue = newValue as int; // Cast the value to 'int'
          });
        },
      ),
    );
  }
}
