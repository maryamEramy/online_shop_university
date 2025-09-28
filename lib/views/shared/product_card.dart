import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/controllers/favorites_provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
  });

  final String id;
  final String name;
  final String image;
  final double price;
  final String category;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(color: kLightSecondaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Hero(
                      tag: "productImage_${widget.id}",
                      child: Image.network(
                        widget.image,
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      widget.name,
                      style: kRegularTextStyle.copyWith(color: kPrimaryColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 2),
                  Flexible(
                    child: Text(
                      '${widget.price}',
                      style: kSecondTextStyle.copyWith(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, _) {
                final isFavorite = favoritesNotifier.ids.contains(widget.id);
                return GestureDetector(
                  onTap: () async {
                    if (isFavorite) {
                      Map<String, dynamic>? favItem;
                      try {
                        favItem = favoritesNotifier.favorites.firstWhere(
                          (item) => item['id'] == widget.id,
                        );
                      } catch (e) {
                        favItem = null;
                      }

                      if (favItem != null) {
                        await favoritesNotifier.deleteFav(favItem['key']);
                      }
                    } else {
                      await favoritesNotifier.createFav({
                        "id": widget.id,
                        "name": widget.name,
                        "category": widget.category,
                        "price": widget.price,
                        "imageUrl": widget.image,
                      });
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 60,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        isFavorite ? KAppIcons.liked : KAppIcons.like,
                        // height: 22,
                        // width: 22,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
