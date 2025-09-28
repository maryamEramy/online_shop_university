import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/sneakers_model.dart';

class ProductImageWidget extends StatelessWidget {
  final ProductInfo product;
  final Animation<double> animation;

  const ProductImageWidget({
    super.key,
    required this.product,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "productImage_${product.id}",
      child: Center(
        child: Transform.scale(
          scale: animation.value,
          child: CachedNetworkImage(
            imageUrl: product.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
