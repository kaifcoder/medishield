import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medihealth/utils/constants/sizes.dart';
import 'package:medihealth/utils/device/device_utility.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar(
      {super.key,
      this.title,
      this.showBackArrow = false,
      this.leadingIcon,
      this.actions,
      this.onLeadingIconPressed});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? onLeadingIconPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
          automaticallyImplyLeading: false,
          leading: showBackArrow
              ? IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Iconsax.arrow_left),
                )
              : leadingIcon != null
                  ? IconButton(
                      onPressed: onLeadingIconPressed,
                      icon: Icon(leadingIcon),
                    )
                  : null,
          title: title,
          actions: actions),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
