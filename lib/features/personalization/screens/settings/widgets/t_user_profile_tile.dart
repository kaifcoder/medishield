import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/images/t_circular_image.dart';
import 'package:medishield/common/widgets/loaders/custom_shimmer.dart';
import 'package:medishield/features/shop/controllers/user_controller.dart';
import 'package:medishield/utils/constants/image_strings.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: const TCircularImage(
        image: TImages.user,
        height: 50,
        width: 50,
      ),
      title: Obx(() {
        if (controller.userLoading.value) {
          return const CustomShimmer(height: 15, width: 80);
        } else {
          return Text(
            controller.user.value.fullName,
            style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: Colors.white,
                ),
          );
        }
      }),
      subtitle: Obx(() {
        if (controller.userLoading.value) {
          return const CustomShimmer(height: 15, width: 80);
        } else {
          return Text(
            controller.user.value.email!,
            style: Theme.of(context).textTheme.labelMedium!.apply(
                  color: Colors.white,
                ),
          );
        }
      }),
      trailing: IconButton(
        onPressed: onTap,
        icon: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
