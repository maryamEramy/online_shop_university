import 'package:flutter/material.dart';
import 'home_widget.dart';

class CategoryTabBarsView extends StatelessWidget {
  const CategoryTabBarsView({
    super.key,
    required TabController tabController,
    required this.categories,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<String> categories;

  List<Widget> get _buildTabViewChildren {
    return categories.asMap().entries.map((entry) {
      final index = entry.key;
      final categoryName = entry.value;

      return HomeWidget(
        key: ValueKey(categoryName),
        category: categoryName,
        tabIndex: index,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: _buildTabViewChildren,
    );
  }
}
