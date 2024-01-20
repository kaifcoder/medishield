import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/image_text_widgets/t_vertical_image_text.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return TVerticalImageText(
                title: 'Shoe category',
                image: TImages.sportIcon,
                textColor: THelperFunctions.isDarkMode(context)
                    ? TColors.white
                    : TColors.black,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.dark
                    : TColors.light,
                onTap: () {});
          }),
    );
  }
}
