import 'package:flutter/material.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/views/shared/text_title_widget.dart';
import 'divider_widget.dart';

class BodyUi extends StatelessWidget {
  const BodyUi({
    super.key,
    required this.children,
    this.headerTitle,
    this.showBackIcon = false,
  });

  final List<Widget> children;
  final String? headerTitle;
  final bool showBackIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showBackIcon)
                  SizedBox(
                    width: 10,
                    child: GestureDetector(
                      child: Icon(Icons.arrow_back_ios, color: kSecondaryColor),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                TextTitleWidget(text: headerTitle ?? "NOZAMA"),
                if (showBackIcon) SizedBox(width: 10),
              ],
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     if (showBackIcon)
            //       SizedBox(
            //         width: 10,
            //         child: GestureDetector(
            //           child: Icon(Icons.arrow_back_ios, color: kSecondaryColor),
            //           onTap: () {
            //             Navigator.pop(context);
            //           },
            //         ),
            //       ),
            //     TextTitleWidget(text: headerTitle ?? "NOZAMA"),
            //   ],
            // ),
            DividerWidget(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
