import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uni_online_shop/views/shared/quantity_selector_widget.dart';

import '../../controllers/constant.dart';

class BasketItemCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onTap;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  const BasketItemCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: kLightPrimaryColor,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
            "${product['category']}  -  ${product['price']}",
            style: kSecondTextStyle,
          ),
          trailing: QuantitySelector(
            qty: product['qty'],
            onIncrement: onIncrement,
            onDecrement: onDecrement,
            onDelete: onDelete,
            style: QuantitySelectorStyle.secondary,
          ),
        ),
      ),
    );
  }
}