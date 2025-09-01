import 'package:flutter/material.dart';

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
    return Tab(
      child: SizedBox(
        child: Column(
          children: [
            Image(image: AssetImage(categoryImage) , height: 20,width: 20),
            Text(categoryName),
          ],
        ),
      ),
    );
  }
}
