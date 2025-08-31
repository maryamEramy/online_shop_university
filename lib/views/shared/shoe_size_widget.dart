// import 'package:flutter/cupertino.dart';
//
// class ShoeSizeWidget extends StatelessWidget {
//   const ShoeSizeWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount:
//       productNotifier
//           .shoeSizes
//           .length,
//       scrollDirection:
//       Axis.horizontal,
//       padding:
//       EdgeInsets.zero,
//       itemBuilder: (
//           context,
//           index,
//           ) {
//         final sizes =
//         productNotifier
//             .shoeSizes[index];
//
//         return Padding(
//           padding:
//           const EdgeInsets.symmetric(
//             horizontal:
//             8.0,
//           ),
//           child: ChoiceChip(
//             shape: RoundedRectangleBorder(
//               borderRadius:
//               BorderRadius.circular(
//                 60,
//               ),
//               side: BorderSide(
//                 color:
//                 Colors
//                     .black,
//                 width: 1,
//                 style:
//                 BorderStyle
//                     .solid,
//               ),
//             ),
//             disabledColor:
//             Colors.white,
//             label: Text(
//               sizes['size'],
//               style: appstyle(
//                 18,
//                 sizes['isSelected']
//                     ? Colors
//                     .white
//                     : Colors
//                     .black,
//                 FontWeight
//                     .w500,
//               ),
//             ),
//             selectedColor:
//             Colors.black,
//             padding:
//             EdgeInsets.symmetric(
//               vertical: 8,
//             ),
//             selected:
//             sizes['isSelected'],
//             onSelected: (
//                 newState,
//                 ) {
//               if (productNotifier
//                   .sizes
//                   .contains(
//                 sizes['size'],
//               )) {
//                 productNotifier
//                     .sizes
//                     .remove(
//                   sizes['size'],
//                 );
//               } else {
//                 productNotifier
//                     .sizes
//                     .add(
//                   sizes['size'],
//                 );
//               }
//               print(
//                 productNotifier
//                     .sizes,
//               );
//               productNotifier
//                   .toggleCheck(
//                 index,
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
//
// mixin productNotifier {
// }
