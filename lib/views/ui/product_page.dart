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
import 'cart_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {

    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getProduct(widget.category, widget.id);

    var cartProvider = Provider.of<CartProvider>(context);

    var favoritesNotifier = Provider.of<FavoritesNotifier>(context , listen: true);
    favoritesNotifier.getFavorites();
    return BodyUi(
      children: [
        FutureBuilder<ProductInfo>(
          future: productNotifier.product,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: kSecondaryColor),
              );
            } else if (snapshot.hasError) {
              return Text("Error ${snapshot.error}", style: kErrorTextStyle);
            } else if (!snapshot.hasData) {
              return const Text("No product found");
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
                          Text(
                            sneaker.name,
                            style: kMainTextStyle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            sneaker.category,
                            style: kSecondTextStyle,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "\$${sneaker.price}",
                            style: kMainTextStyle.copyWith(color: kSecondaryColor)
                          ),
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
                        padding: EdgeInsets.only(top: 12),
                        child:
                        RoundedButton(
                          color: kSecondaryColor,
                          onPressed: () async {
                            await cartProvider.addCart({
                              "id": sneaker.id,
                              "name": sneaker.name,
                              "category": sneaker.category,
                              "imageUrl": sneaker.imageUrl,
                              "price": sneaker.price,
                              "qty": 1,
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => CartPage(),
                              ),
                            );
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

