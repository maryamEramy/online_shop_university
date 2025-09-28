import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/product_provider.dart';
import 'package:uni_online_shop/views/shared/product_card.dart';
import 'package:uni_online_shop/views/ui/product_page.dart';
import '../../controllers/constant.dart';

class HomeWidget extends StatelessWidget {
  final String category;
  final int tabIndex;

  const HomeWidget({super.key, required this.category, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    final productNotifier = Provider.of<ProductNotifier>(context);

    final products = productNotifier.productsByCategory[category];

    if (products == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (products.isEmpty) {
      return Center(
        child: Text(
          "No products found for this category.",
          style: kErrorTextStyle,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text('Products', style: kMainTextStyle),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 1,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
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
                child: ProductCard(
                  id: product.id,
                  name: product.name,
                  image: product.imageUrl,
                  price: double.tryParse(product.price) ?? 0.0,
                  category: product.category,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
