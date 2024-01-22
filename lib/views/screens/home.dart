import 'package:flutter/material.dart';
import 'package:wallpaper/controller/ApiOpr.dart';
import 'package:wallpaper/model/categoryModel.dart';
import 'package:wallpaper/views/screens/fullScreen.dart';
import 'package:wallpaper/views/widgets/catBlock.dart';
import 'package:wallpaper/views/widgets/customAppBar.dart';
import 'package:wallpaper/views/widgets/searchBar.dart';

import '../../model/photosModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PhotosModel> getTrendingWallList = [];
  List<CategoryModel> CatModList = [];
  bool isLoading = true;

  GetCatDetails() async {
    CatModList = await ApiOperations.getCategoriesList();
    print(CatModList);
    setState(() {
      CatModList = CatModList;
    });
  }

  getTrendingWallpaper() async {
    getTrendingWallList = await ApiOperations.getTrendingWallpaper();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetCatDetails();
    getTrendingWallpaper();
    // ApiOperations.getTrendingWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: customAppBar(
          word1: "Shar",
          word2: " Wallpaper",
        ),
      ),
      body: Container(
        // color: Colors.blue,
        child: SingleChildScrollView(
          child: Column(
            children: [
              searchBar(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: CatModList.length,
                    itemBuilder: (context, index) => catBlock(
                      categoryImgSrc: CatModList[index].catImgUrl,
                      categoryName: CatModList[index].catName,
                    ),
                  ),
                ),
              ),
              Container(
                // color:Colors.red,
                margin: EdgeInsets.all(6.0),
                height: 700,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 350, // Adjust this based on your needs
                      crossAxisCount: 2,
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: getTrendingWallList.length,
                    itemBuilder: (context, index) => GridTile(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreen(
                                imgUrl: getTrendingWallList[index].imgSrc,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color:
                                Colors.white, // Set the background color to black
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              getTrendingWallList[index].imgSrc,
                              height: 1000, // Adjust this based on your needs
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
