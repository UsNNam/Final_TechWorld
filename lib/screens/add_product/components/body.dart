import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/all_product/all_product.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/models/Product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/service/database.dart';


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey1 = GlobalKey<FormState>();
  int? id;
  String? title, description;
  List<String> images = [];
  double? rating, price;
  bool? isFavourite, isPopular;
  List<Widget> inputFields = [];

 

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey1,
      child: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              TextFormField(
                style: TextStyle(color: kTextColor),
                onSaved: (newValue) => title = newValue!,
                decoration: InputDecoration(
                  labelText: "Title of product:",
                  hintText: "Input title of product...",
                  labelStyle: TextStyle(color: kTextColor),
                  hintStyle: TextStyle(color: kTextColor),
      
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              TextFormField(
                style: TextStyle(color: kTextColor),
                onSaved: (newValue) => description = newValue!,
                decoration: InputDecoration(
                  labelText: "Description of product:",
                  hintText: "Input description of product...",
                  labelStyle: TextStyle(color: kTextColor),
                  hintStyle: TextStyle(color: kTextColor),
      
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              TextFormField(
                style: TextStyle(color: kTextColor),
                onSaved: (newValue){
                  print("New value: $newValue");
                  images.add(newValue!);
                  print("abc");
                  print(images);
                },
                decoration: InputDecoration(
                  labelText: "Image of product:",
                  hintText: "Input Image address of product...",
                  labelStyle: TextStyle(color: kTextColor),
                  hintStyle: TextStyle(color: kTextColor),
      
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(8)),
              Column(
                children: inputFields,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    inputFields.add(buildInputField());
                  });
                },
                child: Text('Add More Image'),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              TextFormField(
                style: TextStyle(color: kTextColor),
                onSaved: (newValue) {
                  double tmp = double.parse(newValue!);
                  price = tmp;
                  print("Price : $price");
                },
                decoration: InputDecoration(
                  labelText: "Price of product:",
                  hintText: "Input Price of product...",
                  labelStyle: TextStyle(color: kTextColor),
                  hintStyle: TextStyle(color: kTextColor),
      
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              DefaultButton(
                text: "Add Product",
                press: () async {
                  _formKey1.currentState!.save();
                  print("id: $id");
                  print("image: $images");
                  print("title: $title");
                  print("price: $price");
                  print("description: $description");
                  Product tmp = Product(id: demoProducts.length + 1, images: images, 
                  colors: [
                    Color(0xFFF6625E),
                    Color(0xFF836DB8),
                    Color(0xFFDECB9C),
                    Colors.white,
                  ], title: title!, price: price!, description: description!);
                  demoProducts1.add(tmp);
                  print("OK0");
                  await DatabaseServiceProduct().addNewProductData(tmp);
                  print("OK1");
                  demoProducts = await DatabaseServiceProduct().getProductsFromFirestore();
                  print("OK2");
                  Navigator.pushNamed(context, AllProducts.routeName);
                },
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
            ],
          ),
      ),
    );
  }
  Widget buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(color: kTextColor),
        onSaved: (link) => images.add(link!),
        decoration: InputDecoration(
          hintText: 'Enter image Address...',
          hintStyle: TextStyle(color: kTextColor),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}