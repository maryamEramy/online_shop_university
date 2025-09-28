import 'package:flutter/material.dart';
import '../../controllers/constant.dart';
import '../../controllers/product_provider.dart';

class SearchWidget extends StatelessWidget {
  final ProductNotifier productNotifier;

  const SearchWidget({super.key, required this.productNotifier});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        style: kRegularTextStyle.copyWith(color: kPrimaryColor),
        decoration: InputDecoration(
          hintText: "Search products or categories",
          hintStyle: kRegularTextStyle.copyWith(color: kGrayColor),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              KAppIcons.searchBox,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
        onChanged: (value) {
          productNotifier.setSearchQuery(value);
        },
      ),
    );
  }
}
