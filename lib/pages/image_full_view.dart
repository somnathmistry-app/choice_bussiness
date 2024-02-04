import 'package:flutter/material.dart';



class ImageFullView extends StatelessWidget {
  final imgLink;
  const ImageFullView(this.imgLink,{super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white54,),
      body: ListView(
        children: [
          Container(
            child: Image.network(imgLink),
          ),
        ],
      ),
    );
  }
}
