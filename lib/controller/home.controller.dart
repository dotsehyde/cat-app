import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:simpleapp/model/cat.model.dart';

class HomeController extends ChangeNotifier {
  static final HomeController _insatance = HomeController._internal();

  factory HomeController() => _insatance;

  final Dio dio = Dio();
  HomeController._internal();
  CatImage? cat;

  Future<CatImage> getCatImg() async {
    if (cat != null) {
      return cat!;
    }
    var res =
        await dio.get("https://api.thecatapi.com/v1/images/search?limit=1");
    print(res.data);

    if (res.statusCode != 200) {
      return Future.error("Could not fetch image");
    }
    var catData = CatImage.fromMap(res.data![0]);
    cat = catData;
    return catData;
  }
}
