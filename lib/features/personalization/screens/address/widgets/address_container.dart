import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medishield/features/personalization/controllers/address_controller.dart';
import 'package:medishield/features/personalization/models/address_model.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

class AddressContainer extends StatelessWidget {
  const AddressContainer({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          width: double.infinity,
          showBorder: true,
          backgroundColor: controller.selectedAddress.value == address
              ? TColors.primary.withOpacity(0.5)
              : TColors.light,
          borderColor: controller.selectedAddress.value == address
              ? TColors.primary
              : TColors.grey,
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
          child: Stack(children: [
            Positioned(
              top: 0,
              right: 1,
              child: Icon(
                Iconsax.tick_circle5,
                color: controller.selectedAddress.value == address
                    ? TColors.primary.withOpacity(0.8)
                    : TColors.light,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: TSizes.sm,
                ),
                Text('+91-${address.mobile}'),
                Text(
                    '${address.address!}, ${address.city!}, ${address.state!}, ${address.country!}, ${address.pincode!}'),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
