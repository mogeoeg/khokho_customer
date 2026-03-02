import 'package:ev/view/my_order/widgets/tab_lists.dart';
import 'package:flutter/material.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Order"),
        automaticallyImplyLeading: false,
      ),
      body: const OrderListTab(),
    );
  }
}
