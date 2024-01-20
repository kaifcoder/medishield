import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text('Search'),
        showBackArrow: true,
      ),
      body: Center(
        child: Text('Search Screen'),
      ),
    );
  }
}
