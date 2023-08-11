import 'package:flutter/material.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'dart:async';

import '../../../constants.dart';
import '../../../size_config.dart';


class ColorDots extends StatelessWidget {
  const ColorDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;


  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    int selectedColor = 3;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            product.colors.length,
            (index) => ColorDot(
              color: product.colors[index],
              isSelected: index == selectedColor,
            ),
          ),
          Spacer(),
          ChangeNumberOfItems(loading: true, product: product),
        ],
      ),
    );
  }
}

class ChangeNumberOfItems extends StatefulWidget {
  const ChangeNumberOfItems({Key? key, required this.loading, required this.product}) : super(key: key);

  final bool loading;
  final Product product;

  @override
  State<ChangeNumberOfItems> createState() => _ChangeNumberOfItemsState();
}

class _ChangeNumberOfItemsState extends State<ChangeNumberOfItems> {
  late bool _updateWidget;

  @override
  void initState() {
    _updateWidget = widget.loading;
  }

  int? takeNumberOfItems(){
    int result = 0;
    demoCarts.forEach((element) {
      if(element.product.id == widget.product.id) {
        result = element.numOfItem;
      }
    });
    return result;
  }
  void plusOneItem(){
    bool inCart = false;
    demoCarts.forEach((element) {
      if(element.product.id == widget.product.id) {
        element.numOfItem += 1;
        inCart = true;
      }
    });
    if(inCart == false){
      demoCarts.add(Cart(product: widget.product, numOfItem: 1));
    }
  }
  void minusOneItem(){
    bool inCart = false;
    demoCarts.forEach((element) {
      if(element.product.id == widget.product.id) {
        element.numOfItem -= 1;
        if(element.numOfItem == 0) demoCarts.remove(element);
        inCart = true;
      }
    });
    if(inCart == false){
      return null;
    }
  }
  void updateWidget(){
    setState(() {
      _updateWidget = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              minusOneItem();
              updateWidget();
            },
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          Text(_updateWidget ? takeNumberOfItems().toString() : '0', style: TextStyle(fontSize: 20),),
          SizedBox(width: getProportionateScreenWidth(10)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              plusOneItem();
              updateWidget();
            },
          )
      ],
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
