import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/images/t_circular_image.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/sizes.dart';

import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text(
          'Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///profile image
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const TCircularImage(
                      image: TImages.user,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Hello Username'),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const TSectionHeading(title: 'Profile Imformation'),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              ProfileMenu(
                onTap: () {},
                title: 'First Name',
                value: 'John',
              ),
              ProfileMenu(
                onTap: () {},
                title: 'Last Name',
                value: 'Doe',
              ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              const TSectionHeading(title: 'Profile Imformation'),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              ProfileMenu(
                onTap: () {},
                title: 'Email',
                value: 'John Doe',
              ),
              ProfileMenu(
                onTap: () {},
                title: 'Phone Number',
                value: 'John Doe',
              ),

              ProfileMenu(
                onTap: () {},
                title: 'Address',
                value: 'John Doe',
              ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
