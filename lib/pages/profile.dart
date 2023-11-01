import 'package:choice_bussiness/pages/login.dart';
import 'package:choice_bussiness/styles/app_colors.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/portfolio_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    _showDialog(){
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
    PortfolioController portfolioController = PortfolioController.to;
    return Scaffold(
        backgroundColor: AppColors.offWhite,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 100,
          leading: Image.asset('assets/images/app_icon.png', fit: BoxFit.cover),
          titleSpacing: 0,
          title: Text(box.read('userId').toString()),
          actions: [
            TextButton.icon(
                onPressed: () {
                  _showDialog();
                },
                icon: const Icon(Icons.logout),
                label: const Text('Log Out')),
            const SizedBox(
              width: 25,
            )
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
              padding: EdgeInsets.zero,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // Cover Photo
                    Container(
                      height: 150,
                      margin: const EdgeInsets.only(bottom: 80),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images/app_icon.png'),
                          // Replace with your cover photo
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Profile Photo
                    Positioned(
                      top: 90,
                      left: 20,
                      child: InkWell(
                        onTap: () {
                          _bottomsheet(context);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(image: AssetImage('assets/images/profile.jpg')),
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.themeColorTwo,
                              width: 3.0,
                            ),
                            // image: const DecorationImage(
                            //   image: AssetImage('assets/images/app_icon.png'),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                      ),
                    ),

                    // Profile Info (Name, etc.)
                     Positioned(
                      top: 125,
                      left: 140,
                      right: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.artisDetails[0].businessName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                               Text(
                                controller.artisDetails[0].location,
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

                              }, icon: Icon(Icons.edit,size: 20,color: AppColors.themeColorTwo,)),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  children: [
                    MyWidgets.textView(
                        '       Profile Details', AppColors.themeColorTwo, 17),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          onPressed: () {

                      }, icon: Icon(Icons.edit,size: 20,color: AppColors.themeColorTwo,)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                MyWidgets.textView('        ${controller.artisDetails[0].facebookLink}', AppColors.black, 15),
                const SizedBox(
                  height: 5,
                ),
                MyWidgets.textView(
                    '        ${controller.artisDetails[0].facebookLink}', AppColors.black, 15),
                const SizedBox(
                  height: 20,
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
                    itemCount: controller.artisImages.length,
                    itemBuilder: (BuildContext context, int index) {
                        // Generate other items as needed
                        return GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 20,
                              width: 20,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(image: NetworkImage(controller.artisImages[index].photo))),

                            )

                            //Image.network(uploadedImages[index]),
                            );

                    },
                  ),
                ),
              ],
            );
          }
        }));
  }
  _bottomsheet(context){
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
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColorTwo)),
                  child: const Text(' Change Cover Photo ',style: TextStyle(color: Colors.white)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
