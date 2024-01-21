import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medishield/features/personalization/screens/address/add_address.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

import 'widgets/address_container.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNewAddressScreen()),
        backgroundColor: TColors.primary,
        child: Icon(
          Iconsax.add,
          color: TColors.light,
        ),
      ),
      appBar: TAppBar(
        title: Text('Address'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            AddressContainer(selected: true),
            AddressContainer(selected: false),
          ],
        ),
      ),
    );
  }
}
