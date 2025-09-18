import 'package:flutter/cupertino.dart';

import '../../controllers/constant.dart';

class TextTitleWidget extends StatelessWidget {
  const TextTitleWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: kPageTitleTextStyle,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
