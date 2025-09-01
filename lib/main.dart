import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/favorites_provider.dart';
import 'package:uni_online_shop/controllers/main_page_provider.dart';
import 'package:uni_online_shop/controllers/product_provider.dart';
import 'package:uni_online_shop/views/ui/main_page.dart';
import 'package:uni_online_shop/views/ui/registration_page.dart';
import 'package:uni_online_shop/views/ui/splash_screen.dart';

import 'controllers/cart_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

void main() async {

  // WidgetFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');




  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainPageNotifier()),
        ChangeNotifierProvider(create: (context) => ProductNotifier()),
        ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375 , 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child){
       return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainPage(),
          // home: SplashScreen(),
         // home: Registration_page(),
       );
      },
    );
  }
}
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(const MyApp());
// }
//
// // مدل محصول
// class Product {
//   final String id;
//   final String name;
//   final String imageUrl;
//   final String price;
//   final String category;
//   final String description;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.price,
//     required this.category,
//     required this.description,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'].toString(),
//       name: json['title'],
//       imageUrl: json['thumbnail'],
//       price: (json['price'] as num).toString(), // ✅ تبدیل امن
//       category: json['category'],
//       description: json['description'],
//     );
//   }
// }
//
// // گرفتن محصولات از API
// Future<List<Product>> fetchProducts() async {
//   final response = await http.get(Uri.parse("https://dummyjson.com/products"));
//
//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     final List products = data['products'];
//     return products.map((json) => Product.fromJson(json)).toList();
//   } else {
//     throw Exception("Failed to load products");
//   }
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Online Shop',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const ProductListPage(),
//     );
//   }
// }
//
// class ProductListPage extends StatelessWidget {
//   const ProductListPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Products")),
//       body: FutureBuilder<List<Product>>(
//         future: fetchProducts(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else {
//             final products = snapshot.data!;
//             return ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   child: ListTile(
//                     leading: Image.network(
//                       product.imageUrl,
//                       width: 60,
//                       height: 60,
//                       fit: BoxFit.cover,
//                     ),
//                     title: Text(product.name),
//                     subtitle: Text("price: ${product.price} \$"),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => ProductDetailPage(product: product),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
// // صفحه جزئیات محصول
// class ProductDetailPage extends StatelessWidget {
//   final Product product;
//
//   const ProductDetailPage({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(product.name)),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(product.imageUrl, height: 200, fit: BoxFit.cover),
//             const SizedBox(height: 16),
//             Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             Text("${product.price} تومان", style: const TextStyle(fontSize: 18, color: Colors.green)),
//             const SizedBox(height: 8),
//             Text("دسته‌بندی: ${product.category}"),
//             const SizedBox(height: 16),
//             Text(product.description, style: const TextStyle(fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }        future: productNotifier.product,
// }
