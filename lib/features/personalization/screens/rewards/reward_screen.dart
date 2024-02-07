import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Reward {
  final String title;
  final String description;

  Reward({required this.title, required this.description});
}

class RewardScreen extends StatelessWidget {
  // Dummy list of rewards for demonstration purposes
  final List<Reward> rewards = [
    Reward(title: 'Your Medishield Coins', description: '100 MSC'),
  ];

  RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Rewards'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your rewards:',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  return RewardCard(reward: rewards[index]);
                },
              ),
            ),

            // terms and conditions
            const SizedBox(height: 16.0),
            const Text(
              'Terms and conditions:',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              '1. Medishield Coins (MSC) can be used to get discounts on your next purchase.',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              '2. MSC can be earned by referring a friend or purchasing any product.',
              style: TextStyle(
                fontSize: 14.0,
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

  const RewardCard({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reward.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Iconsax.coin5, size: 24.0, color: Colors.orange),
                const SizedBox(width: 8.0),
                Text(reward.description,
                    style: Theme.of(context).textTheme.headlineLarge),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
