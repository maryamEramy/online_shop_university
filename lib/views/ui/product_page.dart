import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/basket_provider.dart';
import 'package:uni_online_shop/controllers/product_provider.dart';
import 'package:uni_online_shop/views/shared/body_ui.dart';
import 'package:uni_online_shop/views/shared/roundedButton.dart';
import '../../controllers/constant.dart';
import '../../controllers/favorites_provider.dart';
import '../../models/sneakers_model.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<ProductInfo> _productFuture;

  @override
  void initState() {
    super.initState();
    _loadProduct();
    Future.microtask(() {
      final favoritesNotifier = Provider.of<FavoritesNotifier>(context, listen: false);
      favoritesNotifier.getFavorites();
    });
  }

  void _loadProduct() {
    final productNotifier = Provider.of<ProductNotifier>(context, listen: false);
    _productFuture = productNotifier.getProduct(widget.category, widget.id);
  }

  @override
  Widget build(BuildContext context) {

    var basketProvider = Provider.of<BasketProvider>(context);

    final productFromProvider = basketProvider.cart.firstWhere(
          (item) => item['id'] == widget.id,
      orElse: () => <String, dynamic>{
        "id": "",
        "name": "",
        "category": "",
        "imageUrl": "",
        "price": 0.0,
        "qty": 0,
      },
    );

    var qty = productFromProvider['qty'] ?? 0;



    return FutureBuilder<ProductInfo>(
      future: _productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: kSecondaryColor),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error ${snapshot.error}", style: kErrorTextStyle),
            ),
          );
        } else if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text("No product found")),
          );
        } else {
          final product = snapshot.data!;

          return BodyUi(
            headerTitle: product.name,
            showBackIcon: true,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Center(
                              child: CachedNetworkImage(
                                imageUrl: product.imageUrl,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: kLightPrimaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.name, style: kMainTextStyle),
                                  const SizedBox(height: 8),
                                  Text(product.category, style: kSecondTextStyle),
                                  const SizedBox(height: 12),
                                  Text(
                                    "\$${product.price}",
                                    style: kMainTextStyle.copyWith(
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                  const Divider(height: 24, color: Colors.black26),
                                  Text(
                                    product.description,
                                    style: kRegularTextStyle,
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Column(
                          children: [
                            Text(
                              "${basketProvider.productTotalPrice(product.id).toStringAsFixed(2)} \$",
                              style: kMainTextStyle.copyWith(color: kSecondaryColor),
                            ),
                            Text('$qty'),
                            RoundedButton(
                              color: kSecondaryColor,
                              onPressed: () async {
                                try {
                                  await basketProvider.addBasket({
                                    "id": product.id,
                                    "name": product.name,
                                    "category": product.category,
                                    "imageUrl": product.imageUrl,
                                    "price": product.price,
                                    "qty": 1,
                                  });
                                  final updatedProduct = basketProvider.cart.firstWhere(
                                        (item) => item['id'] == product.id,
                                    orElse: () => {"qty": 0},
                                  );
                                  qty = updatedProduct['qty'] ?? 0;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Added to cart successfully!"),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Error: $e"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                                print('********************************************************$qty');
                              },
                              textColor: kWhiteColor,
                              title: 'Add to Basket',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
