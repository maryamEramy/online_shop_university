import 'package:flutter/cupertino.dart';
import 'package:uni_online_shop/views/shared/rounded_button.dart';

import '../../controllers/constant.dart';

class BasketSummary extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onBuy;

  const BasketSummary({
    super.key,
    required this.totalPrice,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22.0, 12.0, 22.0, 0),
            child: Row(
              children: [
                Text('Total: ', style: kRegularTextStyle),
                Text(
                  "${totalPrice.toStringAsFixed(2)} \$",
                  style: kMainTextStyle.copyWith(color: kSecondaryColor),
                ),
              ],
            ),
          ),
          RoundedButton(
            title: 'Buy',
            color: kSecondaryColor,
            textColor: kWhiteColor,
            onPressed: onBuy,
          ),
        ],
      ),
    );
  }
}