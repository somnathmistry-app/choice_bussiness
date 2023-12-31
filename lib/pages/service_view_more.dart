import 'package:flutter/material.dart';

import '../styles/app_colors.dart';



class ServiceViewMore extends StatelessWidget {
  var  serviceListController;
  ServiceViewMore({Key? key, required this.serviceListController}) : super(key : key) ;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,),
       body: ListView.builder(
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
                 Container(
                   width: double.infinity,
                   height: 180,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8),
                     image: serviceListController.imageService[index] == ''?
                     null:
                     DecorationImage(
                         image: NetworkImage(serviceListController.imageService[index].toString())
                     ),
                     //image: DecorationImage(image: NetworkImage(controller.bookingList[index].)),
                     color: Colors.grey[200],
                   ),
                 ),
                 const SizedBox(height: 5),
                 Text('     ${serviceListController.serviceList[index].place}'),
                 const SizedBox(height: 5),
                 Text('    ${serviceListController.serviceList[index].serviceName}',style:const TextStyle(fontSize: 17)),
                 const SizedBox(height: 2),

                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('     ${serviceListController.serviceList[index].serviceName}'),
                     Text('     ₹ ${serviceListController.serviceList[index].price}     ',style:const TextStyle(fontWeight: FontWeight.bold)),
                   ],
                 ),
                 const SizedBox(height: 10),

               ],),
           );
         },),
    );
  }
}
