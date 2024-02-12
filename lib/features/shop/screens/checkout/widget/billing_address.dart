import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/features/authentication/models/user.dart';
import 'package:medishield/features/personalization/models/address_model.dart';
import 'package:medishield/features/personalization/screens/address/address.dart';
import 'package:medishield/features/personalization/screens/address/widgets/address_form.dart';
import 'package:medishield/utils/constants/sizes.dart';

class BillingAddress extends StatelessWidget {
  const BillingAddress(
      {super.key,
      required this.showButton,
      required this.user,
      required this.address});

  final bool showButton;
  final UserModel user;
  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    if (address.address == null) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const TSectionHeading(title: 'shipping Address'),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Text(
          'No Address Found',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          ),
          onPressed: () {
            // open modal to add address
            Get.bottomSheet(
              const SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: Column(
                  children: [
                    TSectionHeading(title: 'Add Address'),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    AddressForm(),
                  ],
                ),
              ),
              isScrollControlled: true,
              backgroundColor: Colors.white,
              // remove bottom rounded corner
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Iconsax.add, size: 16),
              const SizedBox(
                width: TSizes.sm,
              ),
              Text('Add Address', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ]);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'change',
          onButtonPressed: () {
            // open modal to change address
            Get.bottomSheet(
              const AddressScreen(),
              enableDrag: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
            );
          },
          showButton: showButton,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            Text(
              address.name!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            const Icon(
              Iconsax.call,
              size: 16,
            ),
            const SizedBox(
              width: TSizes.sm,
            ),
            Text(
              '+91 - ${address.mobile}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            const Icon(Iconsax.location, size: 16),
            const SizedBox(
              width: TSizes.sm,
            ),
            Flexible(
              child: Text(
                  '${address.address}, ${address.city}, ${address.state}, ${address.country}, ${address.pincode}',
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections / 2,
        ),
      ],
    );
  }
}
