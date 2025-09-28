import 'package:flutter/material.dart';
import '../../controllers/constant.dart';
import '../../models/sneakers_model.dart';

class ProductDetailsCard extends StatelessWidget {
  final ProductInfo product;

  const ProductDetailsCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            style: kMainTextStyle.copyWith(color: kSecondaryColor),
          ),
          const Divider(height: 24, color: Colors.black26),
          Text(
            product.description,
            style: kRegularTextStyle,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
