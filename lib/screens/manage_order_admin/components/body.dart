import 'package:flutter/material.dart';

class Order {
  final String id;
  final String status;

  Order(this.id, this.status);
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Filter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrderListScreen(),
    );
  }
}

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  String selectedFilter = 'All';
  List<Order> orders = [
    Order('1', 'Pending'),
    Order('2', 'Processing'),
    Order('3', 'Completed'),
    // ... Add more orders
  ];

  List<Order> get filteredOrders {
    if (selectedFilter == 'All') {
      return orders;
    } else {
      return orders.where((order) => order.status == selectedFilter).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage All Orders'),
      ),
      body: Column(
        children: [
          ToggleButtons(
            children: [
              Text('All'),
              Text('Pending'),
              Text('Processing'),
              Text('Completed'),
            ],
            isSelected: [
              selectedFilter == 'All',
              selectedFilter == 'Pending',
              selectedFilter == 'Processing',
              selectedFilter == 'Completed',
            ],
            onPressed: (index) {
              setState(() {
                selectedFilter = ['All', 'Pending', 'Processing', 'Completed'][index];
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Order ${filteredOrders[index].id}'),
                  subtitle: Text('Status: ${filteredOrders[index].status}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
