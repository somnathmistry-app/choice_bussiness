import 'package:choice_bussiness/controller/services_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/app_colors.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  ServiceListController serviceListController = ServiceListController.to;
  // _callNumber(String number) async {
  //   bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  // }
  // void sending_SMS(String msg, List<String> list_receipents) async {
  //   String send_result = await sendSMS(message: msg, recipients: list_receipents)
  //       .catchError((err) {
  //     print(err);
  //   });
  //   print(send_result);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 100,

        leading: Image.asset('assets/images/app_icon.png',fit: BoxFit.cover),
        titleSpacing: 0,
        title: const  Text('Our Services'),),
      body: GetX<ServiceListController>(initState: (context) {
        serviceListController.getServices();
      }, builder: (controller) {
        if (controller.isLoading.value) {
          return Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.themeColor,
                  )));
        } else {
          return  ListView.builder(
            padding: const EdgeInsets.only(bottom: 30),
            itemCount: serviceListController.bookingList.length,
            //shrinkWrap: true,
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
                        //image: DecorationImage(image: NetworkImage(controller.bookingList[index].)),
                        color: Colors.grey[200],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('     ${controller.serviceList[index].place}'),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         Center(
                    //           child: IconButton(onPressed: () {
                    //             _callNumber(controller.bookingList[index].userphone.toString());
                    //           }, icon: Icon(Icons.call,)),
                    //         ),
                    //         Center(
                    //           child: IconButton(onPressed: () {
                    //
                    //           }, icon: Icon(Icons.message,)),
                    //         ),
                    //         Center(
                    //           child: IconButton(onPressed: () {
                    //
                    //           }, icon: Icon(Icons.book_outlined,)),
                    //         ),
                    //         SizedBox(width: 8)
                    //       ],
                    //     )
                    //   ],
                    // ),
                    SizedBox(height: 5),
                    Text('    ${controller.serviceList[index].serviceName}',style:TextStyle(fontSize: 17)),
                    SizedBox(height: 2),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('     ${controller.bookingList[index].username}'),
                        Text('     ₹ ${controller.serviceList[index].price}     ',style:TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),

                  ],),
              );
            },);
        }
      }));
  }
}
