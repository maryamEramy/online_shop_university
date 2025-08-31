import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    final productNotifier = Provider.of<ProductNotifier>(context, listen: false);
    productNotifier.fetchAllProducts();
  }


  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    var allProducts = productNotifier.allProducts;

    if (allProducts.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // فیلتر محصولات بر اساس سرچ و رنج قیمت
    List<ProductInfo> filteredProducts = allProducts.where((product) {
      final matchesQuery = product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          product.category.toLowerCase().contains(searchQuery.toLowerCase());
      final doublePrice = double.tryParse(product.price) ?? 0.0;
      final withinPrice = doublePrice >= minPrice && doublePrice <= maxPrice;
      return matchesQuery && withinPrice;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search products or categories",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Min: \$${minPrice.toInt()}"),
                    Text("Max: \$${maxPrice.toInt()}"),
                  ],
                ),
                RangeSlider(
                  values: RangeValues(minPrice, maxPrice),
                  min: 0,
                  max: 1000,
                  divisions: 100,
                  labels: RangeLabels("\$${minPrice.toInt()}", "\$${maxPrice.toInt()}"),
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
            child: filteredProducts.isEmpty
                ? const Center(child: Text("No products found"))
                : ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(
                          id: product.id,
                          category: product.category,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.name),
                      subtitle: Text("${product.category} - \$${product.price}"),
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
