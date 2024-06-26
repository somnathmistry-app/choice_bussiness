import 'dart:io';

import 'package:choice_bussiness/controller/profile_update_controller.dart';
import 'package:choice_bussiness/pages/dashboard.dart';
import 'package:choice_bussiness/pages/image_full_view.dart';
import 'package:choice_bussiness/pages/login.dart';
import 'package:choice_bussiness/pages/portfolio_page.dart';
import 'package:choice_bussiness/pages/subscription.dart';
import 'package:choice_bussiness/styles/app_colors.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/portfolio_controller.dart';
import '../styles/button_style.dart';
import 'image_details_view.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //const ProfileScreen({super.key});
  final box = GetStorage();

  final _formKey = GlobalKey<FormState>();

  ProfileUpdateController profileUpdateController = ProfileUpdateController.to;
  Future<void> _dialogBuilder(BuildContext context, img) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 120),
          child: InkWell(
            onTap: () {
              Get.off(()=> ImageFullView(img));
            },
            child: Container(
              margin:const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(image: NetworkImage(img),fit: BoxFit.cover)),
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white54,
                      child: IconButton(
                          color:Colors.black,
                          onPressed: () {
                            Get.back();
                          }, icon: const Icon(Icons.cancel_outlined)),
                    ),
                  ),
                ],
              ),

            ),
          ),
        );
      },
    );
  }
  Future<void> _dialogCover(BuildContext context, img) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 200),
          child: Container(
            margin:const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.white10,
                image: DecorationImage(image: NetworkImage(img),fit: BoxFit.contain)),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white54,
                    child: IconButton(
                        color:Colors.black,
                        onPressed: () {
                          Get.back();
                        }, icon: const Icon(Icons.cancel_outlined)),
                  ),
                ),
              ],
            ),

          ),
        );
      },
    );
  }
  _logOut(context){
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Log Out?'),
        content: const Text('Are your sure your want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.offAll(()=> const LoginView());
              box.erase();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  File? selectedFile;
  String imgsStr = '';

  void _openFilePicker(String type) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result != null) {
        selectedFile = File(result.files.single.path.toString());
        imgsStr = selectedFile!.path;
        setState(() {
        });
        if(type == 'profile'){
          print(selectedFile);
          print(imgsStr);
          profileUpdateController.profileUpdate(profilePhoto: imgsStr);
        }
        if(type == 'cover'){
          profileUpdateController.profileUpdate(coverPhoto: imgsStr);
        }

      }
    } catch (e) {
      print('Error picking files: $e');
    }
  }

  PortfolioController portfolioController = PortfolioController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.offWhite,
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
            profileUpdateController.business_name.text = controller.artisDetails[0].businessName.toString();
            profileUpdateController.description.text = controller.artisDetails[0].description.toString();
            profileUpdateController.facebook_link.text = controller.artisDetails[0].facebookLink == null ? '' : controller.artisDetails[0].facebookLink.toString();
            profileUpdateController.insta_link.text = controller.artisDetails[0].instagramLink == null? '': controller.artisDetails[0].instagramLink.toString();
            return ListView(
              padding: EdgeInsets.zero,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // Cover Photo
                    InkWell(
                      onTap: () {
                        if(controller.artisDetails[0].coverPhoto.toString() != 'null'){
                          _dialogCover(context,'https://psbeauty.co.in/app/${controller.artisDetails[0].coverPhoto.toString()}');
                        }
                      },
                      child: Container(
                        height: 200,
                        margin: const EdgeInsets.only(bottom: 80),
                        decoration:  BoxDecoration(
                          color: Colors.white,
                          image: controller.artisDetails[0].coverPhoto.toString() == 'null'?
                          const DecorationImage(
                            image: AssetImage('assets/images/app_icon.png'),
                            // Replace with your cover photo
                            fit: BoxFit.cover,
                          ):
                          DecorationImage(
                            image: NetworkImage('https://psbeauty.co.in/app/${controller.artisDetails[0].coverPhoto.toString()}'),
                            // Replace with your cover photo
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 30,
                        left: 10,
                        child: Container(
                          color: Colors.black26,
                          child: IconButton(
                              onPressed: (){
                            Get.offAll(Dashboard());
                            print('back');
                          }, icon: Icon(Icons.arrow_back_ios_new_outlined, color: AppColors.white,)),
                        )),

                    // Profile Photo
                    Positioned(
                      top: 140,
                      left: 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if(controller.artisDetails[0].profilePhoto.toString() != 'null'){
                                _dialogBuilder(context,'https://psbeauty.co.in/app/${controller.artisDetails[0].profilePhoto.toString()}');
                              }
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image:controller.artisDetails[0].profilePhoto.toString() == 'null'? null :DecorationImage(
                                    image: NetworkImage(
                                        'https://psbeauty.co.in/app/${controller.artisDetails[0].profilePhoto.toString()}'
                                    ), fit: BoxFit.cover
                                ),
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColors.themeColorTwo,
                                  width: 3.0,
                                ),
                              ),
                              //// _changeImage(context);

                            ),
                          ),
                          InkWell(
                            onTap: (){
                              _changeImage(context);
                            },
                            child: Container(
                              width: 100,
                              height: 30,
                              child: Center(child: Text('Edit'))
                            ),
                          )
                        ],
                      ),
                    ),

                    // Profile Info (Name, etc.)
                    Positioned(
                      top: 200,
                      left: 140,
                      right: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.white54,
                                child: Text(
                                  controller.artisDetails[0].businessName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              controller.artisDetails[0].location == null?
                              const SizedBox(height: 10,):
                              Text(
                                controller.artisDetails[0].location.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              // Add more profile information here
                            ],
                          ),
                          IconButton(
                            //padding: const EdgeInsets.only(right: 20),
                              onPressed: () {
                                print('https://psbeauty.co.in/app/${controller.artisDetails[0].profilePhoto.toString()}');
                                _changeProfileData(context);
                              }, icon: Icon(Icons.edit,size: 20,color: AppColors.themeColorTwo,)),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: MyWidgets.textView('About Business :',Colors.black,17),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: MyWidgets.textView(controller.artisDetails[0].description.toString(), Colors.grey, 15),
                ),
                Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: MyWidgets.textView(
                          'Profile Details :',Colors.black,17),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          onPressed: () {
                            _changeSocialMediaDetails(context);
                          }, icon: Icon(Icons.edit,size: 20,color: AppColors.themeColorTwo)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10
                ), Row(
                  children: [
                    const SizedBox(
                        width: 30
                    ),
                    Image.asset('assets/images/call.png',scale: 24,),
                    controller.artisDetails[0].phoneNumber.toString() == 'null' ?
                    MyWidgets.textView(' Add Number', AppColors.black, 15)
                        :MyWidgets.textView('  ${controller.artisDetails[0].phoneNumber.toString()}', AppColors.black, 15),
                  ],
                ),const SizedBox(
                    height: 5
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 27
                    ),
                    const Icon(Icons.facebook,color: Colors.blueAccent),
                    controller.artisDetails[0].facebookLink == null ?
                    MyWidgets.textView(' Facebook', AppColors.black, 15)
                        :Expanded(child: Text('  ${controller.artisDetails[0].facebookLink.toString()}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 15),),),
                  ],
                ),
                const SizedBox(
                  height: 5
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 27
                    ),
                    Image.asset('assets/images/insta_img.png',scale: 25),
                    controller.artisDetails[0].instagramLink == null ?
                    MyWidgets.textView(' Instagram', AppColors.black, 15):
                    Expanded(
                      child: Text('  ${controller.artisDetails[0].instagramLink}',
                        overflow: TextOverflow.ellipsis, 
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                    height: 10
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                      style: elevatedButtonStyleThemeColor,
                      onPressed: (){
Get.to(Subscription());
                      }, child: MyWidgets.textView('My Subscription', AppColors.white, 14)),
                ),
                const SizedBox(
                  height: 10
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  //height: 270,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        offset: Offset(
                          0,
                          2,
                        ),
                      )
                    ],
                  ),
                  child: GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Adjust the number of columns
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.artisImages.length>6?6:controller.artisImages.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Generate other items as needed
                      return GestureDetector(
                          onTap: () {
                            Get.to(()=>ImageDetialsViewList(controller.artisImages, index));
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(image: NetworkImage(controller.artisImages[index].photo), fit: BoxFit.cover)),

                          )

                        //Image.network(uploadedImages[index]),
                      );

                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: elevatedCurveButtonStyleRed,
                        onPressed: (){
                          _logOut(context);
                    }, child: MyWidgets.textView('Logout', AppColors.white, 14)),
                    ElevatedButton(
                        style: elevatedButtonStyleStripe,
                        onPressed: (){
                          Get.to(PortfolioPage());
                        }, child: MyWidgets.textView('View Portfolio', AppColors.white, 14)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          }
        }));
  }

  _changeImage(context){
    return  showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          //color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColorTwo)),
                  child: const Text('Change Profile Photo',style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    _openFilePicker('profile');
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColorTwo)),
                  child: const Text(' Change Cover Photo ',style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    _openFilePicker('cover');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _changeProfileData(context){
    return  showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Container(
              height: 270,
              color: AppColors.themeColorTwo,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          style:
                          TextStyle(
                              color: AppColors.white, fontSize: 18),
                          controller: profileUpdateController.business_name,
                          validator: (value) => value!.isEmpty
                              ? 'Update business name'
                              : null,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 14),
                              enabled: true,
                              labelText: 'Update business name',
                              labelStyle: TextStyle(
                                fontSize: 16,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                // light
                                fontStyle: FontStyle.normal,
                              ),
                              errorStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.w600,
                                // light
                                fontStyle: FontStyle.normal,
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColors.themeColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColors.white)),
                              errorBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.orangeAccent)))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          style:
                          TextStyle(
                              color: AppColors.white, fontSize: 18),
                          controller: profileUpdateController.description,
                          validator: (value) => value!.isEmpty
                              ? 'Update business about'
                              : null,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 14),
                              enabled: true,
                              labelText: 'Update business about',
                              labelStyle: TextStyle(
                                fontSize: 16,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                // light
                                fontStyle: FontStyle.normal,
                              ),
                              errorStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.w600,
                                // light
                                fontStyle: FontStyle.normal,
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColors.themeColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColors.white)),
                              errorBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.orangeAccent)))),
                    ),

                    const SizedBox(height: 10,),
                    ElevatedButton(
                        style: elevatedButtonStyleWhiteCurve,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('hii');
                            profileUpdateController.profileUpdate();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: MyWidgets.textView(
                              '    SAVE    ', AppColors.themeColorTwo, 15),
                        )),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  _changeSocialMediaDetails(context){
    return  showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Container(
              height: 270,
              color: AppColors.themeColorTwo,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          style:
                          TextStyle(
                              color: AppColors.white, fontSize: 18),
                          controller: profileUpdateController.facebook_link,
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your Facebook link'
                              : null,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 14),
                              enabled: true,
                              labelText: 'Please enter your Facebook link',
                              labelStyle: TextStyle(
                                fontSize: 16,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                // light
                                fontStyle: FontStyle.normal,
                              ),
                              errorStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.w600,
                                // light
                                fontStyle: FontStyle.normal,
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColors.themeColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColors.white)),
                              errorBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.orangeAccent)))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          style:
                          TextStyle(
                              color: AppColors.white, fontSize: 18),
                          controller: profileUpdateController.insta_link,
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your Instagram link'
                              : null,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 14),
                              enabled: true,
                              labelText: 'Please enter your Instagram link',
                              labelStyle: TextStyle(
                                fontSize: 16,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                // light
                                fontStyle: FontStyle.normal,
                              ),
                              errorStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.w600,
                                // light
                                fontStyle: FontStyle.normal,
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColors.themeColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColors.white)),
                              errorBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.orangeAccent)))),
                    ),

                    const SizedBox(height: 10,),
                    ElevatedButton(
                        style: elevatedButtonStyleWhiteCurve,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('hii2');
                            profileUpdateController.profileUpdate();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: MyWidgets.textView(
                              '    SAVE    ', AppColors.themeColorTwo, 15),
                        )),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
/*

 */
