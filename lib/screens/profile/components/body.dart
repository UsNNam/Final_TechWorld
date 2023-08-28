import 'package:flutter/material.dart';
import 'package:shop_app/screens/manage_order_admin/manage_order_admin_screen.dart';
import 'package:shop_app/screens/order_list/order_list_screen.dart';
import 'package:shop_app/screens/profile_account/profile_account.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/service/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/screens/order_list/components/body.dart';
import 'package:shop_app/service/database.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    bool isAdmin = user?.email == "namnam@gmail.com";
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.pushNamed(context, ProfileAccount.routeName)
            },
          ),
          ProfileMenu(
            text: "Manage Orders",
            icon: "assets/icons/Order.svg",
            press: () async {
              orderList = await DatabaseServiceOrder().loadOrderForUser(user!.uid);

              if(isAdmin){
                Navigator.pushNamed(context, ManageOrderAdminScreen.routeName);
              }
              else{
                Navigator.pushNamed(context, OrderListScreen.routeName);
              }
            },
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              _auth.logOut();
              print(_auth.user);
              Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
