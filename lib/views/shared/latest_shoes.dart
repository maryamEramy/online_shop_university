import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:uni_online_shop/views/shared/stagger_tile.dart';
import '../../models/sneakers_model.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Sneakers>> gender,
  }) : _male = gender;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
      future: _male,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else {
          final male = snapshot.data;
          // return StaggeredGridView.countBuilder(
          //   padding: EdgeInsets.zero,
          //   crossAxisCount:2,
          //   crossAxisSpacing:20,
          //   mainAxisSpacing:16,
          //   itemCount: male!.length,
          //   scrollDirection: Axis.vertical,
          //   staggeredTileBuilder:(index) => StaggerdTile.extent(
          //       (index % 2==0)? 1:1 , (index % 4 ==1 || index % 4==3)? MediaQuery.of(context).size.height*0.35 :
          //   MediaQuery.of(context).size.height*0.3),
          //   itemBuilder: (context, index) {
          //     final shoe = snapshot.data![index];
          //     return StaggerTile(imageUrl: shoe.imageUrl, name: shoe.name, price: shoe.price);
          //   },
          // );
          return MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 20,
            padding: EdgeInsets.zero,
            itemCount: male!.length,
            itemBuilder: (context, index) {
              final shoe = snapshot.data![index];
              return StaggerTile(
                imageUrl: shoe.imageUrl,
                name: shoe.name,
                price: '\$${shoe.price}',
              );
            },
          );
        }
      },
    );
  }
}
