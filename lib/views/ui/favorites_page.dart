import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/favorites_provider.dart';
import 'package:uni_online_shop/views/ui/main_page.dart';
import '../shared/appstyle.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo/top_of_screen.png"),
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'My Favorites',
                  style: appstyle(36, Colors.black, FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: favoritesNotifier.fav.length,
                padding: EdgeInsets.only(top: 100),
                itemBuilder: (BuildContext context, int index) {
                  final shoe = favoritesNotifier.fav[index];
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.11,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          boxShadow: [BoxShadow(color: Colors.black)],
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
                                Padding(padding: EdgeInsets.only(top: 12 , left: 20),child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(shoe['name']),
                                    SizedBox(height: 5,),
                                    Text(shoe['category']),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${shoe['price']}'),
                                      ],
                                    )
                                  ],
                                ),)
                              ],
                            ),
                            Padding(padding: EdgeInsets.all(8) , child: GestureDetector(
                              onTap: (){
                                favoritesNotifier.deleteFav(shoe['key']);
                                favoritesNotifier.ids.removeWhere((element) => element == shoe['id']);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                              },
                              child: Icon(Ionicons.md_heart_dislike),
                            ),)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
