import 'package:flutter/material.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'category_widget.dart';

class CategoryTabBar extends StatelessWidget {
  const CategoryTabBar({super.key, required TabController tabController})
    : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TabBar(
        labelPadding: EdgeInsets.symmetric(horizontal: 4),
        tabAlignment: TabAlignment.start,
        controller: _tabController,
        isScrollable: true,
        dividerColor: kPrimaryColor,
        labelStyle: kRegularTextStyle,
        unselectedLabelColor: kGrayColor,
        indicator: const BoxDecoration(),
        tabs: const [
          CategoryWidget(
            categoryImage: KAppCategoryImages.mensShoes,
            categoryName: 'mens-shoes',
          ),
          CategoryWidget(
            categoryImage: KAppCategoryImages.beauty,
            categoryName: 'beauty',
          ),
          CategoryWidget(
            categoryImage: KAppCategoryImages.fragrances,
            categoryName: 'fragrances',
          ),
          CategoryWidget(
            categoryImage: KAppCategoryImages.furniture,
            categoryName: 'furniture',
          ),
          CategoryWidget(
            categoryImage: KAppCategoryImages.groceries,
            categoryName: 'groceries',
          ),
          CategoryWidget(
            categoryImage: KAppCategoryImages.laptops,
            categoryName: 'laptops',
          ),
          CategoryWidget(
            categoryImage: KAppCategoryImages.mensShirts,
            categoryName: 'mens-shirts',
          ),
          CategoryWidget(
            categoryImage: KAppCategoryImages.mensWatches,
            categoryName: 'mens-watches',
          ),
          CategoryWidget(
            categoryImage: KAppCategoryImages.homeDecoration,
            categoryName: 'home-decoration',
          ),
          CategoryWidget(
            categoryImage: KAppCategoryImages.kitchenAccessories,
            categoryName: 'kitchen-accessories',
          ),
          CategoryWidget(
            categoryImage: KAppCategoryImages.smartphones,
            categoryName: 'smartphones',
          ),
          CategoryWidget(
            categoryImage: KAppCategoryImages.motorcycle,
            categoryName: 'motorcycle',
          ),
          CategoryWidget(
            categoryImage: KAppCategoryImages.skincare,
            categoryName: 'skin-care',
          ),
        ],
      ),
    );
  }
}
