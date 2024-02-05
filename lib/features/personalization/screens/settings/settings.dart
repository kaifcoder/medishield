import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/t_primary_header_container.dart';
import 'package:medishield/common/widgets/list_tile/settings_menu_tile.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/authentication/screens/login/login.dart';
import 'package:medishield/features/personalization/screens/address/address.dart';
import 'package:medishield/features/personalization/screens/contact/contact_us.dart';
import 'package:medishield/features/personalization/screens/profile/profile.dart';
import 'package:medishield/features/personalization/screens/referral/referral_screen.dart';
import 'package:medishield/features/personalization/screens/rewards/reward_screen.dart';
import 'package:medishield/features/shop/screens/cart/cart.dart';
import 'package:medishield/features/shop/screens/orders/orders.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'widgets/t_user_profile_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isguest =
        AuthenticationRepository.instance.deviceStorage.read('guest');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.headlineMedium!.apply(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  TUserProfileTile(
                    onTap: () {
                      if (isguest == true) {
                        Get.to(() => const LoginScreen());
                      } else {
                        Get.to(() => const ProfileScreen());
                      }
                    },
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: Column(
                children: [
                  if (isguest == true)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => Get.to(() => const LoginScreen()),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const TSectionHeading(title: 'Account Settings'),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Address',
                    subtitle: 'Add or change your address',
                    onTap: () {
                      if (isguest == true) {
                        Get.to(() => const LoginScreen());
                      } else {
                        Get.to(() => const AddressScreen());
                      }
                    },
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'Add, remove products and move to checkout',
                    onTap: () {
                      if (isguest == true) {
                        Get.to(() => const LoginScreen());
                      } else {
                        Get.to(() => const CartScreen());
                      }
                    },
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed Orders',
                    onTap: () {
                      if (isguest == true) {
                        Get.to(() => const LoginScreen());
                      } else {
                        Get.to(() => const OrderScreen());
                      }
                    },
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.gift,
                    title: 'My Rewards',
                    subtitle: 'Check your rewards and points',
                    onTap: () {
                      if (isguest == true) {
                        Get.to(() => const LoginScreen());
                      } else {
                        Get.to(() => RewardScreen());
                      }
                    },
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.people,
                    title: 'Refer & Earn',
                    subtitle: 'Refer your friends and earn rewards',
                    onTap: () {
                      if (isguest == true) {
                        Get.to(() => const LoginScreen());
                      } else {
                        Get.to(() => const ReferAndEarnScreen());
                      }
                    },
                  ),
                  SettingsMenuTile(
                    icon: Icons.help_outline,
                    title: 'Contact Support',
                    subtitle: 'Chat with our support team',
                    onTap: () => Get.to(() => ContactScreen()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  if (isguest != true)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () =>
                              AuthenticationRepository.instance.logout(),
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.red),
                          )),
                    ), // SizedBox
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
