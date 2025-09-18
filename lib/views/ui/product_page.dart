import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/cart_provider.dart';
import 'package:uni_online_shop/controllers/product_provider.dart';
import 'package:uni_online_shop/views/shared/body_ui.dart';
import 'package:uni_online_shop/views/shared/roundedButton.dart';
import '../../controllers/constant.dart';
import '../../controllers/favorites_provider.dart';
import '../../models/sneakers_model.dart';
import '../shared/text_title_widget.dart';
import 'cart_page.dart';

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

    // ✅ getFavorites فقط یکبار بعد از لود شدن ویجت
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
    var cartProvider = Provider.of<CartProvider>(context);
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context);

    return BodyUi(
      headerTitle: '',
      showBackIcon: true,
      children: [
        FutureBuilder<ProductInfo>(
          future: _productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: kSecondaryColor),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error ${snapshot.error}", style: kErrorTextStyle));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("No product found"));
            } else {
              final sneaker = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: sneaker.imageUrl,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
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
                          Text(sneaker.name, style: kMainTextStyle),
                          const SizedBox(height: 8),
                          Text(sneaker.category, style: kSecondTextStyle),
                          const SizedBox(height: 12),
                          Text("\$${sneaker.price}",
                              style: kMainTextStyle.copyWith(color: kSecondaryColor)),
                          const Divider(height: 24, color: Colors.black26),
                          Text(
                            sneaker.description,
                            style: kRegularTextStyle,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: RoundedButton(
                          color: kSecondaryColor,
                          onPressed: () async {
                            try {
                              await cartProvider.addCart({
                                "id": sneaker.id,
                                "name": sneaker.name,
                                "category": sneaker.category,
                                "imageUrl": sneaker.imageUrl,
                                "price": sneaker.price,
                                "qty": 1,
                              });

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
                          },
                          textColor: kWhiteColor,
                          title: 'Add to Cart',
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}


