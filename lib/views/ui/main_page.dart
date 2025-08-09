import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/conrollers/main_page_provider.dart';
import 'package:uni_online_shop/views/ui/card_page.dart';
import 'package:uni_online_shop/views/ui/product_by_category.dart';
import 'package:uni_online_shop/views/ui/profile_page.dart';
import 'package:uni_online_shop/views/ui/search_page.dart';
import '../shared/bottom_nav.dart';
import 'add_page.dart';
//
// class MainPage extends StatelessWidget {
//   MainPage({super.key});
//
//   List<Widget> pageList = const [
//     HomePage(),
//     SearchPage(),
//     AddPage(),
//     CardPage(),
//     ProfilePage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MainPageNotifier>(
//       builder: (context, mainPageNotifier, child) {
//         return Scaffold(
//           backgroundColor: const Color(0xFFE2E2E2),
//
//           body: pageList[mainPageNotifier.pageIndex],
//
//           bottomNavigationBar: const BottomNavBar(),
//         );
//       },
//     );
//   }
// }
//
//
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> pageList;

  @override
  void initState() {
    super.initState();
    pageList = const [
      ProductByCategory(),
      SearchPage(),
      AddPage(),
      CardPage(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageNotifier>(
      builder: (context, mainPageNotifier, child) {
        int safeIndex = mainPageNotifier.pageIndex;
        if (safeIndex < 0 || safeIndex >= pageList.length) {
          safeIndex = 0;
        }

        return Scaffold(
          backgroundColor: const Color(0xFFFFFFFF),
          body: pageList[safeIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
