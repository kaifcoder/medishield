import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/loaders/custom_shimmer.dart';
import 'package:medishield/common/widgets/products/cart/t_cart_counter_icon.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/authentication/screens/login/login.dart';
import 'package:medishield/features/personalization/controllers/user_controller.dart';
import 'package:medishield/features/shop/screens/Search/search.dart';
import 'package:medishield/features/shop/screens/cart/cart.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/text_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          TTexts.homeAppbarTitle,
          style: Theme.of(context).textTheme.labelMedium!.apply(
                color: TColors.grey,
              ),
        ),
        Obx(() {
          if (controller.userLoading.value) {
            return const CustomShimmer(height: 15, width: 80);
          } else {
            return Text(
              controller.user.value.fullName,
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                    color: TColors.white,
                  ),
            );
          }
        }),
      ]),
      actions: [
        GestureDetector(
          onTap: () async {
            final Uri url = Uri.parse(
                'https://api.whatsapp.com/send/?phone=917570007676&text&type=phone_number&app_absent=0');
            if (!await launchUrl(url)) {
              throw Exception('Could not launch $url');
            }
          },
          child: const Image(
            image: AssetImage(TImages.whatsapp),
            height: 30,
            width: 30,
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () => Get.to(() => const SearchScreen(),
              transition: Transition.cupertinoDialog),
          icon: const Icon(
            Iconsax.search_normal,
            color: TColors.white,
          ),
        ),
        TCartCounterIcon(
          iconColor: TColors.white,
          onPressed: () {
            if (AuthenticationRepository.instance.deviceStorage.read('guest') ==
                true) {
              Get.offAll(() => const LoginScreen(),
                  transition: Transition.cupertinoDialog);
            } else {
              Get.to(() => const CartScreen(),
                  transition: Transition.rightToLeftWithFade);
            }
          },
        ),
      ],
    );
  }
}
