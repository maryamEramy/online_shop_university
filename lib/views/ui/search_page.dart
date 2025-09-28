import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/views/shared/body_ui.dart';
import '../../controllers/product_provider.dart';
import '../shared/price_range_slider_widget.dart';
import '../shared/product_search_item.dart';
import '../shared/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductNotifier>(context, listen: false).fetchAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);

    var filteredProducts = productNotifier.filteredProducts;

    if (productNotifier.allProducts.isEmpty) {
      return const BodyUi(
        headerTitle: "Search",
        children: [
          Center(child: CircularProgressIndicator(color: kSecondaryColor)),
        ],
      );
    }

    return BodyUi(
      headerTitle: "Search",
      children: [
        SearchWidget(productNotifier: productNotifier),

        const SizedBox(height: 20),

        PriceRangeSliderWidget(productNotifier: productNotifier),

        const SizedBox(height: 10),

        Expanded(
          child:
              filteredProducts.isEmpty
                  ? Center(
                    child: Text(
                      "No products found matching the criteria.",
                      style: kRegularTextStyle,
                    ),
                  )
                  : ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductSearchItem(product: product);
                    },
                  ),
        ),
      ],
    );
  }
}
