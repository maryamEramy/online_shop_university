import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/favorites_provider.dart';
import 'package:uni_online_shop/views/shared/body_ui.dart';
import 'package:uni_online_shop/views/ui/main_page.dart';
import '../../controllers/constant.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context);
    favoritesNotifier.getAllData();
    return BodyUi(
      headerTitle: "Wish List",
      children: [
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: favoritesNotifier.fav.length,
              itemBuilder: (BuildContext context, int index) {
                final shoe = favoritesNotifier.fav[index];
                return SizedBox(
                  height: 100,
                  child: Card(
                    color: kLightPrimaryColor,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: CachedNetworkImage(
                                imageUrl: shoe['imageUrl'],
                                width: 70,
                                height: 70,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12, left: 20),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      shoe['name'],
                                      style: kRegularTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    shoe['category'],
                                    style: kSecondTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${shoe['price']}',
                                        style: kSecondTextStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            favoritesNotifier.deleteFav(shoe['key']);
                            favoritesNotifier.ids.removeWhere(
                              (element) => element == shoe['id'],
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainPage(),
                              ),
                            );
                          },
                          child: Image(
                            image: AssetImage(kAppIcons.liked),
                            height: 16,
                            width: 16,
                          ),
                        ),
                        SizedBox(width: 1),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}