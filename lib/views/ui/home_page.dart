import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/favorites_provider.dart';
import 'package:uni_online_shop/controllers/product_provider.dart';
import 'package:uni_online_shop/views/shared/appstyle.dart';

import '../shared/home_widget.dart';
import '../shared/search_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 14,
    vsync: this,
  );

  @override
  void initState() {
    super.initState();

    final productNotifier = Provider.of<ProductNotifier>(context, listen: false);
    final favoritesNotifier = Provider.of<FavoritesNotifier>(context, listen: false);

    List<String> categories = [
      "mens-shoes",
      "beauty",
      "fragrances",
      "furniture",
      "groceries",
      "laptops",
      "mens-shirts",
      "mens-shoes",
      "mens-watches",
      "home-decoration",
      "kitchen-accessories",
      "smartphones",
      "motorcycle",
      "skin-care",
    ];

    for (var category in categories) {
      productNotifier.getProducts(category);
    }
    favoritesNotifier.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo/top_of_screen.png"),
                  alignment: Alignment.topCenter,
                ),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nozama",
                      style: appstyleWithHt(
                        40,
                        Colors.white,
                        FontWeight.bold,
                        1.75,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TabBar(
                      tabAlignment: TabAlignment.start,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Colors.black87,
                      dividerColor: Colors.grey,
                      labelStyle: appstyle(20, Colors.white, FontWeight.w500),
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(text: "mens-shoes"),
                        Tab(text: "beauty"),
                        Tab(text: "fragrances"),
                        Tab(text: "furniture"),
                        Tab(text: "groceries"),
                        Tab(text: "laptops"),
                        Tab(text: "mens-shirts"),
                        Tab(text: "mens-shoes"),
                        Tab(text: "mens-watches"),
                        Tab(text: "home-decoration"),
                        Tab(text: "kitchen-accessories"),
                        Tab(text: "smartphones"),
                        Tab(text: "motorcycle"),
                        Tab(text: "skin-care"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}





