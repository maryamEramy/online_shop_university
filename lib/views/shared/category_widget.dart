import 'package:flutter/material.dart';
import 'package:uni_online_shop/controllers/constant.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.categoryImage,
    required this.categoryName,
  });
  final String categoryName;
  final String categoryImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: kLightPrimaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(categoryImage), height: 46, width: 46),
          Text(categoryName, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
