// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import '../shared/appstyle.dart';
//
// class CartPage extends StatefulWidget {
//   const CartPage({super.key});
//
//   @override
//   State<CartPage> createState() => _CartPageState();
// }
//
// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Stack(
//           children: [
//             SizedBox(height: 40),
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Icon(AntDesign.close, color: Colors.black),
//             ),
//             Text("My Cart", style: appstyle(36, Colors.black, FontWeight.bold)),
//             SizedBox(height: 20),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.65,
//               child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 itemCount: 5,
//                 itemBuilder: (context , index){
//                   return Padding(
//                     padding: EdgeInsets.all(8),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.all(Radius.circular(12)),
//                       child: Slidable(
//                         key: ValueKey(0), child: null,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
