import 'package:flutter/material.dart';
import '../../controllers/constant.dart';
import '../../controllers/product_provider.dart';

class PriceRangeSliderWidget extends StatelessWidget {
  final ProductNotifier productNotifier;

  const PriceRangeSliderWidget({super.key, required this.productNotifier});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Min: \$${productNotifier.minPrice.toInt()}",
              style: kSecondTextStyle,
            ),
            Text(
              "Max: \$${productNotifier.maxPrice.toInt()}",
              style: kSecondTextStyle,
            ),
          ],
        ),
        RangeSlider(
          values: RangeValues(
            productNotifier.minPrice,
            productNotifier.maxPrice,
          ),
          min: 0,
          max: 1000,
          divisions: 100,
          labels: RangeLabels(
            "\$${productNotifier.minPrice.toInt()}",
            "\$${productNotifier.maxPrice.toInt()}",
          ),
          onChanged: (RangeValues values) {
            productNotifier.setPriceRange(values.start, values.end);
          },
        ),
      ],
    );
  }
}
