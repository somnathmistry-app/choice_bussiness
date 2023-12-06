import 'dart:io';
import 'package:choice_bussiness/controller/delete_controller.dart';
import 'package:choice_bussiness/controller/portfolio_controller.dart';
import 'package:choice_bussiness/controller/save_image_controller.dart';
import 'package:choice_bussiness/pages/dashboard.dart';
import 'package:choice_bussiness/styles/button_style.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
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
  DeleteController deleteController = DeleteController.to;

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
  //PortfolioController portfolioController = PortfolioController.to;
  PortfolioController portfolioController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 100,
          titleSpacing: 0,
          title: Text(box.read('businessName').toString())
        ),
        floatingActionButton: ElevatedButton(
          style: elevatedButtonStyleThemeColor,
          onPressed: (){
            _openFilePicker();
        },child: Text('Choose Image'),),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          // TextButton.icon(onPressed: _openFilePicker,
                          //     icon: const Icon(Icons.camera_alt_outlined), label: const Text('Add image')),
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
                                                  image: FileImage(selectedFiles[index]), fit: BoxFit.cover)
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
                                              image: FileImage(selectedFiles[index]), fit: BoxFit.cover)
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
                      selectedFiles.isNotEmpty? SizedBox(height: 10):SizedBox(),
                      selectedFiles.isNotEmpty?ElevatedButton(
                          style: elevatedButtonStyleStripe,
                          onPressed: (){
                            if(imgsStr.isNotEmpty){
                              savePortfolioController.save(imgPathList: imgsStr);
                              selectedFiles.clear();
                            }
                            else{Get.offAll(()=> Dashboard());}
                          }, child: MyWidgets.textView('Upload', AppColors.white, 14)):SizedBox(),
                      selectedFiles.isNotEmpty? SizedBox(height: 20):SizedBox()

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
                    return Container(
                      margin:const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          image:
                          controller.artisImages[index].photo.toString() != ''?
                          DecorationImage(
                              image: NetworkImage(controller.artisImages[index].photo), fit: BoxFit.cover)
                              : null
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(onPressed: () async  {
                          //print();
                          _deleteImage(context, await getFileNameFromURL(controller.artisImages[index].photo));
                        }, icon: const Icon(Icons.delete, color: Colors.orange)),
                      ),
                    );
                  },
                ),
              ],
            );
          }
        }));
  }
  Future<String> getFileNameFromURL(String url) async {
    Uri uri = Uri.parse(url);
    return uri.pathSegments.last;
  }
  _deleteImage(context,imgname){
    print(imgname);
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Image?'),
        content: const Text('Are your sure your want to delete this image?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              deleteController.deleteImagePortfolio(imgname);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
