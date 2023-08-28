import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';

class ManageOrderAdminScreen extends StatelessWidget {
  static String routeName = "/ManageOrderAdmin";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage All Orders"),
      ),
      body: Body(),
    );
  }
}
