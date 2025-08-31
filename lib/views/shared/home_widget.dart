

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/product_provider.dart';
import 'package:uni_online_shop/views/shared/product_card.dart';
import 'package:uni_online_shop/views/ui/product_by_category.dart';
import 'package:uni_online_shop/views/ui/product_page.dart';
import '../../models/sneakers_model.dart';
import 'appstyle.dart';
import 'new_shoes.dart';

class HomeWidget extends StatelessWidget {
  final String category;
  final int tabIndex;

  const HomeWidget({
    super.key,
    required this.category,
    required this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context, listen: false);

    return FutureBuilder<List<ProductInfo>>(
      future: productNotifier.getProducts(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No products found"));
        } else {
          final products = snapshot.data!;

          return Column(
            children: [
              // لیست افقی بالا
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPage(
                              id: product.id,
                              category: product.category,
                            ),
                          ),
                        );
                      },
                      child: ProductCard(
                        id: product.id,
                        name: product.name,
                        image: product.imageUrl,
                        price: "\$${product.price}",
                        category: product.category,
                      ),
                    );
                  },
                ),
              ),

              // بخش "Latest"
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latest in $category",
                      style: appstyle(24, Colors.black, FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductByCategory(tabIndex: tabIndex),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "Show All",
                            style: appstyle(22, Colors.black, FontWeight.w500),
                          ),
                          const Icon(AntDesign.caretright, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // لیست افقی پایین
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
                child: ListView.builder(
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewShoes(imageUrl: product.imageUrl),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:provider/provider.dart';
// import 'package:uni_online_shop/controllers/product_provider.dart';
// import 'package:uni_online_shop/views/shared/product_card.dart';
// import 'package:uni_online_shop/views/ui/product_by_category.dart';
// import 'package:uni_online_shop/views/ui/product_page.dart';
// import '../../models/sneakers_model.dart';
// import 'appstyle.dart';
// import 'new_shoes.dart';
//
// class HomeWidget extends StatelessWidget {
//   const HomeWidget({
//     super.key,
//     required Future<List<ProductInfo>> persona,
//     required this.tabIndex,
//   }) : _male = persona;
//
//   final Future<List<ProductInfo>> _male;
//   final int tabIndex;
//
//   @override
//   Widget build(BuildContext context) {
//     var productNotifier = Provider.of<ProductNotifier>(context);
//     return Column(
//       children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.4,
//           child: FutureBuilder<List<ProductInfo>>(
//             future: _male,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               } else if (snapshot.hasError) {
//                 return Text("Error ${snapshot.error}");
//               } else {
//                 final male = snapshot.data;
//                 return ListView.builder(
//                   itemCount: male!.length,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     final shoe = snapshot.data![index];
//                     return GestureDetector(
//                       onTap: () {
//                         // productNotifier.shoeSizes = shoe.sizes;
//                         // print(productNotifier.shoeSizes);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (context) => ProductPage(
//                                   id: shoe.id,
//                                   category: shoe.category,
//                                 ),
//                           ),
//                         );
//                       },
//                       child: ProductCard(
//                         id: shoe.id,
//                         name: shoe.name,
//                         image: shoe.imageUrl,
//                         price: "\$${shoe.price}",
//                         category: shoe.category,
//                       ),
//                     );
//                   },
//                 );
//               }
//             },
//           ),
//         ),
//         Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Latest Shoes",
//                     style: appstyle(24, Colors.black, FontWeight.bold),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder:
//                               (context) =>
//                                   ProductByCategory(tabIndex: tabIndex),
//                         ),
//                       );
//                       print("***********************$tabIndex");
//                     },
//                     child: Row(
//                       children: [
//                         Text(
//                           "Show All",
//                           style: appstyle(22, Colors.black, FontWeight.w500),
//                         ),
//                         Icon(AntDesign.caretright, size: 20),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.13,
//           child: FutureBuilder<List<ProductInfo>>(
//             future: _male,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               } else if (snapshot.hasError) {
//                 return Text("Error ${snapshot.error}");
//               } else {
//                 final male = snapshot.data;
//                 return ListView.builder(
//                   itemCount: male!.length,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     final shoe = snapshot.data![index];
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: NewShoes(imageUrl: shoe.imageUrl),
//                     );
//                   },
//                 );
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
