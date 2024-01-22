import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/device/device_utility.dart';

class AnimationLoader extends StatelessWidget {
  const AnimationLoader(
      {super.key,
      required this.animation,
      required this.text,
      this.actionText,
      this.showAction = false,
      this.onActionTap});

  final String animation;
  final String text;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 150,
          ),
          Lottie.asset(animation,
              width: TDeviceUtils.getScreenWidth(context) * 0.8),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          showAction
              ? SizedBox(
                  width: 150,
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      actionText!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
