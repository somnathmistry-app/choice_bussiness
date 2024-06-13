import 'package:choice_bussiness/controller/delete_controller.dart';
import 'package:choice_bussiness/controller/services_controller.dart';
import 'package:choice_bussiness/pages/dashboard.dart';
import 'package:choice_bussiness/pages/portfolio_page.dart';
import 'package:choice_bussiness/pages/service_view_more.dart';
import 'package:choice_bussiness/pages/splash_view.dart';
import 'package:choice_bussiness/styles/button_style.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../styles/app_colors.dart';
import 'image_full_view.dart';
import 'notification_page.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  ServiceListController serviceListController = ServiceListController.to;
  DeleteController deleteController = DeleteController.to;

  _serviceDel(context,serviceId){
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Service?'),
        content: const Text('Are your sure your want to delete this service?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
              serviceListController.serviceDeleting(serviceId);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    var box = GetStorage();
    print('get service:- ${box.read('userId')+", "+box.read('location')}');
    return Scaffold(
        backgroundColor: AppColors.offWhite,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 100,

          leading: Image.asset('assets/images/app_icon.png',fit: BoxFit.cover),
          titleSpacing: 0,

          actions: [
            Stack(
              children: <Widget>[
                new IconButton(icon: Icon(Icons.notifications), onPressed: () {
                  setState(() {
                    counter = 0;
                  });
                  Get.to(()=>NotificationPage());

                }),
                counter != 0 ? new Positioned(
                  left: 5,
                  top: 10,
                  child: new Container(
                    padding: EdgeInsets.all(2),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      '$counter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ) : new Container()
              ],
            ),
          ],
        ),
        body: GetX<ServiceListController>(initState: (context) {
          serviceListController.getServices();
          serviceListController.getPortfolioDetails();
        }, builder: (controller) {
          //if (controller.isLoading.value || controller.isLoading1.value) {
            return Container(
              margin: EdgeInsets.all(5),
              child: RefreshIndicator(
                onRefresh: _pullRefresh,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    serviceListController.portfolioLoading.value?
                    Container(
                        height: 5,
                        width: 50,
                        child: LinearProgressIndicator()):
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Adjust the number of columns
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:  controller.artisImages.length>9?9:controller.artisImages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              _dialogBuilder(context,controller.artisImages[index].photo);
                            },
                            child: Container(
                              height: 20,width: 20,
                              margin:const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(image: NetworkImage(controller.artisImages[index].photo), fit: BoxFit.cover)),

                            )

                          //Image.network(uploadedImages[index]),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: elevatedButtonStyleThemeColor,
                            onPressed: (){
                              Get.to(()=> const PortfolioPage());
                            }, child: MyWidgets.textView('Manage your portfolio', AppColors.white, 12)),
                        // ElevatedButton(
                        //     style: elevatedButtonStyleStripe,
                        //     onPressed: (){
                        //       Get.to(()=> const PortfolioPage());
                        //     }, child: MyWidgets.textView('View all Images', AppColors.white, 12)),
                      ],
                    ),
                    serviceListController.serviceList.isEmpty?
                    SizedBox():
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () {
                          Get.to(()=> ServiceViewMore(serviceListController: serviceListController));
                        }, child: const Text('View more')),
                        const SizedBox(width: 20)
                      ],
                    ),
                    serviceListController.serviceList.length <= 4?
                    serviceListController.serviceLoading.value?
                    SizedBox(
                        height: 5,
                        width: 10,
                        child: const LinearProgressIndicator()):
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Adjust the number of columns
                        crossAxisSpacing: 5,
                        childAspectRatio:  0.54
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:  serviceListController.serviceList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3,
                                offset: Offset(
                                  0,
                                  3,
                                ),
                              )
                            ],
                            color: AppColors.themeColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height/3.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                  image:controller.imageService[index] == ''?
                                  null:
                                  DecorationImage(
                                      image: NetworkImage(
                                          controller.imageService[index].toString(),
                                      ), fit: BoxFit.cover),),
                                child:
                                Stack(
                                  children: [
                                    Positioned(
                                      right: 0,
                                      child: IconButton(
                                          color:Colors.black,
                                          onPressed: () {
                                            _serviceDel(context,controller.serviceList[index].serviceId);
                                          }, icon: const Icon(Icons.cancel_outlined)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  SizedBox(width: 5),
                                  Icon(Icons.location_on_outlined, size: 15,),
                                  Text('${controller.serviceList[index].place}'),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                child: Text('${controller.serviceList[index].subcategoryName}',
                                    maxLines :1,
                                    overflow: TextOverflow.ellipsis,
                                    style:const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 6.0),
                              //   child: Text('${controller.serviceList[index].about}',
                              //       maxLines :2,
                              //       overflow: TextOverflow.ellipsis,
                              //       style:const TextStyle(fontSize: 13,)),
                              // ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                child: Text('${controller.serviceList[index].description}',
                                    maxLines :2,
                                    overflow: TextOverflow.ellipsis,
                                    style:const TextStyle(fontSize: 12,color: Colors.black45)),
                              ),
                              Text('  ₹ ${controller.serviceList[index].price}',style:const TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        );
                      },
                    )
                        :
                    serviceListController.serviceLoading.value?
                    LinearProgressIndicator():
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Adjust the number of columns
                        crossAxisSpacing: 5,
                        childAspectRatio:  0.54
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:  4,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3,
                                offset: Offset(
                                  0,
                                  3,
                                ),
                              )
                            ],
                            color: AppColors.themeColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height/3.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                  image:controller.imageService[index] == ''?
                                  null:
                                  DecorationImage(
                                      image: NetworkImage(
                                          controller.imageService[index].toString()
                                      )),),
                                child:
                                Stack(
                                  children: [
                                    Positioned(
                                      right: 0,
                                      child: IconButton(
                                          color:Colors.black,
                                          onPressed: () {
                                            _serviceDel(context,controller.serviceList[index].serviceId);
                                          }, icon: const Icon(Icons.cancel_outlined)),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 5),
                                  Icon(Icons.location_on_outlined, size: 15,),
                                  Text('${controller.serviceList[index].place}'),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                child: Text('${controller.serviceList[index].serviceName}',
                                    maxLines :1,
                                    overflow: TextOverflow.ellipsis,
                                    style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                child: Text('${controller.serviceList[index].about}',
                                    maxLines :2,
                                    overflow: TextOverflow.ellipsis,
                                    style:const TextStyle(fontSize: 11)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                child: Text('${controller.serviceList[index].description}',
                                    maxLines :1,
                                    overflow: TextOverflow.ellipsis,
                                    style:const TextStyle(fontSize: 11,color: Colors.black45)),
                              ),
                              Text('  ₹ ${controller.serviceList[index].price}',style:const TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 50,)
                  ],
                ),
              ),
            );
        }));
  }

  Future<void> _pullRefresh() async {
    serviceListController.getServices();
    serviceListController.getPortfolioDetails();
  }
}
/*
   serviceListController.serviceList.length <= 3?
                  serviceListController.serviceLoading.value?
                  SizedBox(
                      height: 5,
                      width: 10,
                      child: const LinearProgressIndicator()):
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 30),
                    itemCount: serviceListController.serviceList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              offset: Offset(
                                0,
                                3,
                              ),
                            )
                          ],
                          color: AppColors.themeColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height/4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: controller.imageService[index] == ''?
                                    null:
                                    DecorationImage(
                                        image: NetworkImage(controller.imageService[index].toString()), fit: BoxFit.cover
                                    ),
                                    //image: DecorationImage(image: NetworkImage(controller.bookingList[index].)),
                                    color: Colors.grey[200],
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                      color:Colors.white54,
                                      onPressed: () {
                                    _serviceDel(context,controller.serviceList[index].serviceId);
                                  }, icon: const Icon(Icons.cancel_outlined)),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                  SizedBox(width: 5),
                                Icon(Icons.location_on_outlined, size: 15,),
                                Text('${controller.serviceList[index].place}'),

                              ],
                            ),
                            const SizedBox(height: 2),
                            Text('   ${controller.serviceList[index].serviceName}',style:const TextStyle(fontSize: 17)),
                            const SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex:4,
                                    child: Text('    ${controller.serviceList[index].description}', maxLines: 2,)),
                                Expanded(
                                  flex:1,
                                  child: Text('     ₹ ${controller.serviceList[index].price}     ',style:const TextStyle(fontWeight: FontWeight.bold)),)
                              ],
                            ),
                            const SizedBox(height: 10),

                          ],),
                      );
                    },)
                      :
                  serviceListController.serviceLoading.value?
                  CircularProgressIndicator():
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 30),
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              offset: Offset(
                                0,
                                3,
                              ),
                            )
                          ],
                          color: AppColors.themeColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: controller.imageService[index] == ''?
                                null:
                                DecorationImage(
                                    image: NetworkImage(controller.imageService[index].toString())
                                ),
                                //image: DecorationImage(image: NetworkImage(controller.bookingList[index].)),
                                //image: DecorationImage(image: NetworkImage(controller.bookingList[index].)),
                                color: Colors.grey[200],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text('     ${controller.serviceList[index].place}'),
                            const SizedBox(height: 5),
                            Text('    ${controller.serviceList[index].serviceName}',style:const TextStyle(fontSize: 17)),
                            const SizedBox(height: 2),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('     ${controller.serviceList[index].serviceName}'),
                                Text('     ₹ ${controller.serviceList[index].price}     ',style:const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 10),

                          ],),
                      );
                    },),
 */
