import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/main_page_provider.dart';

import 'bottom_nav_widget.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageNotifier>(
        builder: (context ,mainPageNotifier , child){
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BottomNavWidget(
                      onTap: () {
                        mainPageNotifier.pageIndex = 0;
                      },
                      icon: mainPageNotifier.pageIndex == 0 ? Icons.home : Icons.home_outlined,
                    ),
                    // BottomNavWidget(
                    //   onTap: () {
                    //     mainPageNotifier.pageIndex = 1;
                    //   },
                    //   icon: mainPageNotifier.pageIndex == 1 ? Icons.search : Icons.search_outlined,
                    // ),
                    BottomNavWidget(
                      onTap: () {
                        mainPageNotifier.pageIndex = 1;
                      },
                      icon: mainPageNotifier.pageIndex == 1 ? Ionicons.heart : Ionicons.heart_circle_outline,
                    ),
                    BottomNavWidget(
                      onTap: () {
                        mainPageNotifier.pageIndex = 2;
                      },
                      icon: mainPageNotifier.pageIndex == 2 ? Icons.credit_card : Icons.credit_card_outlined,
                    ),
                    BottomNavWidget(
                      onTap: () {
                        mainPageNotifier.pageIndex = 3;
                      },
                      icon: mainPageNotifier.pageIndex == 3 ? Icons.person : Icons.person_outline,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}