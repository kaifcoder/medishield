import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/login_signup/login_footer.dart';
import 'package:medishield/common/widgets/login_signup/t_divider.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/constants/text_strings.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
              prefixIcon: Icon(Iconsax.user),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
              decoration: const InputDecoration(
            labelText: 'Address',
            prefixIcon: Icon(Iconsax.map),
          )),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'City',
                    prefixIcon: Icon(Iconsax.global),
                  ),
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Pin Code',
                    prefixIcon: Icon(Iconsax.global),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'State',
              prefixIcon: Icon(Iconsax.global),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
