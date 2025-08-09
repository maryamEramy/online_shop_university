import 'package:flutter/services.dart' as the_bundle;
import 'package:uni_online_shop/models/sneakers_model.dart';
class Helper{

  //list*************

  Future<List<Sneakers>> getMaleSneaker() async {
    final data = await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
    final maleList = sneakersFromJson(data);

    return maleList;
  }


  Future<List<Sneakers>> getFemaleSneaker() async {
    final data = await the_bundle.rootBundle.loadString("assets/json/female_shoes.json");
    final femaleList = sneakersFromJson(data);

    return femaleList;
  }


  Future<List<Sneakers>> getKidsSneaker() async {
    final data = await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");
    final kidsList = sneakersFromJson(data);

    return kidsList;
  }


//single************

  Future<Sneakers> getMaleSneakerById(String id) async {
    final data = await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
    final maleList = sneakersFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  Future<Sneakers> getFemaleSneakerById(String id) async {
    final data = await the_bundle.rootBundle.loadString("assets/json/female_shoes.json");
    final femaleList = sneakersFromJson(data);
    final sneaker = femaleList.firstWhere((sneaker) => sneaker.id == id);


    return sneaker;
  }

  Future<Sneakers> getKidsSneakerById(String id) async {
    final data = await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");
    final kidsList = sneakersFromJson(data);
    final sneaker = kidsList.firstWhere((sneaker) => sneaker.id == id);


    return sneaker;
  }

}