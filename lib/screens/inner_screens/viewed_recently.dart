import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_sh0p/services/assets_manager.dart';
import 'package:smart_sh0p/widgets/empty_bag.dart';
import 'package:smart_sh0p/widgets/title_text.dart';

import '../../consts/app_colors.dart';
import '../../providers/viewed_prod_provider.dart';
import '../../services/my_app_method.dart';
import '../../widgets/products/product_widget.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const routName = '/ViewedRecentlyScreen';
  const ViewedRecentlyScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
     final viewedProvider = Provider.of<ViewedProdProvider>(context);
  
    return viewedProvider.getviewedProdItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.orderBag,
              title: "Your Viewed recently is empty",
              subtitle:
                  'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
              buttonText: "Shop Now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Shimmer.fromColors(
      period: const Duration(seconds: 16),
      baseColor: Colors.purple,
      highlightColor: Colors.red,
      child: const TitlesTextWidget(
        label: "Viewed recently",
        
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
                        fct: () {
                          viewedProvider.clearLocalviewedProd();
                        });   
                  },
                   icon: Container(
                    
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.grey[200],),
                    child: const Icon(
                      Icons.delete_forever_rounded,
                      color: AppColors.darkPrimary,
                    ),
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              itemCount:viewedProvider.getviewedProdItems.length,
            builder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                    productId: viewedProvider.getviewedProdItems.values
                        .toList()[index]
                        .productId,
                  ),
                );
              }),
              crossAxisCount: 2,
            ),
          );
  }
}
