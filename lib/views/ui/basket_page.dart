import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/basket_provider.dart';
import 'package:uni_online_shop/views/shared/body_ui.dart';
import 'package:uni_online_shop/views/ui/main_page.dart';
import 'package:uni_online_shop/views/ui/product_page.dart';
import '../shared/basket_item.dart';
import '../shared/basket_summery.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyUi(
      headerTitle: "Your Basket",
      children: [
        Consumer<BasketProvider>(
            builder: (context , basketProvider , child){
              return Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: basketProvider.cart.length,
                        itemBuilder: (context, index) {
                          final product = basketProvider.cart[index];
                          return BasketItemCard(
                            product: product,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                    id: product['id'],
                                    category: product['category'],
                                  ),
                                ),
                              );
                            },
                            onIncrement: () =>
                                basketProvider.incrementQty(product['key']),
                            onDecrement: () =>
                                basketProvider.decrementQty(product['key']),
                            onDelete: () =>
                                basketProvider.deleteBasketItem(product['key']),
                          );
                        },
                      ),
                    ),
                    BasketSummary(
                      totalPrice: basketProvider.totalPrice,
                      onBuy: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MainPage()),
                        );
                      },
                    ),
                  ],
                ),
              );
            })
      ],
    );
  }
}
