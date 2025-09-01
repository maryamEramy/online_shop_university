import 'package:flutter/material.dart';
import 'package:uni_online_shop/controllers/constant.dart';

class BottomNavWidget extends StatelessWidget {
  final String imagePath;
  final double imageSize;
  final bool showLine;
  final void Function()? onTap;

  const BottomNavWidget({
    super.key,
    required this.imagePath,
    this.imageSize = 20,
    this.showLine = true,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: imageSize,
            height: imageSize,
            fit: BoxFit.cover,
          ),
          if (showLine)
            Container(
              margin: const EdgeInsets.only(top: 2),
              height: 1,
              width: 18,
              color: kWhiteColor,
            ),
        ],
      ),
    );
  }
}
