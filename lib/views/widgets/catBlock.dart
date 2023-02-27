import 'package:flutter/material.dart';
import 'package:wallpaper/views/screens/category.dart';


class catBlock extends StatelessWidget {

  String categoryName;
  String categoryImgSrc;
  catBlock(
      {super.key, required this.categoryImgSrc, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => catScreen(
                    catImgUrl: categoryImgSrc, catName: categoryName)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:2),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.7, // Set the opacity to 0.8 (80%)
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  categoryImgSrc,
                  // "https://images.pexels.com/photos/15286/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=600",
                  height:70,  
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              height: 70,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12)),
            ),

            Positioned.fill(
              child: Center(
                child: Text(
                  // "Nature",
                  categoryName,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        )
      )
    );
  }
}
