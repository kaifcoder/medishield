import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/features/personalization/controllers/address_controller.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/constants/text_strings.dart';
import 'package:medishield/utils/validators/validation.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Form(
      key: controller.addressFormKey,
      child: Column(
        children: [
          TextFormField(
            validator: TValidator.validateEmpty,
            controller: controller.name,
            decoration: const InputDecoration(
              labelText: 'Name',
              prefixIcon: Icon(Iconsax.user),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            validator: TValidator.validatePhoneNumber,
            controller: controller.mobile,
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
              validator: TValidator.validateEmpty,
              controller: controller.addresstext,
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
                  validator: TValidator.validateEmpty,
                  controller: controller.city,
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
                  validator: TValidator.validateEmpty,
                  controller: controller.pincode,
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
            validator: TValidator.validateEmpty,
            controller: controller.state,
            decoration: const InputDecoration(
              labelText: 'State',
              prefixIcon: Icon(Iconsax.global),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          TextFormField(
            validator: TValidator.validateEmpty,
            controller: controller.country,
            decoration: const InputDecoration(
              labelText: 'Country',
              prefixIcon: Icon(Iconsax.global),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.addAddress(),
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
