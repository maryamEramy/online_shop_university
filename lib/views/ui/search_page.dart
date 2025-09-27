import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/views/shared/body_ui.dart';
import 'package:uni_online_shop/views/ui/product_page.dart';
import '../../controllers/product_provider.dart';
import '../../models/sneakers_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = "";
  double maxPrice = 500;
  double minPrice = 0;

  @override
  void initState() {
    super.initState();
    final productNotifier = Provider.of<ProductNotifier>(
      context,
      listen: false,
    );
    productNotifier.fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    var allProducts = productNotifier.allProducts;

    if (allProducts.isEmpty) {
      return const Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(child: CircularProgressIndicator(color: kSecondaryColor)),
      );
    }

    List<ProductInfo> filteredProducts =
        allProducts.where((product) {
          final matchesQuery =
              product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              product.category.toLowerCase().contains(
                searchQuery.toLowerCase(),
              );
          final doublePrice = double.tryParse(product.price) ?? 0.0;
          final withinPrice =
              doublePrice >= minPrice && doublePrice <= maxPrice;
          return matchesQuery && withinPrice;
        }).toList();

    return BodyUi(
      headerTitle: "Search",
      children: [
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            style: kRegularTextStyle.copyWith(color: kPrimaryColor),
            decoration: InputDecoration(
              hintText: "Search products or categories",
              hintStyle: kRegularTextStyle.copyWith(color: kGrayColor),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  KAppIcons.searchBox,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Min: \$${minPrice.toInt()}", style: kSecondTextStyle),
                  Text("Max: \$${maxPrice.toInt()}", style: kSecondTextStyle),
                ],
              ),
              RangeSlider(
                values: RangeValues(minPrice, maxPrice),
                min: 0,
                max: 1000,
                divisions: 100,
                labels: RangeLabels(
                  "\$${minPrice.toInt()}",
                  "\$${maxPrice.toInt()}",
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    minPrice = values.start;
                    maxPrice = values.end;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child:
              filteredProducts.isEmpty
                  ? Center(
                    child: Text("No products found", style: kRegularTextStyle),
                  )
                  : ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ProductPage(
                                    id: product.id,
                                    category: product.category,
                                  ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 100,
                          child: Card(
                            color: kLightPrimaryColor,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                            child: ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: product.imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                product.name,
                                style: kRegularTextStyle,
                              ),
                              subtitle: Text(
                                "${product.category} - \$${product.price}",
                                style: kSecondTextStyle,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
