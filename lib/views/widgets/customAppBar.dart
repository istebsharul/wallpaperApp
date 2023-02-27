import 'package:flutter/material.dart';

class customAppBar extends StatelessWidget {
  String word1;
  String word2;
  customAppBar({super.key, required this.word1, required this.word2});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: RichText(
      text: TextSpan(
          text: word1,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          children: [
            TextSpan(
              text: word2,
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ]),
    ));
  }
}
