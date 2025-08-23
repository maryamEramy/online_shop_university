import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive_flutter/adapters.dart';
import '../shared/appstyle.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final _cartBox = Hive.box('cart_box');

  @override
  Widget build(BuildContext context) {

    List<dynamic> cart = [];

    final cartDate = _cartBox.keys.map((key){
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price'],
        "sizes": item['sizes'],
        "qty": item['qty'],
      };
    }).toList();

    cart = cartDate.reversed.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(AntDesign.close),
                        ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("My Cart", style: appstyle(36, Colors.black, FontWeight.bold)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: SizedBox(
                // height: MediaQuery.of(context).size.height * 0.65,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final data = cart[index];
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                flex: 1,
                                onPressed: (context) {},
                                backgroundColor: Color(0xFF000000),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.11,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  spreadRadius: 5,
                                  blurRadius: 0.3,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(color: Colors.blue),
                                      padding: EdgeInsets.all(12),
                                      child: CachedNetworkImage(
                                        imageUrl: data['imageUrl'],
                                        // width: 70,
                                        // height: 70,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 12, left: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(data['name'],
                                              style: appstyle(16, Colors.black, FontWeight.bold),
                                              ),
                                              Text(data['category'],
                                              style: appstyle(14, Colors.grey, FontWeight.normal),
                                              ),
                                              Row(
                                                children: [
                                                  Text("Size",
                                                    style: appstyle(14, Colors.black, FontWeight.normal),
                                                  ),
                                                  Text('${data['sizes']}',
                                                    style: appstyle(14, Colors.black, FontWeight.normal),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(data['price'],
                                            style: appstyle(14, Colors.black, FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
