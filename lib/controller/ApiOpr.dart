import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:wallpaper/model/photosModel.dart';
import 'package:wallpaper/model/categoryModel.dart';

class ApiOperations {
  static List<PhotosModel> trendingWallpapers = [];
  static Future<List<PhotosModel>> getTrendingWallpaper() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"), headers: {
      "Authorization":
          "BwcSEoqXqsT0x3Qn6X8jiELWGWzU2qQH6JBxTaNA2CRBw5XqcdJdz5jq"
    }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      jsonData['photos'].forEach((element) {
        trendingWallpapers.add(PhotosModel.fromApiToApp(element));
      });
    });
    return trendingWallpapers;
  }

  static List<PhotosModel> searchWallpapersList = [];
  static Future<List<PhotosModel>> getSearchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {
          "Authorization":
              "BwcSEoqXqsT0x3Qn6X8jiELWGWzU2qQH6JBxTaNA2CRBw5XqcdJdz5jq"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      jsonData['photos'].forEach((element) {
        searchWallpapersList.clear();
        photos.forEach((element) {
          searchWallpapersList.add(PhotosModel.fromApiToApp(element));
        });
      });
    });
    return searchWallpapersList;
  }

  static List<CategoryModel> cateogryModelList = [];

  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final _random = new Random();

      PhotosModel photoModel =
          (await getSearchWallpapers(catName))[0 + _random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.imgSrc);
      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return cateogryModelList;
  }
}


// class ApiOperations {
//   static List<PhotosModel> trendingWallpapers = [];

//   static Future<List<PhotosModel>> getTrendingWallpaper() async {
//     // Check if data is already cached
//     if (trendingWallpapers.isNotEmpty) {
//       return trendingWallpapers;
//     }

//     // Fetch data if not cached
//     final response = await http.get(Uri.parse("https://api.pexels.com/v1/curated"), headers: {
//       "Authorization": "BwcSEoqXqsT0x3Qn6X8jiELWGWzU2qQH6JBxTaNA2CRBw5XqcdJdz5jq"
//     });

//     if (response.statusCode == 200) {
//       Map<String, dynamic> jsonData = jsonDecode(response.body);
//       List photos = jsonData['photos'];
//       photos.forEach((element) {
//         trendingWallpapers.add(PhotosModel.fromApiToApp(element));
//       });
//     }

//     return trendingWallpapers;
//   }

//   static List<PhotosModel> searchWallpapersList = [];

//   static Future<List<PhotosModel>> getSearchWallpapers(String query) async {
//     // Clear previous search results to avoid mixing results from different queries
//     searchWallpapersList.clear();

//     final response = await http.get(
//         Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
//         headers: {
//           "Authorization": "BwcSEoqXqsT0x3Qn6X8jiELWGWzU2qQH6JBxTaNA2CRBw5XqcdJdz5jq"
//         });

//     if (response.statusCode == 200) {
//       Map<String, dynamic> jsonData = jsonDecode(response.body);
//       List photos = jsonData['photos'];
//       photos.forEach((element) {
//         searchWallpapersList.add(PhotosModel.fromApiToApp(element));
//       });
//     }

//     return searchWallpapersList;
//   }

//   static List<CategoryModel> cateogryModelList = [];

//   static Future<List<CategoryModel>> getCategoriesList() async {
//     if (cateogryModelList.isNotEmpty) {
//       return cateogryModelList;
//     }

//     List cateogryName = ["Cars", "Nature", "Bikes", "Street", "City", "Flowers"];
//     cateogryModelList.clear();
//     for (String catName in cateogryName) {
//       final _random = new Random();
//       List<PhotosModel> photos = await getSearchWallpapers(catName);
//       if (photos.isNotEmpty) {
//         PhotosModel photoModel = photos[_random.nextInt(photos.length)];
//         cateogryModelList.add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
//       }
//     }

//     return cateogryModelList;
//   }
// }
