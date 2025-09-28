import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/controllers/main_page_provider.dart';
import 'bottom_nav_widget.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(
      builder: (context, mainPageNotifier, child) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              border: BoxBorder.fromLTRB(
                top: BorderSide(color: kWhiteColor),
                left: BorderSide(color: kWhiteColor),
                right: BorderSide(color: kWhiteColor),
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomNavWidget(
                  onTap: () {
                    mainPageNotifier.pageIndex = 0;
                  },
                  imagePath: KAppIcons.home,
                  showLine: mainPageNotifier.pageIndex == 0 ? true : false,

                ),
                BottomNavWidget(
                  onTap: () {
                    mainPageNotifier.pageIndex = 1;
                  },
                  imagePath: KAppIcons.search,
                  showLine: mainPageNotifier.pageIndex == 1 ? true : false,
                ),
                BottomNavWidget(
                  onTap: () {
                    mainPageNotifier.pageIndex = 2;
                  },
                  imagePath: KAppIcons.fave,
                  showLine: mainPageNotifier.pageIndex == 2 ? true : false,
                ),
                BottomNavWidget(
                  onTap: () {
                    mainPageNotifier.pageIndex = 3;
                  },
                  imagePath: KAppIcons.cart,
                  showLine: mainPageNotifier.pageIndex == 3 ? true : false,
                ),
                BottomNavWidget(
                  onTap: () {
                    mainPageNotifier.pageIndex = 4;
                  },
                  imagePath: KAppIcons.profile,
                  showLine: mainPageNotifier.pageIndex == 4 ? true : false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
