import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_sh0p/consts/app_colors.dart';
import 'package:smart_sh0p/services/assets_manager.dart';
import 'package:smart_sh0p/widgets/empty_bag.dart';
import 'package:smart_sh0p/widgets/title_text.dart';

import '../../providers/wishlist_provider.dart';
import '../../services/my_app_method.dart';
import '../../widgets/products/product_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routName = '/WishlistScreen';
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return wishlistProvider.getWishlistItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.bagWish,
              title: "Your wishlist is empty",
              subtitle:
                  'seems like you don’t have any wishes here',
              buttonText: "make a wish now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Shimmer.fromColors(
              period: const Duration(seconds: 16),
              baseColor: Colors.purple,
              highlightColor: Colors.red,
              child: const TitlesTextWidget(
                label: "Wishlist",
              ),
            ), 
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorORWarningDialog(
                        isError: false,
                        context: context,
                        subtitle: "Remove items",
                        fct: () async {
                          await wishlistProvider.clearWishlistFromFirebase();
                          wishlistProvider.clearLocalWishlist();
                        });
                  },
                  icon: Container(
                   
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.grey[200],),
                    child: const Icon(
                      Icons.delete_forever_rounded,
                      color: AppColors.darkPrimary,
                    ),
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              itemCount: wishlistProvider.getWishlistItems.length,
              builder: ((context, index) {
               return  ProductWidget(
                  productId: wishlistProvider.getWishlistItems.values
                      .toList()[index]
                      .productId,
                );
              }),
              crossAxisCount: 2,
            ),
          );
      
  }
}