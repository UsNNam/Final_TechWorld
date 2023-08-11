import 'package:flutter/material.dart';
import 'package:shop_app/components/no_account_text.dart';
import 'package:shop_app/components/socal_card.dart';
import 'package:shop_app/constants.dart';
import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight*0.15,
                  child: Stack(
                    children: [
                      Center(
                      child: Image.asset("assets/images/image_sign_in.jpg",
                        fit: BoxFit.cover,
                        width: screenWidth,
                        ),     
                      ),
                      Align(
                        alignment: Alignment(0, 1),
                        child: Text('TechWorld', style: TextStyle(fontSize: screenWidth*0.18, color: Color.fromARGB(255, 247, 247, 247),fontFamily: 'Adlery'),)
                      ),
                    ]
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text(
                  "Welcome to TechWorld",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),

                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
