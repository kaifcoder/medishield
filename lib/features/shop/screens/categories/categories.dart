import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/features/shop/controllers/all_product_controller.dart';
import 'package:medishield/features/shop/controllers/category_controller.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';
import 'package:medishield/features/shop/screens/view_all_products/all_product.dart';

class CategoiesScreen extends StatelessWidget {
  const CategoiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    final allProductController = Get.put(AllProductController());
    final productController = ProductController.instance;
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Categoies'),
        showBackArrow: true,
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: controller.categoryList.length,
            itemBuilder: (context, index) {
              if (controller.categoryList[index].children.isEmpty) {
                return ListTile(
                  onTap: () async {
                    await productController.fetchProductsbycategory(
                        controller.categoryList[index].name, 1);
                    allProductController
                        .setTitle(controller.categoryList[index].name);
                    allProductController.reset();
                    Get.to(
                      () => AllProductScreen(
                        title: controller.categoryList[index].name,
                        product: productController.CategoryProducts,
                      ),
                    );
                  },
                  title: Text(
                    controller.categoryList[index].name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                );
              }

              return ExpansionTile(
                childrenPadding: const EdgeInsets.only(left: 20),
                title: Text(
                  controller.categoryList[index].name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                children: [
                  ...controller.categoryList[index].children.map((subCategory) {
                    if (subCategory.children.isNotEmpty) {
                      return ExpansionTile(
                          childrenPadding: const EdgeInsets.only(left: 20),
                          title: Text(subCategory.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .apply(
                                    fontSizeDelta: -2,
                                  )),
                          children: [
                            ...subCategory.children.map((child) {
                              return ListTile(
                                onTap: () async {
                                  await productController
                                      .fetchProductsbycategory(child.name, 1);
                                  allProductController.setTitle(child.name);
                                  allProductController.reset();
                                  Get.to(() => AllProductScreen(
                                        title: child.name,
                                        product:
                                            productController.CategoryProducts,
                                      ));
                                },
                                title: Text(child.name),
                              );
                            })
                          ]);
                    }
                    return ListTile(
                      onTap: () async {
                        await productController.fetchProductsbycategory(
                            subCategory.name, 1);
                        allProductController.setTitle(subCategory.name);
                        allProductController.reset();
                        Get.to(() => AllProductScreen(
                              title: subCategory.name,
                              product: productController.CategoryProducts,
                            ));
                      },
                      title: Text(subCategory.name),
                    );
                  })
                ],
              );
            }),
      ),
    );
  }
}
