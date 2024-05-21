import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/loaders/custom_shimmer.dart';
import 'package:medishield/features/shop/controllers/location_controller.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';
import 'package:medishield/features/shop/screens/product_details/product_details.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/features/shop/controllers/search_controller.dart';
import 'package:medishield/utils/constants/text_strings.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchControler());
    final products = ProductController.instance.SearchProducts;
    final rate = LocationController.instance.rate;
    final ccy = LocationController.instance.currencyCode;
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Search'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            // search bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchText,
                    focusNode: controller.searchFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Search for products',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) async {
                      controller.handleSearch(value);
                    },
                    onSubmitted: (value) async {
                      controller.addToSearchHistory(value);
                      await controller.searchProducts();
                    },
                  ),
                ),
                IconButton(
                    icon: const Icon(Iconsax.scan),
                    onPressed: () async {
                      var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SimpleBarcodeScannerPage(),
                          ));
                      debugPrint('Barcode: $res');
                      if (res != null && res is String && res != '-1') {
                        controller.searchText.text = res;
                        controller.handleSearch(res);
                      }
                    }),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // search results
            Obx(() {
              if (products.isEmpty) {
                return const Expanded(
                    child: Center(child: Text('No products found')));
              }

              return Expanded(
                child: ListView.builder(
                  controller: controller.searchScrollController,
                  padding: EdgeInsets.zero,
                  itemCount:
                      products.length + (controller.isSearching.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    // show loading indicator at the end of the list
                    if (index < products.length) {
                      return ListTile(
                          title: Text(products[index].name),
                          onTap: () {
                            Get.to(() => ProductDetailScreen(
                                  product: products[index],
                                ));
                          },
                          leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: Hero(
                              tag: products[index].prodId,
                              child: CachedNetworkImage(
                                imageUrl: (products[index]
                                        .thumbnailUrl
                                        .contains('http'))
                                    ? products[index].thumbnailUrl
                                    : TTexts.imagebaseURL +
                                        products[index].thumbnailUrl,
                                placeholder: (context, url) =>
                                    const CustomShimmer(
                                  height: 50,
                                  width: 50,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          subtitle: Text(
                            '${products[index].price.minimalPrice.toDouble() * rate} $ccy',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ));
                    } else {
                      return const SizedBox(
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              );
            }),
            // recent searches
          ],
        ),
      ),
    );
  }
}
