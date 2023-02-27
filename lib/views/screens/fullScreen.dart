import 'package:flutter/material.dart';

import '../widgets/customAppBar.dart';

class FullScreen extends StatelessWidget {
  String imgUrl;
  FullScreen({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Handle back button press event here
          Navigator.pop(context); // Navigate to previous screen
          return false; // Return true to allow back button press, false to prevent it
        },
        child: Scaffold(
            body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imgUrl),
              fit: BoxFit.cover,
            ),
          ),
        )));
  }
}

    // return Scaffold(
      //  appBar: AppBar(
      //     backgroundColor: Color.fromARGB(255, 255, 255, 255),
      //     centerTitle: true,
      //     elevation: 0.0,
      //     // title: customAppBar(
      //     //   word1: "Wallpaper",
      //     //   word2: "Shar",
      //     // ),
      //     leading: IconButton(
      //       icon: Icon(Icons.arrow_back),
      //       color:Colors.grey,
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: NetworkImage(imgUrl),
//             fit:BoxFit.cover, 
//           )
//         ),
//       ),
//     );
//   }
// }