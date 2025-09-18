import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/product_provider.dart';
import 'package:uni_online_shop/views/shared/product_card.dart';
import 'package:uni_online_shop/views/ui/product_page.dart';
import '../../controllers/constant.dart';
import '../../models/sneakers_model.dart';

class HomeWidget extends StatelessWidget {
  final String category;
  final int tabIndex;

  const HomeWidget({super.key, required this.category, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context, listen: false);

    return FutureBuilder<List<ProductInfo>>(
      future: productNotifier.getProducts(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}", style: kErrorTextStyle),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text("No products found", style: kErrorTextStyle),
          );
        } else {
          final products = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
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
                  // scrollDirection: Axis.vertical,
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
                        price: "\$${product.price}",
                        category: product.category,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
