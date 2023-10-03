import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/Order.dart';
import 'package:http/http.dart' as http;

String serverAddress = '192.168.1.7:5000';

class DatabaseService {

  final String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');
  
  Future updateUserData(String? firstName, String? lastName, String? phoneNumber, String? address) async {
    var url = Uri.http(serverAddress, '/users/update');
    dynamic response = await http.post(url, body: {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address
    });
    print("Response update user data ${response.body}");
    // return await userCollection.doc(uid).set({
    //   'firstName': firstName,
    //   'lastName': lastName,
    //   'phoneNumber': phoneNumber,
    //   'address': address
    // });
  }

  Map<String, dynamic> documentSnapshotToMap(DocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic> dataMap = snapshot.data() as Map<String, dynamic>;
    return dataMap;
  }
  Future<Map<String,dynamic>> takeUserData() async {
    // DocumentSnapshot<Object?> userData = await userCollection.doc(uid).get();

    var url = Uri.http(serverAddress, '/users/${uid}');
    dynamic response = await http.get(url);
    print("response ${response.body}");
    return json.decode(response.body);

    // print(documentSnapshotToMap(userData));
    // return documentSnapshotToMap(userData);
  }

}

class DatabaseServiceProduct {

  //collection reference
  final CollectionReference productCollection = FirebaseFirestore.instance.collection('Products');

  Future uploadProductDataFirestore(List<Product> products) async {
    try {
      products.forEach((product) {
        productCollection.doc((product.id).toString()).set(product.convertProductToMap());
        });
    } 
    catch (e) {
      print('Error saving Product: $e');
    }
  }
  Future addNewProductData(Product product) async {
    try {
      var url = Uri.http(serverAddress, 'products/update');       
      dynamic response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: json.encode(product.convertProductToMap()));
      print('Response body: ${response.body}');
    } 
    catch (e) {
      print('Error saving Product: $e');
    }
  }

  Future uploadProductData(List<Product> products) async {
    try {
      products.forEach((product) async {
        // productCollection.doc((product.id).toString()).set(product.convertProductToMap());
        var url = Uri.http(serverAddress, 'products/update');
        
        dynamic response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: json.encode(product.convertProductToMap()));
        // print('Response status: ${json.encode(product.convertProductToMap())}');
        print('Response body: ${response.body}');
      });
    } 
    catch (e) {
      print('Error saving Product: $e');
    }
  }
  
  Future deleteProduct(product) async {
    try {
      // productCollection.doc((product.id).toString()).delete();
      var url = Uri.http(serverAddress, 'products/delete');
      dynamic response = await http.post(url, body: {'id': (product.id).toString()});
      print('Response body: ${response.body}');
    } 
    catch (e) {
      print('Error deleting Product: $e');
    }
  }

  Future<List<Product>> getProductsFromFirestore() async {
    try {
    
      var url = Uri.http(serverAddress, 'products');
      dynamic response = await http.get(url);
      List listProductData = json.decode(response.body);
      print("Product list${listProductData}");

      // Convert each document snapshot to a Product object and add to the list
      List<Product> productList = [];
      listProductData.forEach((document) {
        
        Map<String,dynamic> data = json.decode(document);
        // print("data ${data}");
        // print(data.runtimeType);
        // print("data image type ${data['images'].runtimeType}");
        // Convert colors list from List<int> to List<Color>
        List<Color> colorsList = (data['colors'] as List<dynamic>).map((colorValue) => Color(colorValue)).toList();
        double ratingTmp = data['rating']*1.0;
        double priceTmp = data['price']*1.0;
        Product product = Product(
          id: data['id'],
          title: data['title'],
          description: data['description'],
          images: List<String>.from(data['images']),
          colors: colorsList,
          rating: ratingTmp,
          price: priceTmp,
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
      var url = Uri.http(serverAddress, 'orders/create');
      dynamic response = await http.post(url, headers: {'Content-Type': 'application/json'} ,  body: json.encode({
        'id': order.id,
        'uid': order.uid,
        'createAt': (DateTime.now()).toString(),
        'total': order.total,
        'listItem': order.convertListItemToUpload(),
        'address': order.address,
        'status': order.status,
      }));
      print("Response upload order: ${response.body}");
      // orderCollection.doc().set({
      //   'id': order.id,
      //   'uid': order.uid,
      //   'createAt': (DateTime.now()).toString(),
      //   'total': order.total,
      //   'listItem': order.convertListItemToUpload(),
      //   'address': order.address,
      //   'status': order.status,
      // });
    } 
    catch (e) {
      print('Error saving Order: $e');
    }
  }

  Future<List> loadOrderForUser(String uid) async {
    try {
      // QuerySnapshot querySnapshot = await orderCollection.where('uid', isEqualTo: uid).get();
      // List<Map<String, dynamic>> result = [];
      var url = Uri.http(serverAddress, 'orders/${uid}');
      dynamic response = await http.get(url);
      
      return json.decode(response.body);
    } 
    catch (e) {
      print('Error saving Order: $e');
      return []; // Return an empty list if there's an error
    }
  }
  Future<List> loadOrderForAdmin() async {
    try {
      // QuerySnapshot querySnapshot = await orderCollection.get();
      // List<Map<String, dynamic>> result = [];
      // querySnapshot.docs.forEach((order) {
      //   var data = order.data() as Map<String, dynamic>;
      //   result.add({'address': data['address'], 'createAt': data['createAt'], 'status': data['status'], 'total': data['total'],
      //   'listItem': data['listItem']});
        var url = Uri.http(serverAddress, 'orders/admin');
        dynamic response = await http.get(url);
        
        return json.decode(response.body);
        // });
      // return result;
    } 
    catch (e) {
      print('Error saving Order: $e');
      return []; // Return an empty list if there's an error
    }
  }
}