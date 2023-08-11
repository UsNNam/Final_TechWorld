import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/search_result/components/body.dart';
import 'package:shop_app/screens/search_result/search_result_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';


String value_tmp = "";

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    List<int> searchResult = [];
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        onChanged: (value) {
          value_tmp = value;
          print(value_tmp);
          
        },
          // 

        style: TextStyle(color: kSecondaryColor),
        onFieldSubmitted: (value) {
          for(dynamic product in demoProducts){
            
            String search = product.title;
            print(search);
            if((search.toLowerCase()).contains(value_tmp.toLowerCase())){
              searchResult.add(product.id);
              print("Ok $value_tmp");
            }
          }
          Navigator.pushNamed(context, SearchResults.routeName, arguments: searchResult);
          searchResult = [];
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            hintStyle: TextStyle(color: kSecondaryColor),
            prefixIcon: Icon(Icons.search), prefixIconColor: kSecondaryColor),
      ),
    );
  }
}
