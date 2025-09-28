import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../controllers/constant.dart'; // فرض بر وجود constant.dart

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
    // از context فقط برای theme یا media query استفاده می‌شود، نه برای Provider
    final textColor =
    (style == QuantitySelectorStyle.primary)
        ? kPrimaryColor
        : kSecondaryColor;

    // Icon های AntDesign برای consistency با دیگر بخش‌های کد
    const plusIcon = Icon(AntDesign.plus, size: 22, color: kSecondaryColor);
    const minusIcon = Icon(AntDesign.minus, size: 22, color: kSecondaryColor);
    const deleteIcon = Icon(Icons.delete, size: 22, color: kSecondaryColor);


    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        (qty <= 1)
            ? GestureDetector(
          onTap: onDelete,
          child: deleteIcon,
        )
            : InkWell(
          onTap: onDecrement,
          child: minusIcon,
        ),
        const SizedBox(width: 4),
        SizedBox(
          width: 24, // اندازه کمی بیشتر برای نمایش بهتر عدد
          height: 22,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '$qty',
              style: kSecondTextStyle.copyWith(
                color: textColor,
                fontSize: 16, // اندازه فونت تنظیم شد
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        InkWell(
          onTap: onIncrement,
          child: plusIcon,
        ),
      ],
    );
  }
}