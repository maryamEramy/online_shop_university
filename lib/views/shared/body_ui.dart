import 'package:flutter/material.dart';
import 'appstyle.dart';

class BodyUi extends StatelessWidget {
  const BodyUi({
    super.key,
    required this.children,
    this.headerTitle,
  });

  final List<Widget> children;
  final String? headerTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo/top_of_screen.png"),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (headerTitle != null)
                    Text(
                      headerTitle!,
                      style: appstyleWithHt(40, Colors.white, FontWeight.bold, 1.75),
                    ),
                ],
              ),
            ),
            // محتوا: حتما با Expanded تا فضای باقیمانده مدیریت شود
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
