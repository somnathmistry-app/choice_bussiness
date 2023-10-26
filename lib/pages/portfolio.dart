import 'package:choice_bussiness/controller/portfolio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../styles/app_colors.dart';

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  String userName = "Divya Patil";
  List<String> uploadedImages = ["image_url_1", "image_url_2", "image_url_3"];

  final box = GetStorage();
  PortfolioController portfolioController = PortfolioController.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 100,

        leading: Image.asset('assets/images/app_icon.png',fit: BoxFit.cover),
        titleSpacing: 0,
        title: Text(box.read('userId').toString()),
        actions: [
          TextButton.icon(onPressed: () {

          }, icon: const Icon(Icons.done), label: const Text('Save')),
          const SizedBox(width: 25,)
        ],

      ),
        body: GetX<PortfolioController>(initState: (context) {
          portfolioController.getPortfolioDetails();
        }, builder: (controller) {
          if (controller.isLoading.value) {
            return Scaffold(
                body: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.themeColor,
                    )));
          } else {
            return ListView(
              children: [
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                          ),
                          TextButton.icon(onPressed: () {

                          }, icon: const Icon(Icons.camera_alt_outlined), label: const Text('Add image')),
                          TextButton.icon(onPressed: () {

                          }, icon: const Icon(Icons.video_camera_back_outlined), label: const Text('Add Video')),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      // Additional user details can be added here
                    ],
                  ),
                ),
                // Image gallery
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Adjust the number of columns
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: uploadedImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                        },
                        child: Container(height: 20,width: 20,margin:const EdgeInsets.all(2),color: Colors.grey,)

                      //Image.network(uploadedImages[index]),
                    );
                  },
                ),
              ],
            );
          }
        }));
  }
}
