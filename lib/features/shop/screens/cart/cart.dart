import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text('Cart'),
        showBackArrow: true,
      ),
      body: Center(
        child: Text('Cart Screen'),
      ),
    );
  }
}
