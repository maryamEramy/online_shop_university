import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/views/shared/text_title_widget.dart';
import '../../controllers/main_page_provider.dart';
import 'divider_widget.dart';

class BodyUi extends StatelessWidget {
  const BodyUi({
    super.key,
    required this.children,
    this.headerTitle,
    this.showBackIcon = false,
    this.showBasketIcon = false,
    this.animatedText = false,
    this.backgroundColor,
  });

  final List<Widget> children;
  final String? headerTitle;
  final Color? backgroundColor;
  final bool showBackIcon;
  final bool showBasketIcon;
  final bool animatedText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor ?? kPrimaryColor,
        body: Column(
          children: [
            SizedBox(height: 20),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    if (showBackIcon)
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          color: Colors.transparent,
                          width: 48,
                          height: 48,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: kSecondaryColor,
                              size: 22,
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(width: 48),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextTitleWidget(
                        text: headerTitle ?? "NOZAMA",
                        animatedText: animatedText,
                      ),
                    ),
                    SizedBox(width: 20),
                    if (showBasketIcon)
                      GestureDetector(
                        onTap:
                            () =>
                                Provider.of<MainPageNotifier>(
                                      context,
                                      listen: false,
                                    ).pageIndex =
                                    3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          width: 48,
                          height: 48,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Image.asset(
                              KAppIcons.cart,
                              height: 22,
                              width: 22,
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
            DividerWidget(),
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
      ),
    );
  }
}
