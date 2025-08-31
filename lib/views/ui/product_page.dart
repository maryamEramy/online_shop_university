import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/cart_provider.dart';
import 'package:uni_online_shop/controllers/product_provider.dart';
import 'package:uni_online_shop/services/helper.dart';
import 'package:uni_online_shop/views/shared/appstyle.dart';
import 'package:uni_online_shop/views/ui/favorites_page.dart';

import '../../controllers/favorites_provider.dart';
import '../../models/sneakers_model.dart';
import '../shared/checkout_btn.dart';
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

    final futureProduct = productNotifier.getProduct(widget.category, widget.id);


    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: FutureBuilder<ProductInfo>(

        // future: futureProduct,
        future: productNotifier.product,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final sneaker = snapshot.data;
            return Consumer<ProductNotifier>(
              builder: (context, productNotifier, child) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery.of(context).size.height,
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            productNotifier.shoeSizes.clear();
                          },
                          child: Icon(AntDesign.close),
                        ),
                      ),

                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sneaker!.imageUrl.length,
                                controller: pageController,
                                onPageChanged: (page) {
                                  productNotifier.activePage = page;
                                },
                                itemBuilder: (context, int index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.4,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.grey.shade300,
                                        child: CachedNetworkImage(
                                          imageUrl: sneaker.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                            0.1,
                                        right: 20,
                                        child: Consumer<FavoritesNotifier>(
                                          builder: (
                                            context,
                                            favoritesNotifier,
                                            child,
                                          ) {
                                            return GestureDetector(
                                              onTap: () {
                                                if (favoritesNotifier.ids.contains(widget.id)) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              FavoritesPage(),
                                                    ),
                                                  );
                                                } else {
                                                  favoritesNotifier.createFav({
                                                    "id": sneaker.id,
                                                    "name": sneaker.name,
                                                    "category":
                                                        sneaker.category,
                                                    "price": sneaker.price,
                                                    "imageUrl":
                                                        sneaker.imageUrl,
                                                  });
                                                }
                                                setState(() {

                                                });
                                              },
                                              child:
                                                  favoritesNotifier.ids.contains(sneaker.id)
                                                      ? Icon(AntDesign.heart)
                                                      : Icon(AntDesign.hearto),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height *
                                      0.645,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                  sneaker.name,
                                                  style: appstyle(
                                                    40,
                                                    Colors.black,
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      sneaker.category,
                                                      style: appstyle(
                                                        20,
                                                        Colors.grey,
                                                        FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(width: 20),
                                                    RatingBar.builder(
                                                      initialRating: 4,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 22,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 1,
                                                          ),
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                            Icons.star,
                                                            size: 18,
                                                            color: Colors.black,
                                                          ),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "\$${sneaker.price}",
                                                      style: appstyle(
                                                        26,
                                                        Colors.black,
                                                        FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                Divider(
                                                  indent: 10,
                                                  endIndent: 10,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(height: 10),
                                                // SizedBox(
                                                //   width:
                                                //       MediaQuery.of(
                                                //         context,
                                                //       ).size.width *
                                                //       0.8,
                                                //   child: Text(
                                                //     sneaker.name,
                                                //     style: appstyle(
                                                //       26,
                                                //       Colors.black,
                                                //       FontWeight.w700,
                                                //     ),
                                                //   ),
                                                // ),
                                                // SizedBox(height: 10),
                                                Text(
                                                  sneaker.description,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 4,
                                                  style: appstyle(
                                                    14,
                                                    Colors.black,
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 12),
                                            child: CheckoutButton(
                                              onTap: () async {
                                                await cartProvider.addCart({
                                                  "id": sneaker.id,
                                                  "name": sneaker.name,
                                                  "category": sneaker.category,
                                                  // "sizes":
                                                  //     productNotifier.sizes,
                                                  "imageUrl": sneaker.imageUrl,
                                                  "price": sneaker.price,
                                                  "qty": 1,
                                                  // "imageUrl": sneaker.imageUrl[0],
                                                });
                                                // productNotifier.sizes.clear();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) => CartPage(),
                                                  ),
                                                );
                                              },
                                              label: 'Add to Cart',
                                            ),
                                          ),
                                        ),
                                        // ...
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

