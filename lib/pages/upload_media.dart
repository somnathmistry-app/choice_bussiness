import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../controller/upload_media_controller3.dart';
import '../styles/app_colors.dart';


class UploadMedia extends StatefulWidget {
  String? serviceID;

  UploadMedia(this.serviceID);

  @override
  _UploadMediaState createState() => _UploadMediaState();
}

class _UploadMediaState extends State<UploadMedia> {
  UploadMediaController uploadMediaController = UploadMediaController.to;
  List<File> selectedFiles = [];
  List<String> imgsStr = [];

  void _openFilePicker() async {
    selectedFiles.clear();
    imgsStr.clear();
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
  PlatformFile? _selectedVideo;

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      setState(() {
        _selectedVideo = result.files.single;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.themeColorTwo,
      actions: [
        TextButton.icon(onPressed: () {
          if(_selectedVideo != null){
            uploadMediaController.upload(widget.serviceID!,imgPathList: imgsStr,videoPath:  _selectedVideo!.path);
          }else{
            uploadMediaController.upload(widget.serviceID!,imgPathList: imgsStr);
          }

        }, icon: const Icon(Icons.done,color: Colors.white), label: const Text('Done',style: TextStyle(color: Colors.white),)),
        const SizedBox(width: 20,)
      ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                // ElevatedButton(
                //   style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.themeColorTwo)),
                //   onPressed: _pickVideo,
                //   child: const Text('Pick Videos',style: TextStyle(color: Colors.white)),
                // ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.themeColorTwo)),
                  onPressed: _openFilePicker,
                  child: const Text('Pick Images',style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
             const SizedBox(height: 20),
            // const Text(
            //   'Selected Video:',
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 10),
            // _selectedVideo != null?
            // Text('Selected Video: ${_selectedVideo!.name}',style: const TextStyle(color: Colors.black)):const Text('No video selected'),
            // const SizedBox(height: 10),
            const Text(
              'Selected Images:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),const SizedBox(height: 20.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: selectedFiles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(image: DecorationImage(image: FileImage(File(selectedFiles[index].path),
                      ),fit: BoxFit.cover,)),
                    child: Stack(
                      children:  [
                        Positioned(
                            bottom: 10,
                            right: 10,
                            child: InkWell(
                                onTap: () {
                                  selectedFiles.remove(selectedFiles[index]);
                                  setState(() {
                                  });
                                },
                                child: const Icon(Icons.cancel_outlined,color: Colors.white,size: 30,)
                            )),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
