import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/controllers/favorites_provider.dart';
import 'package:uni_online_shop/controllers/product_provider.dart';
import '../shared/body_ui.dart';
import '../shared/category_tab_bar.dart';
import '../shared/category_tab_bars_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 13,
    vsync: this,
  );

  static const _categories = <String>[
    "mens-shoes",
    "beauty",
    "fragrances",
    "furniture",
    "groceries",
    "laptops",
    "mens-shirts",
    "mens-watches",
    "home-decoration",
    "kitchen-accessories",
    "smartphones",
    "motorcycle",
    "skin-care",
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productNotifier = context.read<ProductProvider>();
      final favoritesNotifier = context.read<FavoritesProvider>();
      productNotifier.fetchInitialProducts(_categories);
      favoritesNotifier.getFavorites();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BodyUi(
      headerTitle: "Nozama",
      children: [
        Text('Categories', style: kMainTextStyle),
        const SizedBox(height: 8),
        CategoryTabBar(tabController: _tabController),
        const SizedBox(height: 8),
        Expanded(
          child: CategoryTabBarsView(
            tabController: _tabController,
            categories: _categories,
          ),
        ),
      ],
    );
  }
}
