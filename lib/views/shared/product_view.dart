import 'package:flutter/cupertino.dart';
import 'package:uni_online_shop/views/shared/product_details_card.dart';
import 'package:uni_online_shop/views/shared/product_image_widget.dart';
import '../../models/sneakers_model.dart';
import 'basket_action.dart';
import 'favorite_button.dart';

class ProductView extends StatelessWidget {
  final ProductInfo product;
  final Animation<double> animation;
  final String productId;

  const ProductView({
    super.key,
    required this.product,
    required this.animation,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      ProductImageWidget(
                        product: product,
                        animation: animation,
                      ),
                      const SizedBox(height: 20),
                      ProductDetailsCard(product: product),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: FavoriteButton(product: product),
                  ),
                ],
              ),
            ),
          ),
        ),
        BasketAction(productId: productId, product: product),
      ],
    );
  }
}
