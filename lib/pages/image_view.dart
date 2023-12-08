import 'package:choice_bussiness/styles/commonmodule/app_bar.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  String? img;


  ImageView(this.img);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Full view'),
      body: Center(
        child: InteractiveViewer(
          panEnabled: false, // Set it to false
          boundaryMargin: EdgeInsets.all(100),
          minScale: 0.5,
          maxScale: 6,
          child: Image.network(img!)
        ),
      ),
    );
  }
}
