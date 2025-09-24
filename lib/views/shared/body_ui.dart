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
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          children: [
            SizedBox(height: 20),
      
            // Header
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Row(
                children: [
                  if (showBackIcon)
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        color: Colors.transparent,
                        width: 60,
                        height: 60,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Icon(Icons.arrow_back_ios, color: kSecondaryColor , size: 22,),
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 48),
                  Expanded(
                    child: TextTitleWidget(text: headerTitle ?? "NOZAMA"),
                  ),
                  const SizedBox(width: 48),
                ],
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


