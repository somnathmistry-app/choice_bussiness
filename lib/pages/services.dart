import 'package:choice_bussiness/controller/delete_controller.dart';
import 'package:choice_bussiness/controller/services_controller.dart';
import 'package:choice_bussiness/pages/portfolio_page.dart';
import 'package:choice_bussiness/pages/service_photo_viewmore.dart';
import 'package:choice_bussiness/pages/service_view_more.dart';
import 'package:choice_bussiness/styles/button_style.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:get/get.dart';

import '../styles/app_colors.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  ServiceListController serviceListController = ServiceListController.to;
  DeleteController deleteController = DeleteController.to;

  final DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

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
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static final Widget _eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: const Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  final EventList<Event> _markedDateMap = EventList<Event>(
    events: {
      DateTime(2023, 11, 8): [
        Event(
          date: DateTime(2023, 11, 8),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        Event(
          date: DateTime(2023, 10, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        Event(
          date: DateTime(2023, 10, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  @override
  void initState() {
    _markedDateMap.add(
        DateTime(2023, 11, 25),
        Event(
          date: DateTime(2023, 11, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        DateTime(2023, 11, 11),
        Event(
          date: DateTime(2023, 11, 11),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(DateTime(2023, 11, 11), [
      Event(
        date: DateTime(2023, 11, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      Event(
        date: DateTime(2023, 11, 10),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      Event(
        date: DateTime(2023, 11, 10),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.white,
      onDayPressed: (date, events) {
        setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      childAspectRatio: 1.3,
      dayPadding: 0,

      //daysHaveCircularBorder: false,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: const TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 260.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      // markedDateCustomShapeBorder:
      // const CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: const TextStyle(
        color: Colors.white,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: AppColors.themeColorTwo,
      selectedDayTextStyle: const TextStyle(
        color: Colors.white,
      ),
      minSelectedDate: _currentDate.subtract(const Duration(days: 360)),
      maxSelectedDate: _currentDate.add(const Duration(days: 360)),
      prevDaysTextStyle: const TextStyle(
        fontSize: 15,
        color: Colors.grey,
      ),
      inactiveDaysTextStyle: const TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );
    return Scaffold(
        backgroundColor: AppColors.offWhite,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 100,

          leading: Image.asset('assets/images/app_icon.png',fit: BoxFit.cover),
          titleSpacing: 0,

          actions: [
            IconButton(onPressed: () {
              Get.to(()=> const PortfolioPage());

            }, icon: const Icon(Icons.person_pin,size: 30,)),

            const SizedBox(width: 15,)
          ],
        ),
        body: GetX<ServiceListController>(initState: (context) {
          serviceListController.getServices();
          serviceListController.getPortfolioDetails();
        }, builder: (controller) {
          //if (controller.isLoading.value || controller.isLoading1.value) {
            return Container(
              margin: EdgeInsets.all(5),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  /*Container(
                    margin: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      left: 26.0,
                      right: 16.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                              _currentMonth,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            )),
                        TextButton(
                          child: Text('PREV',style: TextStyle(color: AppColors.themeColorTwo)),
                          onPressed: () {
                            setState(() {
                              _targetDateTime = DateTime(
                                  _targetDateTime.year, _targetDateTime.month - 1);
                              _currentMonth =
                                  DateFormat.yMMM().format(_targetDateTime);
                            });
                          },
                        ),
                        TextButton(
                          child: Text('NEXT',style: TextStyle(color: AppColors.themeColorTwo)),
                          onPressed: () {
                            setState(() {
                              _targetDateTime = DateTime(
                                  _targetDateTime.year, _targetDateTime.month + 1);
                              _currentMonth =
                                  DateFormat.yMMM().format(_targetDateTime);
                            });
                          },
                        )
                      ],
                    ),
                  ),*/
                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: calendarCarouselNoHeader,
                  // ),
                  // controller.artisImages.length > 5?
                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.all(8),
                  //   margin: const EdgeInsets.symmetric(horizontal: 10),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey[200],
                  //     boxShadow: const [
                  //       BoxShadow(
                  //         color: Colors.grey,
                  //         blurRadius: 2,
                  //         offset: Offset(
                  //           0,
                  //           2,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  //
                  // ):
                  serviceListController.portfolioLoading.value?Container(
                      height: 5,
                      width: 50,
                      child: LinearProgressIndicator()):GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Adjust the number of columns
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:  controller.artisImages.length>9?9:controller.artisImages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
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
                      ElevatedButton(
                          style: elevatedButtonStyleStripe,
                          onPressed: (){
                            Get.to(()=> const PortfolioPage());
                          }, child: MyWidgets.textView('View all Images', AppColors.white, 12)),
                    ],
                  ),
                  serviceListController.serviceList.isEmpty?SizedBox():Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () {
                        Get.to(()=> ServiceViewMore(serviceListController: serviceListController));
                      }, child: const Text('View more')),
                      const SizedBox(width: 20,)
                    ],
                  ),
                  serviceListController.serviceList.length <= 3?
                  serviceListController.serviceLoading.value?SizedBox(
                      height: 5,
                      width: 10,
                      child: const LinearProgressIndicator()):ListView.builder(
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
                      :  serviceListController.serviceLoading.value?CircularProgressIndicator():ListView.builder(
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
                    },)
                  ,
                ],
              ),
            );
        }));
  }
}
