import 'package:flutter/material.dart';
import 'package:wallpaper/controller/ApiOpr.dart';
import 'package:wallpaper/model/photosModel.dart';
import 'package:wallpaper/views/widgets/customAppBar.dart';
import 'package:wallpaper/views/widgets/searchBar.dart';

import 'fullScreen.dart';

class catScreen extends StatefulWidget {
  String catImgUrl;
  String catName;
  catScreen({super.key, required this.catImgUrl, required this.catName});

  @override
  State<catScreen> createState() => _catScreenState();
}

class _catScreenState extends State<catScreen> {
  List<PhotosModel> catResults = [];
  bool isLoading = true;
  GetCatRelWall() async {
    catResults = await ApiOperations.getSearchWallpapers(widget.catName);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetCatRelWall();
    super.initState();
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
            word2: "Shar",
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.grey,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    widget.catImgUrl,
                    // "https://images.pexels.com/photos/60130/pexels-photo-60130.jpeg?auto=compress&cs=tinysrgb&w=600"
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black38,
                    // child: Text("Shar")
                  ),
                  
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top:40),
                      // color: Colors.blue,
                      child:
                          Text(
                            widget.catName,
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
              searchBar(),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 700,
                child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 400,
                        crossAxisCount: 2,
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 10),
                    itemCount: catResults.length,
                    itemBuilder: ((context, index) => GridTile(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreen(
                                          imgUrl: catResults[index].imgSrc)));
                            },
                            child: Hero(
                              tag: catResults[index].imgSrc,
                              child: Container(
                                height: 800,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.amberAccent,
                                    borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                      height: 800,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      catResults[index].imgSrc),
                                ),
                              ),
                            ),
                          ),
                        ))),
              )
            ],
          ),
        ));
  }
}


