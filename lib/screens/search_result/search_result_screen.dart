import 'package:flutter/material.dart';

import 'components/body.dart';

class SearchResults extends StatelessWidget {
  static String routeName = "/searchResults";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results', style: TextStyle(color: Colors.black),),
      ),
      body: Body(),
    );
  }
}
