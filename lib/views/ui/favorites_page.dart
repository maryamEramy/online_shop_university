import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/favorites_provider.dart';
import 'package:uni_online_shop/views/shared/body_ui.dart';
import 'package:uni_online_shop/views/ui/product_page.dart';
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
    return BodyUi(
      headerTitle: "Wish List",
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: favoritesNotifier.fav.length,
            itemBuilder: (BuildContext context, int index) {
              final product = favoritesNotifier.fav[index];
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ProductPage(
                        id: product.id,
                        category: product.category,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: 100,
                  child: Card(
                    color: kLightPrimaryColor,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: CachedNetworkImage(imageUrl: product.imageUrl , width: 50,height: 50,fit: BoxFit.cover,),
                      title: Text(product.name , style: kRegularTextStyle,),
                      subtitle: Text("${product.category}  -   ${product.price}" , style: kSecondTextStyle,),
                      trailing: GestureDetector(
                        onTap: () {
                          favoritesNotifier.deleteFav(product.key!);
                          favoritesNotifier.ids.removeWhere(
                                (element) => element == product.id,
                          );
                        },
                        child: Image(
                          image: AssetImage(kAppIcons.liked),
                          height: 16,
                          width: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}