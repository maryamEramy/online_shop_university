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
      body: Column(
        children: [
          SizedBox(height: 20),

          // Header
          SizedBox(
            height: 40,
            width: double.infinity,
            child: Row(
              children: [
                if (showBackIcon)
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(Icons.arrow_back_ios, color: kSecondaryColor),
                    ),
                  )
                else
                  const SizedBox(width: 48), // بالانس

                Expanded(
                  child: TextTitleWidget(text: headerTitle ?? "NOZAMA"),
                ),

                const SizedBox(width: 48), // بالانس سمت راست
              ],
            ),
          ),

          // SizedBox(
          //   height: 40,
          //   width: double.infinity, // مهم: عرض کامل صفحه
          //   child: Stack(
          //     children: [
          //       // تایتل همیشه وسط صفحه
          //       Center(
          //         child: TextTitleWidget(
          //           text: headerTitle ?? "NOZAMA",
          //         ),
          //       ),
          //
          //       // آیکون بک سمت چپ
          //       if (showBackIcon)
          //         Positioned(
          //           left: 0, // همیشه سمت چپ
          //           top: 0,
          //           bottom: 0,
          //           child: GestureDetector(
          //             onTap: () => Navigator.pop(context),
          //             child: const Padding(
          //               padding: EdgeInsets.symmetric(horizontal: 16),
          //               child: Icon(Icons.arrow_back_ios, color: kSecondaryColor),
          //             ),
          //           ),
          //         ),
          //     ],
          //   ),
          // ),

          DividerWidget(),

          // محتوا
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


