import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Login'),
              const SizedBox(
                height: 10,
              ),
              const Text('Login Form'),
              const SizedBox(
                height: 10,
              ),
              const Text('Divider'),
              const SizedBox(
                height: 10,
              ),
              const Text('Login Footer'),
            ],
          ),
        ),
      ),
    );
  }
}
