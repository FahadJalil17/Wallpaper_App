import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as  http;
import 'package:wallpaper_app/model/category_model.dart';
import 'package:wallpaper_app/model/photos_model.dart';

class ApiOperations{
  static List<PhotosModel> trendingWallpaper = [];
  static List<PhotosModel> searchWallpaperList = [];
  static List<CategoryModel> categoryModelList = [];

  // List of photosmodel will be returned at the end
  static Future<List<PhotosModel>> getTrendingWallpaper() async{
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"),
    // we will pass authorization key in headers
      headers: {
      "Authorization" : "3aB8L87dOdbM2UKq3uNnwBHDNgLXgj2SI5hX7jsirm4DRKhmKYcp904P"
        }
    ).then((value){
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData["photos"];
      photos.forEach((element) {
        // Map<String, dynamic> src = element["src"];
        // print(src["portrait"]);
        // add this photomodel in trending wallpaper
       trendingWallpaper.add(PhotosModel.fromApiToApp(element));
      });
    });
    return trendingWallpaper;
  }


  static Future<List<PhotosModel>> searchWallpapers(String query) async{
    await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        // we will pass authorization key in headers
        headers: {
          "Authorization" : "3aB8L87dOdbM2UKq3uNnwBHDNgLXgj2SI5hX7jsirm4DRKhmKYcp904P"
        }
    ).then((value){
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData["photos"];
      searchWallpaperList.clear();
      photos.forEach((element) {
        // add this photomodel in trending wallpaper
        searchWallpaperList.add(PhotosModel.fromApiToApp(element));
      });
    });
    return searchWallpaperList;
  }


  static List<CategoryModel> getCategoriesList(){
    List categoryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers",
      "Gaming",
      "Sports",
    ];
    categoryModelList.clear();
    categoryName.forEach((catName) async{
      final _random = Random();
      PhotosModel photosModel = (await searchWallpapers(catName))[0 + _random.nextInt(11 - 0)];

      categoryModelList.add(CategoryModel(catName: catName, catImgUrl: photosModel.imgSrc));
    });
    return categoryModelList;
  }

}
