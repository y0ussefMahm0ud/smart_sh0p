import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_sh0p/consts/app_constants.dart';
import 'package:smart_sh0p/widgets/products/ctg_rounded_widget.dart';
import 'package:smart_sh0p/widgets/products/latest_arrival.dart';
import 'package:smart_sh0p/widgets/title_text.dart';
import '../consts/app_colors.dart';
import '../providers/product_provider.dart';
import '../services/assets_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Shimmer.fromColors(
          period: const Duration(seconds: 16),
          baseColor: Colors.purple,
          highlightColor: Colors.red,
          child: const TitlesTextWidget(
            label: "smart_sh0p",
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Notification()));
              },
              icon: const Icon(Icons.notifications))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.24,
                child: ClipRRect(
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        AppConstants.bannersImages[index],
                        fit: BoxFit.fill,
                      );
                    },
                    autoplay: true,
                    itemCount: AppConstants.bannersImages.length,
                    pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.white,
                        activeColor: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Visibility(
                visible: productProvider.getProducts.isNotEmpty,
                child: const TitlesTextWidget(
                  label: "Latest arrival",
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Visibility(
                visible: productProvider.getProducts.isNotEmpty,
                child: SizedBox(
                  height: size.height * 0.2,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productProvider.getProducts.length < 10
                          ? productProvider.getProducts.length
                          : 10,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: productProvider.getProducts[index],
                            child: const LatestArrivalProductsWidget());
                      }),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const TitlesTextWidget(
                label: "Categories",
                fontSize: 22,
              ),
              const SizedBox(
                height: 18,
              ),
              GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children: List.generate(AppConstants.categoriesList.length,
                      (index) {
                    return CategoryRoundedWidget(
                      image: AppConstants.categoriesList[index].image,
                      name: AppConstants.categoriesList[index].name,
                    );
                  }))
            ],
          ),
        ),
      ),
    );
  }
}

class Notification extends StatelessWidget {
  static const routName = '/Notification';
  const Notification({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Shimmer.fromColors(
          period: const Duration(seconds: 16),
          baseColor: Colors.purple,
          highlightColor: Colors.red,
          child: const TitlesTextWidget(
            label: "Notification",
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey[200],
              ),
              child: const Icon(
                Icons.delete_forever_rounded,
                color: AppColors.darkPrimary,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Image.asset('assets/images/bag/notification.png'),
          const SizedBox(
            height: 20,
          ),
          const TitlesTextWidget(
            label: "you don’t have notification yet",
            fontSize: 25,
            color: Colors.grey,
          ),
        ],
      ));
}
