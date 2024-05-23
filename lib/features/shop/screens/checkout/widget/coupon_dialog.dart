import 'package:flutter/material.dart';

class CouponDialog extends StatelessWidget {
  const CouponDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // create a container for bottom sheet
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Enter Coupon Code',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}
