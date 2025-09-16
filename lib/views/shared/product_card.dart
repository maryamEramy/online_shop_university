import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/controllers/favorites_provider.dart';
import 'package:uni_online_shop/views/ui/favorites_page.dart';

class ProductCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final favoritesNotifier = Provider.of<FavoritesNotifier>(context);

    final isFavorite = favoritesNotifier.ids.contains(id);

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
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: GestureDetector(
                      onTap: () async {
                        if (isFavorite) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoritesPage(),
                            ),
                          );
                        } else {
                          await favoritesNotifier.createFav({
                            "id": id,
                            "name": name,
                            "category": category,
                            "price": price,
                            "imageUrl": image,
                          });
                        }
                      },
                      child: Image.asset(
                        isFavorite ? kAppIcons.like : kAppIcons.liked,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 100,
                child: Text(
                  name,
                  style: kRegularTextStyle.copyWith(color: kPrimaryColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category,
                    style: kSecondTextStyle.copyWith(color: kPrimaryColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    price,
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
