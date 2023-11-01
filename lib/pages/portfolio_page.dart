import 'dart:io';

import 'package:choice_bussiness/controller/portfolio_controller.dart';
import 'package:choice_bussiness/controller/save_image_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../styles/app_colors.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  SavePortfolioController savePortfolioController = SavePortfolioController.to;
  String userName = "Divya Patil";

  List<File> selectedFiles = [];
  List<String> imgsStr = [];

  void _openFilePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        allowMultiple: true,
      );

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path.toString())).toList();
        List<String> filePaths = files.map((e) => e.path).toList();
        setState(() {
          selectedFiles.addAll(files);
          imgsStr.addAll(filePaths);
        });
      }
    } catch (e) {
      print('Error picking files: $e');
    }
  }

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
              savePortfolioController.save(imgPathList: imgsStr);
              selectedFiles.clear();
            }, icon: const Icon(Icons.done), label: const Text('Save')),
            const SizedBox(width: 25,)
          ],

        ),
        body: GetX<PortfolioController>(initState: (context) {
          portfolioController.getPortfolioDetails();
        }, builder: (controller) {
          if (controller.isLoading.value){
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
                            backgroundImage: AssetImage('assets/images/profile.jpg'),
                          ),
                          TextButton.icon(onPressed: _openFilePicker,
                              icon: const Icon(Icons.camera_alt_outlined), label: const Text('Add image')),
                          selectedFiles.isNotEmpty?
                              selectedFiles.length < 8?
                              Expanded(
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, // Adjust the number of columns
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: selectedFiles.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                        onTap: () {
                                        },
                                        child: Container(height: 20,width: 20,
                                          margin:const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              image:
                                              selectedFiles.toString() != ''?
                                              DecorationImage(
                                                  image: FileImage(selectedFiles[index]))
                                                  : null
                                          ),
                                        )
                                      //Image.network(uploadedImages[index]),
                                    );
                                  },
                                ),
                              ):
                          Expanded(
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, // Adjust the number of columns
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 8,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                    },
                                    child: Container(height: 20,width: 20,
                                      margin:const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          image:
                                          selectedFiles.toString() != ''?
                                          DecorationImage(
                                              image: FileImage(selectedFiles[index]))
                                              : null
                                      ),
                                    )
                                  //Image.network(uploadedImages[index]),
                                );
                              },
                            ),
                          ): Container(),
                          // TextButton.icon(onPressed: () {
                          //
                          // }, icon: const Icon(Icons.video_camera_back_outlined), label: const Text('Add Video')),
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
              ],
            );
          }
        }));
  }
}
