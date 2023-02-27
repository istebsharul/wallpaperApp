import 'package:flutter/material.dart';
import 'package:wallpaper/views/screens/search.dart';

class searchBar extends StatelessWidget {
  searchBar({super.key});

  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(maxHeight: 800),
      padding: EdgeInsets.all(15),
      child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 228, 228, 228),
            border: Border.all(
              color: Color.fromARGB(255, 150, 150, 150),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                // padding: EdgeInsets.symmetric(horizontal:10.0),
              ),
              Expanded(  
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Wallpaper',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> SearchScreen(query: _searchController.text)));
                    // print("Searching.....");  
                  },
                  child: Icon(Icons.search),
                ),
              ),
            ],
          )),
    );
  }
}
