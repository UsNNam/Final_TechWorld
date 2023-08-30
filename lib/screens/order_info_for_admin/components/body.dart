import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';


class Body extends StatelessWidget {
  final Map data;

  const Body({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int defaultValue = 0;
    if(data['status'] == 'Confirmed'){
      defaultValue = 1;
    }
    else if (data['status'] == 'Packaging'){
      defaultValue = 2;
      print('aaa');
    }
    else if (data['status'] == 'Shipping'){
      defaultValue = 3;
    }
    else if (data['status'] == 'Delivered'){
      defaultValue = 4;
    }
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Address: ${data['address']}', style: TextStyle(fontSize: 18),),
            Divider(),
            Text('Create At: ${data['createAt']}', style: TextStyle(fontSize: 18),),
            Divider(),
            Text('Status: ${data['status']}', style: TextStyle(fontSize: 18),),
            Divider(),
            Text('Total: ${data['total']}', style: TextStyle(fontSize: 18),),
            Divider(),
            Text('List Items: ${data['listItem']}', style: TextStyle(fontSize: 18),),
            Divider(),
            StatusOrder(defaultSelectedValue: defaultValue,),
          ],
        ),
      );
  }
}

class StatusOrder extends StatefulWidget {
  final int defaultSelectedValue; // Add this variable

  StatusOrder({required this.defaultSelectedValue});
  
  @override
  _StatusOrderState createState() => _StatusOrderState();
}

class _StatusOrderState extends State<StatusOrder> {
  int? selectedValue; // Default selected value

  @override
  void initState() {
    super.initState();
    selectedValue = widget.defaultSelectedValue; // Set the default value in initState
  }

  void setSelectedValue(int? value) {
    setState(() {
      selectedValue = value;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: kTextColor),
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RadioListTile<int?>(
                title: Text('Confirmed', style: TextStyle(color: kTextColor),),
                value: 1,
                groupValue: selectedValue,
                onChanged: setSelectedValue,
              ),
              RadioListTile<int?>(
                title: Text('Packaging', style: TextStyle(color: kTextColor),),
                value: 2,
                groupValue: selectedValue,
                onChanged: setSelectedValue,
              ),
              RadioListTile<int?>(
                title: Text('Shipping', style: TextStyle(color: kTextColor),),
                value: 3,
                groupValue: selectedValue,
                onChanged: setSelectedValue,
              ),
              RadioListTile<int?>(
                title: Text('Delivered', style: TextStyle(color: kTextColor),),
                value: 4,
                groupValue: selectedValue,
                onChanged: setSelectedValue,
              ),
            ],
          ),
        ),
    );

  }
}







