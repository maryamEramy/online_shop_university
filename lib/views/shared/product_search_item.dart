import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../controllers/constant.dart';
import '../../models/sneakers_model.dart';
import '../ui/product_page.dart';

class ProductSearchItem extends StatelessWidget {
  final ProductInfo product;

  const ProductSearchItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    ProductPage(id: product.id, category: product.category),
          ),
        );
      },
      child: SizedBox(
        height: 100,
        child: Card(
          color: kLightPrimaryColor,
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: product.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product.name, style: kRegularTextStyle),
            subtitle: Text(
              "${product.category} - \$${product.price}",
              style: kSecondTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
