import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/controllers/favorites_provider.dart';
import 'package:uni_online_shop/views/shared/appstyle.dart';
import 'package:uni_online_shop/views/ui/favorites_page.dart';

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
  // final _favBox = Hive.box('fav_box');

  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(
      context,
      listen: true,
    );
    favoritesNotifier.getFavorites();
    bool selected = false;
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      //وقتی میخوایی عکسی یا ویجتی گوشه هاش گرد باشه => clipRRect
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          // padding: EdgeInsets.all(10),
          height: 140,
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
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: GestureDetector(
                      onTap: () async {
                        if (favoritesNotifier.ids.contains(widget.id)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoritesPage(),
                            ),
                          );
                        } else {
                          favoritesNotifier.createFav({
                            "id": widget.id,
                            "name": widget.name,
                            "category": widget.category,
                            "price": widget.price,
                            "imageUrl": widget.image,
                          });
                        }
                        setState(() {});
                      },
                      child:
                          favoritesNotifier.ids.contains(widget.id)
                              ? Image(
                                image: AssetImage(kAppIcons.like),
                                height: 16,
                                width: 16,
                              )
                              : Image(
                                image: AssetImage(kAppIcons.liked),
                                height: 16,
                                width: 16,
                              ),
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
                    style: kSecondTextStyle.copyWith(
                      color: kPrimaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    widget.price,
                    style: kSecondTextStyle.copyWith(
                      color: kPrimaryColor, fontWeight: FontWeight.w700
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
