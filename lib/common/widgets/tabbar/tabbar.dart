import 'package:flutter/material.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/device/device_utility.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

class TabBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const TabBarCustom({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: TColors.primary,
        labelColor: dark ? TColors.white : TColors.primary,
        unselectedLabelColor: dark ? TColors.lightGrey : TColors.darkerGrey,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
