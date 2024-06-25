import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../models/fetch_portfolio_model.dart';


class ImageDetialsViewList extends StatefulWidget {
  RxList<PortfolioImage>? imagesList;
  int pageIndex;

  ImageDetialsViewList(this.imagesList, this.pageIndex);

  @override
  State<ImageDetialsViewList> createState() => _ImageDetialsViewListState();
}

class _ImageDetialsViewListState extends State<ImageDetialsViewList> {
  //int pageIndex = ;
  void _imageIncreament() {
    setState(() {

      widget.pageIndex++;
      if(widget.pageIndex >= widget.imagesList!.length)
        widget.pageIndex = 0;
    });
  }

  void _imageDecreament() {
    print('widget.imagesList!.length: '+widget.imagesList!.length.toString());
    setState(() {

      if(widget.pageIndex == 0) {
        widget.pageIndex = widget.imagesList!.length-1;
      }else{
        widget.pageIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

print('pageindex: ${widget.pageIndex}');
    return Scaffold(
      body: ListView(
       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Center(
      child: InteractiveViewer(
      panEnabled: false, // Set it to false
          boundaryMargin: EdgeInsets.all(100),
          minScale: 0.5,
          maxScale: 10,
          child: Image.network(widget.imagesList![widget.pageIndex].photo.toString())
      ),
    ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: _imageDecreament, icon: Icon(Icons.arrow_back_ios_new)),
              SizedBox(width: 20),
              IconButton(onPressed: _imageIncreament, icon: Icon(Icons.arrow_forward_ios))
            ],
          )
        ],
      ),
    );
  }

  getSliderList(dynamic productImgList, index) {
    List<String> imgList = [];

    for (int i = index; i < productImgList.length; i++) {
      imgList.add(productImgList[i].photo!);

    }
    //print('imageList in slider...$imgList');

    // return imgList
    //     .map((item) => PhotoView(
    //           imageProvider: NetworkImage('$imageUrl$item'),
    //         ))
    //     .toList();

    return imgList
        .map(
          (item) => InteractiveViewer(
              panEnabled: false, // Set it to false
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 10,
              child: Image.network(item)),
        )
        .toList();
  }
}
