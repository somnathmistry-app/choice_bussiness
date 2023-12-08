import 'package:choice_bussiness/api/api_end_path.dart';
import 'package:choice_bussiness/controller/lead_controller.dart';
import 'package:choice_bussiness/pages/dashboard.dart';
import 'package:choice_bussiness/styles/commonmodule/app_bar.dart';
import 'package:choice_bussiness/styles/commonmodule/my_snack_bar.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../styles/app_colors.dart';
import 'image_view.dart';

class LeadsPage extends StatefulWidget {

  @override
  State<LeadsPage> createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
  LeadController leadController = Get.put(LeadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text('Leads'),
        // leading: InkWell(
        //     onTap: (){
        //       Get.to(Dashboard());
        //     },
         //   child: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
        backgroundColor: AppColors.offWhite,
        body: GetX<LeadController>(initState: (context) {
          leadController.getLead();
        }, builder: (controller) {
          return
            controller.leadLoading.value?Center(child: CircularProgressIndicator()):Container(
            margin: EdgeInsets.all(5),
            child: ListView.builder(
              //physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 30),
              itemCount: controller.leadList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        offset: Offset(
                          0,
                          1,
                        ),
                      )
                    ],
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              controller.leadList[index].photo==null?SizedBox():InkWell(
                                onTap:(){
                                  Get.to(ImageView('${ApiEndPath.imageURL}${controller.leadList[index].photo.toString()}'));

                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image:controller.leadList[index].photo == 'null'? null :DecorationImage(
                                        image: NetworkImage(
                                            '${ApiEndPath.imageURL}${controller.leadList[index].photo.toString()}'
                                        ),fit: BoxFit.cover
                                    ),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: AppColors.themeColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              MyWidgets.textView(controller.leadList[index].name!.toString(), AppColors.black, 14),
                            ],
                          ),
                          controller.leadList[index].location==null?SizedBox():MyWidgets.textView('From - '+controller.leadList[index].location.toString(), AppColors.black, 14),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyWidgets.textView('Contact - '+controller.leadList[index].phone!.toString()+'\nTried to connect via - ${controller.leadList[index].leadType!.toString()}', AppColors.black, 14),
                          InkWell(
                            onTap:(){
                              dialNumber(phoneNumber:controller.leadList[index].phone!.toString(), context: context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/call.png', scale: 14),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              offset: Offset(
                                0,
                                1,
                              ),
                            )
                          ],
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyWidgets.textView('Service Inquired', AppColors.black, 12),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    controller.leadList[index].photo==null?SizedBox():InkWell(
                                      onTap:(){
                                        Get.to(ImageView('${ApiEndPath.imageURL}${controller.leadList[index].photo.toString()}'));
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          //shape: BoxShape.circle,
                                          image:controller.leadList[index].photo == 'null'? null :DecorationImage(
                                              image: NetworkImage(
                                                  '${ApiEndPath.imageURL}${controller.leadList[index].photo.toString()}'
                                              ),fit: BoxFit.cover
                                          ),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: AppColors.themeColor,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    MyWidgets.textView(controller.leadList[index].serviceName!.toString(), AppColors.black, 13),
                                  ],
                                ),
                                controller.leadList[index].location==null?SizedBox():MyWidgets.textView('From - '+controller.leadList[index].location.toString(), AppColors.black, 13),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Rs. '+controller.leadList[index].price!.toString()),
                                Text(controller.leadList[index].place!.toString()),
                              ],
                            ),
                            MyWidgets.textView(controller.leadList[index].createdAt!.toString(), AppColors.black, 12),

                          ],
                        )
                      )
                    ],
                  )
                );
              }),
          );
        }));
  }
  Future<void> dialNumber(
      {required String phoneNumber, required BuildContext context}) async {
    final url = "tel:$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      MySnackbar.infoSnackBar('Unable to call this number', 'Please try again with manual dial');
    }
    return;
  }
}
