import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/basket_provider.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/views/shared/body_ui.dart';
import 'package:uni_online_shop/views/shared/roundedButton.dart';
import 'package:uni_online_shop/views/ui/main_page.dart';
import 'package:uni_online_shop/views/ui/product_page.dart';

class BasketPage extends StatefulWidget {
  BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<BasketProvider>(context);
    // cartProvider.getCart();
    return BodyUi(
      headerTitle: "Your Basket",
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.cart.length,
                  itemBuilder: (context, index) {
                    final product = cartProvider.cart[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ProductPage(
                                  id: product['id'],
                                  category: product['category'],
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
                              imageUrl: product['imageUrl'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              product['name'],
                              style: kRegularTextStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            subtitle: Text(
                              "${product['category']}  -   ${product['price']}",
                              style: kSecondTextStyle,
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    (product['qty'] <= 1)
                                        ? GestureDetector(
                                          onTap: () {
                                            cartProvider.deleteBasketItem(
                                              product['key'],
                                            );
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            size: 16,
                                            color: kSecondaryColor,
                                          ),
                                        )
                                        : InkWell(
                                          onTap: () {
                                            cartProvider.decrementQty(
                                              product['key'],
                                            );
                                          },
                                          child: const Icon(
                                            AntDesign.minus,
                                            size: 16,
                                            color: kSecondaryColor,
                                          ),
                                        ),
                                    SizedBox(width: 4,),
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          product['qty'].toString(),
                                          style: kSecondTextStyle.copyWith(
                                            color: kSecondaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 4,),
                                    InkWell(
                                      onTap: () {
                                        cartProvider.incrementQty(
                                          product['key'],
                                        );
                                      },
                                      child: const Icon(
                                        AntDesign.plus,
                                        size: 16,
                                        color: kSecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RoundedButton(
                  title: 'Buy',
                  color: kSecondaryColor,
                  textColor: kWhiteColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
