// import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:provider/provider.dart';
// import 'package:uni_online_shop/controllers/product_provider.dart';
// import 'package:uni_online_shop/views/shared/category_btn.dart';
// import '../../controllers/constant.dart';
// import '../shared/appstyle.dart';
// import '../shared/custom_spacer.dart';
//
// class ProductByCategory extends StatefulWidget {
//   const ProductByCategory({super.key, required this.tabIndex});
//
//   final int tabIndex;
//
//   @override
//   State<ProductByCategory> createState() => _ProductByCategoryState();
// }
//
// class _ProductByCategoryState extends State<ProductByCategory>
//     with TickerProviderStateMixin {
//   late final TabController _tabController = TabController(
//     length: 3,
//     vsync: this,
//     initialIndex: widget.tabIndex,
//   );
//
//   List<String> brand = [
//     "assets/logo/adidas.png",
//     "assets/logo/nike.png",
//     "assets/logo/jordan.png",
//     "assets/logo/gucci.png",
//     "assets/logo/nike.png",
//     "assets/logo/adidas.png",
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//
//     final productNotifier = Provider.of<ProductNotifier>(context, listen: false);
//     List<String> categories = [
//       "mens-shoes",
//       "beauty",
//       "fragrances",
//       "furniture",
//       "groceries",
//       "laptops",
//       "mens-shirts",
//       "mens-shoes",
//       "mens-watches",
//       "home-decoration",
//       "kitchen-accessories",
//       "smartphones",
//       "motorcycle",
//       "skin-care",
//     ];
//
//     for (var category in categories) {
//       productNotifier.getProducts(category);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE2E2E2),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: Stack(
//           children: [
//             Container(
//               padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
//               height: MediaQuery.of(context).size.height,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage("assets/logo/top_of_single_screen.png"),
//                   alignment: Alignment.topCenter,
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: () => Navigator.pop(context),
//                           child: const Icon(AntDesign.close, color: Colors.white),
//                         ),
//                         GestureDetector(
//                           onTap: () => filter(),
//                           child: const Icon(FontAwesome.sliders, color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                   TabBar(
//                     tabAlignment: TabAlignment.start,
//                     indicatorSize: TabBarIndicatorSize.label,
//                     indicatorColor: Colors.transparent,
//                     controller: _tabController,
//                     isScrollable: true,
//                     dividerColor: Colors.white54,
//                     labelStyle: kMainTextStyle,
//                     unselectedLabelColor: Colors.white54,
//                     tabs: const [
//                       Tab(text: "mens-shoes"),
//                       Tab(text: "beauty"),
//                       Tab(text: "fragrances"),
//                       Tab(text: "furniture"),
//                       Tab(text: "groceries"),
//                       Tab(text: "laptops"),
//                       Tab(text: "mens-shirts"),
//                       Tab(text: "mens-shoes"),
//                       Tab(text: "mens-watches"),
//                       Tab(text: "home-decoration"),
//                       Tab(text: "kitchen-accessories"),
//                       Tab(text: "smartphones"),
//                       Tab(text: "motorcycle"),
//                       Tab(text: "skin-care"),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
