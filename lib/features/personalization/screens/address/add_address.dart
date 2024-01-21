import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/features/personalization/screens/address/widgets/address_form.dart';
import 'package:medishield/utils/constants/sizes.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Add New Address'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //address form
            AddressForm()
            //save button
          ],
        ),
      ),
    );
  }
}
