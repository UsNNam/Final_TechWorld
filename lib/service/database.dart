import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/Order.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');
  
  Future updateUserData(String? firstName, String? lastName, String? phoneNumber, String? address) async {
    return await userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address
    });
  }

  Map<String, dynamic> documentSnapshotToMap(DocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic> dataMap = snapshot.data() as Map<String, dynamic>;
    return dataMap;
  }
  Future<Map<String,dynamic>> takeUserData() async {
    DocumentSnapshot<Object?> userData = await userCollection.doc(uid).get();
    //print("error nef ku");
    print(documentSnapshotToMap(userData));
    return documentSnapshotToMap(userData);
  }

}

class DatabaseServiceProduct {

  //collection reference
  final CollectionReference productCollection = FirebaseFirestore.instance.collection('Products');

  Future uploadProductData(List<Product> products) async {
    try {
      products.forEach((product) {
        productCollection.doc((product.id).toString()).set(product.convertProductToMap());
        });
    } 
    catch (e) {
      print('Error saving Product: $e');
    }
  }
  
  Future deleteProduct(product) async {
    try {
      productCollection.doc((product.id).toString()).delete();
    } 
    catch (e) {
      print('Error deleting Product: $e');
    }
  }

  Future<List<Product>> getProductsFromFirestore() async {
    try {
      // Retrieve data from Firestore using get()
      QuerySnapshot querySnapshot = await productCollection.get();

      // Convert each document snapshot to a Product object and add to the list
      List<Product> productList = [];
      querySnapshot.docs.forEach((document) {
        var data = document.data() as Map<String, dynamic>;

        // Convert colors list from List<int> to List<Color>
        List<Color> colorsList = (data['colors'] as List<dynamic>).map((colorValue) => Color(colorValue)).toList();

        Product product = Product(
          id: data['id'],
          title: data['title'],
          description: data['description'],
          images: List<String>.from(data['images']),
          colors: colorsList,
          rating: data['rating'],
          price: data['price'],
          isFavourite: data['isFavourite'],
          isPopular: data['isPopular'],
        );

        productList.add(product);
      });

      return productList; // Return the list of Product objects
    } catch (e) {
      print('Error retrieving products from Firestore: $e');
      return []; // Return an empty list if there's an error
    }
  }
}

class DatabaseServiceOrder {
  
  final CollectionReference orderCollection = FirebaseFirestore.instance.collection('Orders');

  Future uploadOrderData(OrderCustom order) async {
    try {
      print("order instance: $orderCollection");
      dynamic tmp = order.convertListItemToUpload();
      dynamic tmp1 = tmp[0];
      print("Order: $tmp1");
      orderCollection.doc().set({
        'id': order.id,
        'uid': order.uid,
        'createAt': (DateTime.now()).toString(),
        'total': order.total,
        'listItem': order.convertListItemToUpload(),
        'address': order.address,
        'status': order.status,
      });
    } 
    catch (e) {
      print('Error saving Order: $e');
    }
  }

  Future<List<Map<String, dynamic>>> loadOrderForUser(String uid) async {
    try {
      QuerySnapshot querySnapshot = await orderCollection.where('uid', isEqualTo: uid).get();
      List<Map<String, dynamic>> result = [];
      querySnapshot.docs.forEach((order) {
        var data = order.data() as Map<String, dynamic>;
        result.add({'address': data['address'], 'createAt': data['createAt'], 'status': data['status'], 'total': data['total'],
        'listItem': data['listItem']});
        
        });
      return result;
    } 
    catch (e) {
      print('Error saving Order: $e');
      return []; // Return an empty list if there's an error
    }
  }
  Future<List<Map<String, dynamic>>> loadOrderForAdmin() async {
    try {
      QuerySnapshot querySnapshot = await orderCollection.get();
      List<Map<String, dynamic>> result = [];
      querySnapshot.docs.forEach((order) {
        var data = order.data() as Map<String, dynamic>;
        result.add({'address': data['address'], 'createAt': data['createAt'], 'status': data['status'], 'total': data['total'],
        'listItem': data['listItem']});
        
        });
      return result;
    } 
    catch (e) {
      print('Error saving Order: $e');
      return []; // Return an empty list if there's an error
    }
  }
}