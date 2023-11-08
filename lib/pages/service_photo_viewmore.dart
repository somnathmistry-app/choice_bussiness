import 'package:flutter/material.dart';


class ServicePhotos extends StatelessWidget {
  final controller;
  const ServicePhotos(this.controller,{super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Adjust the number of columns
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.artisImages.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
              },
              child: Container(height: 20,width: 20,
                margin:const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    image:
                    controller.artisImages[index].photo.toString() != ''?
                    DecorationImage(
                        image: NetworkImage(controller.artisImages[index].photo))
                        : null
                ),
              )
            //Image.network(uploadedImages[index]),
          );
        },
      ),
    );
  }
}
