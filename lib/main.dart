import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/service/auth.dart';
import 'package:shop_app/theme.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/service/database.dart';
import 'package:shop_app/models/Product.dart';
import 'package:http/http.dart' as http;



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // addProductToShop();
  // await DatabaseServiceProduct().uploadProductDataFirestore(demoProducts1);
  

  demoProducts = await DatabaseServiceProduct().getProductsFromFirestore();
  // Product test = Product(id: 12, images: ["123"], title: "titile", price: 123.2, description: "Khong co");
  // print(test.colors[0].value);
  // print(demoProducts[0].colors);
  // print(json.encode(demoProducts[0].convertProductToMap()));
  print("Demo products: ${demoProducts}");

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        // home: SplashScreen(),
        // We use routeName so that we dont need to remember the name
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}
