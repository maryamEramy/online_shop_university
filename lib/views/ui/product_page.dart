import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/basket_provider.dart';
import 'package:uni_online_shop/controllers/product_provider.dart';
import 'package:uni_online_shop/views/shared/body_ui.dart';
import 'package:uni_online_shop/views/shared/rounded_button.dart';
import '../../controllers/constant.dart';
import '../../controllers/favorites_provider.dart';
import '../../models/sneakers_model.dart';
import '../shared/quantity_selector_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  late Future<ProductInfo> _productFuture;
  late AnimationController controller;
  late Animation animation;
  late Animation backgroundAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    backgroundAnimation = ColorTween(
      begin: kPrimaryColor,
      end: kLightSecondaryColor,
    ).animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });

    _loadProduct();

    Future.microtask(() {
      final favoritesNotifier = Provider.of<FavoritesNotifier>(
        context,
        listen: false,
      );
      favoritesNotifier.getFavorites();
    });
  }

  void _loadProduct() {
    final productNotifier = Provider.of<ProductNotifier>(
      context,
      listen: false,
    );
    _productFuture = productNotifier.getProduct(widget.category, widget.id);

    _productFuture.then((product) {
      _precacheProductImage(product.imageUrl);
    });
  }

  void _precacheProductImage(String url) {
    precacheImage(NetworkImage(url), context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var basketProvider = Provider.of<BasketProvider>(context);

    final productFromProvider = basketProvider.cart.firstWhere(
      (item) => item['id'] == widget.id,
      orElse:
          () => <String, dynamic>{
            "id": "",
            "name": "",
            "category": "",
            "imageUrl": "",
            "price": 0.0,
            "qty": 0,
          },
    );

    var qty = productFromProvider['qty'] ?? 0;

    final productKey = productFromProvider['key'];

    return FutureBuilder<ProductInfo>(
      future: _productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return BodyUi(
            children: [
              Center(child: CircularProgressIndicator(color: kSecondaryColor)),
            ],
          );
        } else if (snapshot.hasError) {
          return BodyUi(
            children: [
              Center(
                child: Text("Error ${snapshot.error}", style: kErrorTextStyle),
              ),
            ],
          );
        } else if (!snapshot.hasData) {
          return const BodyUi(
            children: [Center(child: Text("No product found"))],
          );
        } else {
          final product = snapshot.data!;

          return BodyUi(
            backgroundColor: backgroundAnimation.value,
            headerTitle: product.name,
            showBackIcon: true,
            showBasketIcon: true,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Hero(
                                    tag: "productImage_${product.id}",
                                    child: Center(
                                      child: Transform.scale(
                                        scale: animation.value,
                                        child: CachedNetworkImage(
                                          imageUrl: product.imageUrl,
                                          fit: BoxFit.cover,
                                          placeholder:
                                              (context, url) =>
                                                  const CircularProgressIndicator(),
                                          errorWidget:
                                              (context, url, error) =>
                                                  const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kLightPrimaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: kMainTextStyle,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          product.category,
                                          style: kSecondTextStyle,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          "\$${product.price}",
                                          style: kMainTextStyle.copyWith(
                                            color: kSecondaryColor,
                                          ),
                                        ),
                                        const Divider(
                                          height: 24,
                                          color: Colors.black26,
                                        ),
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
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Consumer<FavoritesNotifier>(
                                  builder: (context, favoritesNotifier, _) {
                                    final isFavorite = favoritesNotifier.ids
                                        .contains(widget.id);
                                    return GestureDetector(
                                      onTap: () async {
                                        if (isFavorite) {
                                          Map<String, dynamic>? favItem;
                                          try {
                                            favItem = favoritesNotifier
                                                .favorites
                                                .firstWhere(
                                                  (item) =>
                                                      item['id'] == product.id,
                                                );
                                          } catch (e) {
                                            favItem = null;
                                          }

                                          if (favItem != null) {
                                            await favoritesNotifier.deleteFav(
                                              favItem['key'],
                                            );
                                          }
                                        } else {
                                          await favoritesNotifier.createFav({
                                            "id": product.id,
                                            "name": product.name,
                                            "category": product.category,
                                            "price": product.price,
                                            "imageUrl": product.imageUrl,
                                          });
                                        }
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        width: 60,
                                        height: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            isFavorite
                                                ? KAppIcons.liked
                                                : KAppIcons.like,
                                            // height: 22,
                                            // width: 22,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 42),
                        child: Column(
                          children: [
                            (qty == 0)
                                ? RoundedButton(
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
                                      final updatedProduct = basketProvider.cart
                                          .firstWhere(
                                            (item) => item['id'] == product.id,
                                            orElse: () => {"qty": 0},
                                          );
                                      qty = updatedProduct['qty'] ?? 0;

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Added to cart successfully!",
                                          ),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Error: $e"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  textColor: kWhiteColor,
                                  title: 'Add to Basket',
                                )
                                : RoundedButton(
                                  color: Colors.transparent,
                                  onPressed: () {},
                                  borderColor: kSecondaryColor,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${basketProvider.productTotalPrice(product.id).toStringAsFixed(2)} \$",
                                        style: kMainTextStyle.copyWith(
                                          color: kSecondaryColor,
                                        ),
                                      ),
                                      QuantitySelector(
                                        qty: qty,
                                        onIncrement:
                                            () => basketProvider.incrementQty(
                                              productKey,
                                            ),
                                        onDecrement:
                                            () => basketProvider.decrementQty(
                                              productKey,
                                            ),
                                        onDelete:
                                            () => basketProvider
                                                .deleteBasketItem(productKey),
                                        style: QuantitySelectorStyle.primary,
                                      ),
                                    ],
                                  ),
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
