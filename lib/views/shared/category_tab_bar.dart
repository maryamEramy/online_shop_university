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

        tabAlignment: TabAlignment.start,
        controller: _tabController,
        isScrollable: true,
        dividerColor: kPrimaryColor,
        labelStyle: kRegularTextStyle,
        unselectedLabelColor: kGrayColor,
        indicator: const BoxDecoration(),
        tabs: const [
          CategoryWidget(categoryImage: kAppCategoryImages.mensShoes, categoryName: 'mens-shoes'),
          CategoryWidget(categoryImage: kAppCategoryImages.beauty, categoryName: 'beauty'),
          CategoryWidget(categoryImage: kAppCategoryImages.fragrances, categoryName: 'fragrances'),
          CategoryWidget(categoryImage: kAppCategoryImages.furniture, categoryName: 'furniture'),
          CategoryWidget(categoryImage: kAppCategoryImages.groceries, categoryName: 'groceries'),
          CategoryWidget(categoryImage: kAppCategoryImages.laptops, categoryName: 'laptops'),
          CategoryWidget(categoryImage: kAppCategoryImages.mensShirts, categoryName: 'mens-shirts'),
          CategoryWidget(categoryImage: kAppCategoryImages.mensWatches, categoryName: 'mens-watches'),
          CategoryWidget(categoryImage: kAppCategoryImages.homeDecoration, categoryName: 'home-decoration'),
          CategoryWidget(categoryImage: kAppCategoryImages.kitchenAccessories, categoryName: 'kitchen-accessories'),
          CategoryWidget(categoryImage: kAppCategoryImages.smartphones, categoryName: 'smartphones'),
          CategoryWidget(categoryImage: kAppCategoryImages.motorcycle, categoryName: 'motorcycle'),
          CategoryWidget(categoryImage: kAppCategoryImages.skincare, categoryName: 'skin-care'),
        ],
      ),
    );
  }
}
