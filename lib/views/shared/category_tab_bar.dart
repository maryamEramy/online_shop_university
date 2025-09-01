import 'package:flutter/material.dart';
import 'appstyle.dart';
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
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.transparent,
        controller: _tabController,
        isScrollable: true,
        labelColor: Colors.black87,
        dividerColor: Colors.grey,
        labelStyle: appstyle(16, Colors.black87, FontWeight.w500),
        unselectedLabelColor: Colors.grey,
        tabs: const [
          CategoryWidget(categoryImage: 'assets/logo/C-book.png', categoryName: 'mens-shoes'),
          CategoryWidget(categoryImage: 'assets/logo/C-book.png', categoryName: 'beauty'),
          CategoryWidget(categoryImage: 'assets/logo/C-book.png', categoryName: 'fragrances'),
          CategoryWidget(categoryImage: 'assets/logo/C-book.png', categoryName: 'furniture'),
          CategoryWidget(categoryImage: 'assets/logo/C-book.png', categoryName: 'groceries'),
          CategoryWidget(categoryImage: 'assets/logo/C-book.png', categoryName: 'laptops'),
          CategoryWidget(categoryImage: 'assets/logo/C-book.png', categoryName: 'mens-shirts'),
          CategoryWidget(categoryImage: 'assets/logo/C-book.png', categoryName: 'mens-shoes'),
          CategoryWidget(categoryImage: 'assets/logo/C-book.png', categoryName: 'mens-watches'),
          CategoryWidget(categoryImage: 'assets/logo/C-book.png', categoryName: 'home-decoration'),
          CategoryWidget(categoryImage: 'assets/logo/C-book.png', categoryName: 'kitchen-accessories'),
          CategoryWidget(categoryImage: 'assets/logo/C-book.png', categoryName: 'smartphones'),
          CategoryWidget(categoryImage: 'assets/logo/C-book.png', categoryName: 'motorcycle'),
          CategoryWidget(categoryImage: 'assets/logo/C-book.png', categoryName: 'skin-care'),
        ],
      ),
    );
  }
}
