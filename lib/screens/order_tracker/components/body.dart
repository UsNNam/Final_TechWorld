import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:shop_app/models/Product.dart';

class Body extends StatefulWidget {
  
  final Map order;

  const Body({Key? key, required this.order}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Map _order;
  ///this TextDto present in a package add data in this dto and set in a list.
  List<TextDto> orderInfo = [];

  @override
  void initState() {
    super.initState();
    _order = widget.order;
    _initializeorderInfo();
  }

  void _initializeorderInfo() {
    List listItem = _order['listItem'];
    int index = 0;
    orderInfo.add(TextDto("Your order has been created at ", _order['createAt']));
    orderInfo.add(TextDto("Address", _order['address']));
    
    while(index < listItem.length){
      if(index % 2 == 0){
        String? productName;
        demoProducts.forEach((element) {
          if(element.id == listItem[index]){
            productName = element.title;
          }
        });
        int indexItem = (index + 2) ~/ 2 ;
        String quantity = listItem[index].toString();
        orderInfo.add(TextDto("Item $indexItem", productName! + " x " + quantity));
      }
      index += 2;
    }
    orderInfo.add(TextDto("Total", _order['total']));
    // Add more items to orderInfo as needed
  }



  @override
  Widget build(BuildContext context) {
    String status = _order['status'];
    Status curState = Status.order;
    if(status == "Confirmed"){
      curState = Status.order;
    }
    else if(status == "Delivered"){
      curState = Status.delivered;
    }
    else if(status == "Packaging"){
      curState = Status.shipped;
    }
    else if(status == "Shipping"){
      curState = Status.outOfDelivery;
    }
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: OrderTracker(
          status: curState,
          activeColor: Colors.blue,
          inActiveColor: Colors.grey[300],
          orderTitleAndDateList: orderInfo,
        ),
      ),
    );
  }
}