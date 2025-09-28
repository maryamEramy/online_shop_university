import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/views/shared/quantity_selector_widget.dart';
import 'package:uni_online_shop/views/shared/rounded_button.dart';
import '../../controllers/basket_provider.dart';
import '../../controllers/constant.dart';
import '../../models/sneakers_model.dart';

class BasketAction extends StatelessWidget {
  final String productId;
  final ProductInfo product;

  const BasketAction({
    super.key,
    required this.productId,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final basketProvider = Provider.of<BasketProvider>(context);

    final cartItem = basketProvider.getProductFromCart(productId);
    final qty = cartItem['qty'] ?? 0;
    final productKey = cartItem['key'];

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 42,
          left: 22,
          right: 22,
        ),
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

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Added to cart successfully!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    } catch (e) {
                      debugPrint('Add to basket error: $e');
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Error: $e"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${basketProvider.productTotalPrice(productId).toStringAsFixed(2)} \$",
                        style: kMainTextStyle.copyWith(color: kSecondaryColor),
                      ),

                      QuantitySelector(
                        qty: qty,
                        onIncrement:
                            () => basketProvider.incrementQty(productKey),
                        onDecrement:
                            () => basketProvider.decrementQty(productKey),
                        onDelete:
                            () => basketProvider.deleteBasketItem(productKey),
                        style: QuantitySelectorStyle.primary,
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
