import 'package:flutter/material.dart';

import 'package:medishield/features/personalization/controllers/user_controller.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
import 'package:share_plus/share_plus.dart';

class ReferAndEarnScreen extends StatelessWidget {
  const ReferAndEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final referralCode = UserController.instance.user.value.referralCode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refer and Earn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Your Referral Code:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                referralCode!, // Replace with the user's referral code
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Refer friends and earn MediShield Coins!',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Share your referral Code:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement share functionality
                    try {
                      Share.share(
                          'Hey! I am using MediShield and I think you should too. Use my referral code $referralCode to get started and earn MediShield Coins.');
                    } catch (e) {
                      THelperFunctions.showSnackBar(
                          'Error sharing referral code');
                    }
                  },
                  child: const Text('Share Referral Link'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
