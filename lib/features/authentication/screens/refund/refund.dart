import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';

class Refund extends StatelessWidget {
  const Refund({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          '',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pricing & Refunds',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Pricing',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Medishield Healthcare provides custom quotes to the clients. There is no fixed price. Prices are subject to change at any time.',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Refunds',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Like most Medical Companies, Medishield Healthcare cannot issue you a refund for the services that we render. We can provide refunds only in exceptional cases. That will entirely be the company’s call.',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 20.0),
            // Add more Text widgets for the remaining terms and conditions
          ],
        ),
      ),
    );
  }
}
