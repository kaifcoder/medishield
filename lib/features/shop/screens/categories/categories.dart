import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';

class CategoiesScreen extends StatelessWidget {
  const CategoiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text('Categoies'),
        showBackArrow: true,
      ),
      body: Center(
        child: Text('Categoies Screen'),
      ),
    );
  }
}
