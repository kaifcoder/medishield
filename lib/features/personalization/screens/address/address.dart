import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/custom_snackbar.dart';
import 'package:medishield/features/personalization/controllers/address_controller.dart';
import 'package:medishield/features/personalization/screens/address/add_address.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

import 'widgets/address_container.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => Get.to(() => const AddNewAddressScreen()),
            backgroundColor: TColors.primary,
            child: const Icon(
              Iconsax.add,
              color: TColors.light,
            ),
          ),
          const SizedBox(
            width: TSizes.sm,
          ),
          FloatingActionButton(
            heroTag: 'delete',
            onPressed: () {
              if (controller.addresses.length == 1) {
                // ignore: void_checks
                return CustomSnackbar.errorSnackBar(
                    'You can\'t delete the last address. Please add a new address first.');
              }
              Get.dialog(
                AlertDialog(
                  title: const Text('Delete Address'),
                  content: const Text('Are you sure you want to delete?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.deleteAddress(
                            controller.selectedAddress.value.id!);

                        Get.back();
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: TColors.warning,
            child: const Icon(
              Icons.delete,
              color: TColors.light,
            ),
          ),
        ],
      ),
      appBar: const TAppBar(
        title: Text('Address'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(
          () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.fetchAddresses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return CustomSnackbar.errorSnackBar(
                      snapshot.error.toString());
                }

                if (controller.addresses.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const Center(
                      child: Text('No address found'),
                    ),
                  );
                }

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.addresses.length,
                  itemBuilder: (context, index) {
                    return AddressContainer(
                      address: controller.addresses[index],
                      onTap: () {
                        controller.selectedAddress.value =
                            controller.addresses[index];
                      },
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
