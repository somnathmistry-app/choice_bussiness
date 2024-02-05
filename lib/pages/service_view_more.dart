import 'package:flutter/material.dart';

import '../styles/app_colors.dart';



class ServiceViewMore extends StatelessWidget {
  final  serviceListController;
  const ServiceViewMore({Key? key, required this.serviceListController}) : super(key : key) ;

  @override
  Widget build(BuildContext context) {
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
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,),
       body:
       GridView.builder(
         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 2, // Adjust the number of columns
            // crossAxisSpacing: 5,
             childAspectRatio:  0.54
         ),
         shrinkWrap: true,
         //physics: const NeverScrollableScrollPhysics(),
         itemCount:  serviceListController.serviceList.length,
         itemBuilder: (BuildContext context, int index) {
           return Container(
             margin: EdgeInsets.only(top: 4,left: 4,right: 4),
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
                   height: 230,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(4),
                     color: Colors.white,
                     image:serviceListController.imageService[index] == ''?
                     null:
                     DecorationImage(
                         image: NetworkImage(
                             serviceListController.imageService[index].toString()
                         )),),
                   child:
                   Stack(
                     children: [
                       Positioned(
                         right: 0,
                         child: IconButton(
                             color:Colors.black,
                             onPressed: () {
                               _serviceDel(context,serviceListController.serviceList[index].serviceId);
                             }, icon: const Icon(Icons.cancel_outlined)),
                       ),
                     ],
                   ),
                 ),
                 Row(
                   children: [
                     SizedBox(width: 5),
                     Icon(Icons.location_on_outlined, size: 15,),
                     Text('${serviceListController.serviceList[index].place}'),
                   ],
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 6.0),
                   child: Text('${serviceListController.serviceList[index].subcategoryName}',
                       maxLines :1,
                       overflow: TextOverflow.ellipsis,
                       style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 6.0),
                   child: Text('${serviceListController.serviceList[index].about}',
                       maxLines :2,
                       overflow: TextOverflow.ellipsis,
                       style:const TextStyle(fontSize: 13,)),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 6.0),
                   child: Text('${serviceListController.serviceList[index].description}',
                       maxLines :2,
                       overflow: TextOverflow.ellipsis,
                       style:const TextStyle(fontSize: 12,color: Colors.black45)),
                 ),
                 Text('  ₹ ${serviceListController.serviceList[index].price}',style:const TextStyle(fontWeight: FontWeight.bold))
               ],
             ),
           );
         },
       )
    );
  }
}
