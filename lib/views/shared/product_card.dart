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
  final String price;
  final String category;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 200,
          width: 140,
          decoration: BoxDecoration(
            color: kLightSecondaryColor,
            boxShadow: [
              BoxShadow(
                color: kGrayColor,
                spreadRadius: 10,
                blurRadius: 0.8,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    right: 4,
                    top: 4,
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
                          child: Image.asset(
                            isFavorite ? kAppIcons.liked : kAppIcons.like,
                            height: 20,
                            width: 20,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 100,
                child: Text(
                  widget.name,
                  style: kRegularTextStyle.copyWith(color: kPrimaryColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.category,
                    style: kSecondTextStyle.copyWith(color: kPrimaryColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.price,
                    style: kSecondTextStyle.copyWith(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
