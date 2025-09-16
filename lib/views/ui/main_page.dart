import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/controllers/main_page_provider.dart';
import 'package:uni_online_shop/views/ui/cart_page.dart';
import 'package:uni_online_shop/views/ui/home_page.dart';
import 'package:uni_online_shop/views/ui/profile_page.dart';
import 'package:uni_online_shop/views/ui/search_page.dart';
import '../shared/bottom_nav.dart';
import 'favorites_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key , this.currentPage,});
  final int? currentPage;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> pageList;

  @override
  void initState() {
    super.initState();
    pageList = [
      const HomePage(),
      const SearchPage(),
      const FavoritesPage(),
      CartPage(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageNotifier>(
      builder: (context, mainPageNotifier, child) {
        int index = widget.currentPage ?? mainPageNotifier.pageIndex;
        if (index < 0 || index >= pageList.length) {
          index = 0;
        }

        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: pageList[index],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }

}
