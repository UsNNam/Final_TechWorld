import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/service/database.dart';

const double tDefaultSize = 20;
const tPrimaryColor = kPrimaryColor;
const double tFormHeight = 50;

class Body extends StatelessWidget {
  const Body({Key? key, required this.user}) : super(key: key);

  final User? user;

  Future<List> takeInfo() async {
  Map<String, dynamic> tmp = await DatabaseService(uid: user?.uid).takeUserData();
  List<String> info = [tmp['address'], tmp['firstName'] + " " + tmp['lastName'],tmp['phoneNumber']];
  return info;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: AssetImage('assets/images/profile_account.png'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: tPrimaryColor),
                      child: const Icon(LineAwesomeIcons.camera, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
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
                          final String address = data[0];
                          final String fullName = data[1];
                          final String phone = data[2];
                          return Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: "Full Name",
                                      labelStyle: TextStyle(color: kTextColor), 
                                      hintText: fullName,
                                      hintStyle: TextStyle(color: kTextColor),
                                      prefixIcon: Icon(LineAwesomeIcons.user, color: kTextColor,)),   
                                ),
                                const SizedBox(height: tFormHeight - 20),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: "Email",
                                      labelStyle: TextStyle(color: kTextColor), 
                                      hintText: user?.email,
                                      hintStyle: TextStyle(color: kTextColor),
                                      prefixIcon: Icon(LineAwesomeIcons.envelope_1, color: kTextColor)),
                                ),
                                const SizedBox(height: tFormHeight - 20),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: "Phone number",
                                      labelStyle: TextStyle(color: kTextColor), 
                                      hintText: phone,
                                      hintStyle: TextStyle(color: kTextColor),
                                      prefixIcon: Icon(LineAwesomeIcons.phone, color: kTextColor)),
                                ),
                                const SizedBox(height: tFormHeight - 20),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: "Address",
                                      labelStyle: TextStyle(color: kTextColor), 
                                      hintText: address,
                                      hintStyle: TextStyle(color: kTextColor),
                                    prefixIcon: const Icon(LineAwesomeIcons.address_card, color: kTextColor),
                                  ),
                                ),
                                const SizedBox(height: tFormHeight),

                                // -- Form Submit Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: tPrimaryColor.withOpacity(0.8),
                                        side: BorderSide.none,
                                        shape: const StadiumBorder()),
                                    child: const Text("Edit profile", style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        
                      }
                      return Text('Loading...');
                  },
                ),
              
            ],
          ),
        ),
      ),
    );
  }
}