import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/add_product/add_product_screen.dart';
import 'package:shop_app/screens/all_product/all_product.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/home/components/search_field.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/order_list/order_list_screen.dart';
import 'package:shop_app/screens/order_tracker/order_tracker.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/profile_account/profile_account.dart';
import 'package:shop_app/screens/search_result/search_result_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/screens/checkout_screen/check_out.dart';
import 'package:shop_app/screens/search_result/search_result_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  CheckOut.routeName: (context) => CheckOut(),
  OrderTrackerScreen.routeName:(context) => OrderTrackerScreen(),
  AllProducts.routeName:(context) => AllProducts(),
  ProfileAccount.routeName:(context) => ProfileAccount(),
  SearchResults.routeName:(context) => SearchResults(),
  AddProduct.routeName:(context) => AddProduct(),
  OrderListScreen.routeName:(context) => OrderListScreen(),
  
};
