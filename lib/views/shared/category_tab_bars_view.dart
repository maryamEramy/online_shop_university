import 'package:flutter/material.dart';
import 'home_widget.dart';

class CategoryTabBarsView extends StatelessWidget {
  const CategoryTabBarsView({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    // نکته‌ی اصلی: دیگه SizedBox با ارتفاع صفحه نگذار!
    return TabBarView(
      controller: _tabController,
      children: const [
        HomeWidget(category: "mens-shoes", tabIndex: 0),
        HomeWidget(category: "beauty", tabIndex: 1),
        HomeWidget(category: "fragrances", tabIndex: 2),
        HomeWidget(category: "furniture", tabIndex: 3),
        HomeWidget(category: "groceries", tabIndex: 4),
        HomeWidget(category: "laptops", tabIndex: 5),
        HomeWidget(category: "mens-shirts", tabIndex: 6),
        HomeWidget(category: "mens-shoes", tabIndex: 7),
        HomeWidget(category: "mens-watches", tabIndex: 8),
        HomeWidget(category: "home-decoration", tabIndex: 9),
        HomeWidget(category: "kitchen-accessories", tabIndex: 10),
        HomeWidget(category: "smartphones", tabIndex: 11),
        HomeWidget(category: "motorcycle", tabIndex: 12),
        HomeWidget(category: "skin-care", tabIndex: 13),
      ],
    );
  }
}
