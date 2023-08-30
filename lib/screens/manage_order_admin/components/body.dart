import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/order_info_for_admin/order_info_for_admin_screen.dart';

List orderListAdmin = [];

class Order {
  final String id;
  final String status;

  Order(this.id, this.status);
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrderListScreenAdmin();
  }
}

class OrderListScreenAdmin extends StatefulWidget {
  @override
  _OrderListScreenAdminState createState() => _OrderListScreenAdminState();
}

class _OrderListScreenAdminState extends State<OrderListScreenAdmin> {
  String selectedFilter = 'All';
  List<Order> orders = [
    // ... Add more orders
  ];
  void createOrderListAdmin(){
    orders = [];
    orderListAdmin.forEach((element) {
      orders.add(Order((orders.length + 1).toString(), element['status']));
    });
    print("orderlist admin: $orders");
  }

  List<Order> get filteredOrders {
    if (selectedFilter == 'All') {
      return orders;
    } else {
      return orders.where((order) => order.status == selectedFilter).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    createOrderListAdmin();
    return Scaffold(
      body: Column(
        children: [
          ToggleButtons(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('All', style: TextStyle(color: _getTextColor('All')),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Confirmed', style: TextStyle(color: _getTextColor('Confirmed')),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Packaging', style: TextStyle(color: _getTextColor('Packaging')),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Shipping', style: TextStyle(color: _getTextColor('Shipping')),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Delivered', style: TextStyle(color: _getTextColor('Delivered')),),
              ),
            ],
            isSelected: [
              selectedFilter == 'All',
              selectedFilter == 'Confirmed',
              selectedFilter == 'Packaging',
              selectedFilter == 'Shipping',
              selectedFilter == 'Delivered',
            ],
            onPressed: (index) {
              setState(() {
                selectedFilter = ['All', 'Confirmed', 'Packaging', 'Shipping', 'Delivered'][index];
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                return ButtonOrder(index: index, status: filteredOrders[index].status);
              },
            ),
          ),
        ],
      ),
    );
  }
  Color _getTextColor(String filter) {
  // Define the colors based on the filter status
  if (filter == selectedFilter) {
    return Colors.blue; // Change this to the desired selected color
  } else {
    return kTextColor; // Use your default text color here
  }
}
}



class ButtonOrder extends StatelessWidget {
  final int index;
  final String status;

  const ButtonOrder({
    required this.index, required this.status,
  });

  @override
  Widget build(BuildContext context) {
    int tmpIndex = index + 1;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, OrderInfoForAdminScreen.routeName, arguments: orderListAdmin[index]);
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Text(
                'Order $tmpIndex',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('Status: $status'),
            ],
          ),
        ),
      ),
    );
  }
}
