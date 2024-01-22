import 'package:flutter/material.dart';
import 'package:wallpaper/controller/ApiOpr.dart';
import 'package:wallpaper/model/photosModel.dart';
import 'package:wallpaper/views/widgets/customAppBar.dart';
import 'package:wallpaper/views/widgets/searchBar.dart';

import 'fullScreen.dart';

class SearchScreen extends StatefulWidget {
  String query;
  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<PhotosModel> searchResults = [];
  GetSearchResults() async {
    searchResults = await ApiOperations.getSearchWallpapers(widget.query);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetSearchResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          centerTitle: true,
          elevation: 0.0,
          title: customAppBar(
            word1: "Wallpaper",
            word2: " Shar",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              searchBar(),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.all(6.0),
                  height: 700,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 350,
                        crossAxisCount: 2,
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: searchResults.length,
                      itemBuilder: ((context, index) => GridTile(
                              child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreen(
                                          imgUrl:
                                              searchResults[index].imgSrc)));
                            },
                            child: Container(
                                // height:50,
                                // width:50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  // color: Colors.amberAccent,
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                        searchResults[index].imgSrc,
                                        // "https://images.pexels.com/photos/1433052/pexels-photo-1433052.jpeg?auto=compress&cs=tinysrgb&w=600",
                                        height: 1000,
                                        width: 50,
                                        fit: BoxFit.cover))),
                          ))),
                    ),
                  ))
            ],
          ),
        ));
  }
}
