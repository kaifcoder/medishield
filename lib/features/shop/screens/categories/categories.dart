import 'package:flutter/material.dart';
import 'package:medihealth/common/widgets/appbar/appbar.dart';

class CategoiesScreen extends StatelessWidget {
  const CategoiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
