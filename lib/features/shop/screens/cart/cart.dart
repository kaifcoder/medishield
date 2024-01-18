import 'package:flutter/material.dart';
import 'package:medihealth/common/widgets/appbar/appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
