import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/images/t_circular_image.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/features/personalization/screens/profile/change_name.dart';
import 'package:medishield/features/personalization/screens/profile/change_phone.dart';
import 'package:medishield/features/personalization/controllers/user_controller.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/sizes.dart';

import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
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
                    Obx(
                      () => TextButton(
                        onPressed: () {},
                        child: Text('Hello ${controller.user.value.fullName}'),
                      ),
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
              const TSectionHeading(title: 'Profile Information'),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              Obx(
                () => ProfileMenu(
                  onTap: () => Get.to(() => ChangeName(
                      firstName: controller.user.value.firstName!,
                      lastName: controller.user.value.lastName!)),
                  title: 'Name',
                  value: controller.user.value.fullName,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Obx(
                () => ProfileMenu(
                  onTap: () {
                    //copy the value to clipboard
                    Clipboard.setData(
                      ClipboardData(text: controller.user.value.email!),
                    );
                    Get.snackbar(
                      'Email Copied',
                      'Email copied to clipboard',
                      snackPosition: SnackPosition.BOTTOM,
                      margin: const EdgeInsets.all(10),
                    );
                  },
                  title: 'Email',
                  value: controller.user.value.email!,
                  icon: Iconsax.copy,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Obx(
                () => ProfileMenu(
                  onTap: () => Get.to(
                      () => ChangePhone(phone: controller.user.value.mobile!)),
                  title: 'Phone Number',
                  value: controller.user.value.formattedMobile,
                ),
              ),

              // ProfileMenu(
              //   onTap: () {},
              //   title: 'Address',
              //   value: ,
              // ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
