import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import '../../controllers/constant.dart';

class TextTitleWidget extends StatelessWidget {
  const TextTitleWidget({
    super.key,
    required this.text,
    this.animatedText = false,
  });

  final String text;
  final bool animatedText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          animatedText
              ? DefaultTextStyle(
                style: kPageTitleTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [TypewriterAnimatedText(text)],
                ),
              )
              : Text(
                text,
                style: kPageTitleTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
    );
  }
}
