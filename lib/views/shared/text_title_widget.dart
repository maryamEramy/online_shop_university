import 'package:flutter/cupertino.dart';

import '../../controllers/constant.dart';

class TextTitleWidget extends StatelessWidget {
  const TextTitleWidget({
    super.key, required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text , style: kPageTitleTextStyle,);
  }
}
