import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'components/body.dart';

class ProfileAccount extends StatelessWidget {
  static String routeName = "/profileAccount";
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Account"),
      ),
      body: Body(user: user,),
    );
  }
}
