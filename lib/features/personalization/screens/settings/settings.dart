import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/t_primary_header_container.dart';
import 'package:medishield/common/widgets/list_tile/settings_menu_tile.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/personalization/screens/address/address.dart';
import 'package:medishield/features/personalization/screens/profile/profile.dart';
import 'package:medishield/features/shop/screens/cart/cart.dart';
import 'package:medishield/features/shop/screens/orders/orders.dart';
import 'package:medishield/utils/constants/sizes.dart';

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
                    onTap: () => Get.to(() => const AddressScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'Add, remove products and move to checkout',
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed Orders',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  // SettingsMenuTile(
                  //     icon: Iconsax.bank,
                  //     title: 'Bank Account',
                  //     subtitle: 'Withdraw balance to registered bank account'),
                  // SettingsMenuTile(
                  //     icon: Iconsax.discount_shape,
                  //     title: 'My Coupons',
                  //     subtitle: 'List of all the discounted coupons'),

                  // SettingsMenuTile(
                  //     icon: Iconsax.security_card,
                  //     title: 'Account Privacy',
                  //     subtitle: 'Manage data usage and connected accounts'),

                  const SizedBox(height: TSizes.spaceBtwSections),
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
