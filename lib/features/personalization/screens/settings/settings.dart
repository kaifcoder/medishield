import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medihealth/common/widgets/appbar/appbar.dart';
import 'package:medihealth/common/widgets/custom_shapes/containers/t_primary_header_container.dart';
import 'package:medihealth/common/widgets/list_tile/settings_menu_tile.dart';
import 'package:medihealth/common/widgets/text/t_section_heading.dart';
import 'package:medihealth/features/personalization/screens/profile/profile.dart';
import 'package:medihealth/utils/constants/sizes.dart';

import 'widgets/t_user_profile_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   toolbarHeight: TDeviceUtils.getAppBarHeight() + 120,
      //   backgroundColor: Colors.transparent,
      //   flexibleSpace: TPrimaryHeaderContainer(
      //     child: Column(
      //       children: [
      //         TAppBar(
      //           title: Text(
      //             'Account',
      //             style: Theme.of(context).textTheme.headlineMedium!.apply(
      //                   color: Colors.white,
      //                 ),
      //           ),
      //         ),
      //         TUserProfileTile(),
      //         const SizedBox(
      //           height: TSizes.spaceBtwSections,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
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
                    onTap: () => Get.to(() => const ProfileScreen()),
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
                  const TSectionHeading(title: 'Account Settings'),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Address',
                    subtitle: 'Add or change your address',
                    onTap: () {},
                  ),
                  const SettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: 'My Cart',
                      subtitle: 'Add, remove products and move to checkout'),
                  const SettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: 'My Orders',
                      subtitle: 'In-progress and Completed Orders'),
                  // SettingsMenuTile(
                  //     icon: Iconsax.bank,
                  //     title: 'Bank Account',
                  //     subtitle: 'Withdraw balance to registered bank account'),
                  // SettingsMenuTile(
                  //     icon: Iconsax.discount_shape,
                  //     title: 'My Coupons',
                  //     subtitle: 'List of all the discounted coupons'),
                  const SettingsMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subtitle: 'Set any kind of notification message'),
                  // SettingsMenuTile(
                  //     icon: Iconsax.security_card,
                  //     title: 'Account Privacy',
                  //     subtitle: 'Manage data usage and connected accounts'),

                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const TSectionHeading(title: 'App Settings'),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Dark Mode',
                    subtitle: 'Enable or disable dark mode',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {},
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
