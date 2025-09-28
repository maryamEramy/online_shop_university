import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/constant.dart';
import '../../controllers/favorites_provider.dart';
import '../../models/sneakers_model.dart';

class FavoriteButton extends StatelessWidget {
  final ProductInfo product;

  const FavoriteButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesNotifier, _) {
        final isFavorite = favoritesNotifier.ids.contains(product.id);
        return GestureDetector(
          onTap: () async {
            if (isFavorite) {
              Map<String, dynamic>? favItem;
              try {
                favItem = favoritesNotifier.favorites.firstWhere(
                  (item) => item['id'] == product.id,
                );
              } catch (e) {
                favItem = null;
              }
              if (favItem != null) {
                await favoritesNotifier.deleteFav(favItem['key']);
              }
            } else {
              await favoritesNotifier.createFav({
                "id": product.id,
                "name": product.name,
                "category": product.category,
                "price": product.price,
                "imageUrl": product.imageUrl,
              });
            }
          },
          child: Container(
            color: Colors.transparent,
            width: 60,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(isFavorite ? KAppIcons.liked : KAppIcons.like),
            ),
          ),
        );
      },
    );
  }
}
