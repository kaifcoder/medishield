import 'package:flutter/material.dart';

class Reward {
  final String title;
  final String description;

  Reward({required this.title, required this.description});
}

class RewardScreen extends StatelessWidget {
  // Dummy list of rewards for demonstration purposes
  final List<Reward> rewards = [
    Reward(
        title: 'Discount Coupon',
        description: 'Get 10% off on your next purchase.'),
    Reward(
        title: 'Free Shipping',
        description: 'Enjoy free shipping on your next order.'),
    Reward(
        title: 'Premium Membership',
        description: 'Access exclusive features with our premium membership.'),
  ];

  RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Rewards'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Congratulations! You have earned the following rewards:',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  return RewardCard(reward: rewards[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RewardCard extends StatelessWidget {
  final Reward reward;

  RewardCard({required this.reward});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reward.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              reward.description,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
