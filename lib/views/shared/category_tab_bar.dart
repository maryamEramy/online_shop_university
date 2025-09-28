import 'package:flutter/material.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'category_widget.dart';

class CategoryTabBar extends StatelessWidget {
  static const List<Map<String, String>> _categoryData = [
    {'name': 'mens-shoes', 'image': KAppCategoryImages.mensShoes},
    {'name': 'beauty', 'image': KAppCategoryImages.beauty},
    {'name': 'fragrances', 'image': KAppCategoryImages.fragrances},
    {'name': 'furniture', 'image': KAppCategoryImages.furniture},
    {'name': 'groceries', 'image': KAppCategoryImages.groceries},
    {'name': 'laptops', 'image': KAppCategoryImages.laptops},
    {'name': 'mens-shirts', 'image': KAppCategoryImages.mensShirts},
    {'name': 'mens-watches', 'image': KAppCategoryImages.mensWatches},
    {'name': 'home-decoration', 'image': KAppCategoryImages.homeDecoration},
    {'name': 'kitchen-accessories', 'image': KAppCategoryImages.kitchenAccessories,},
    {'name': 'smartphones', 'image': KAppCategoryImages.smartphones},
    {'name': 'motorcycle', 'image': KAppCategoryImages.motorcycle},
    {'name': 'skin-care', 'image': KAppCategoryImages.skincare},
  ];

  const CategoryTabBar({super.key, required TabController tabController})
    : _tabController = tabController;

  final TabController _tabController;

  List<Widget> get _buildCategoryTabs {
    return _categoryData.map((data) {
      return CategoryWidget(
        key: ValueKey(data['name']),
        categoryImage: data['image']!,
        categoryName: data['name']!,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TabBar(
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        tabAlignment: TabAlignment.start,
        controller: _tabController,
        isScrollable: true,
        dividerColor: kPrimaryColor,
        labelStyle: kRegularTextStyle,
        unselectedLabelColor: kGrayColor,
        indicator: const BoxDecoration(),

        tabs: _buildCategoryTabs,
      ),
    );
  }
}
