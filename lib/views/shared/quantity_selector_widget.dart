import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../controllers/constant.dart';

enum QuantitySelectorStyle { primary, secondary }

class QuantitySelector extends StatelessWidget {
  final int qty;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;
  final QuantitySelectorStyle style;

  const QuantitySelector({
    super.key,
    required this.qty,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
    this.style = QuantitySelectorStyle.primary,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        (style == QuantitySelectorStyle.primary)
            ? kPrimaryColor
            : kSecondaryColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        (qty <= 1)
            ? GestureDetector(
              onTap: onDelete,
              child: Icon(Icons.delete, size: 22, color: kSecondaryColor),
            )
            : InkWell(
              onTap: onDecrement,
              child: Icon(AntDesign.minus, size: 22, color: kSecondaryColor),
            ),
        const SizedBox(width: 4),
        SizedBox(
          width: 16,
          height: 16,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '$qty',
              style: kSecondTextStyle.copyWith(color: textColor),
            ),
          ),
        ),
        const SizedBox(width: 4),
        InkWell(
          onTap: onIncrement,
          child: const Icon(AntDesign.plus, size: 22, color: kSecondaryColor),
        ),
      ],
    );
  }
}
