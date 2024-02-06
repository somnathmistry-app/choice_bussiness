import 'package:choice_bussiness/pages/dashboard.dart';
import 'package:choice_bussiness/styles/app_colors.dart';
import 'package:choice_bussiness/styles/button_style.dart';
import 'package:choice_bussiness/styles/commonmodule/app_bar.dart';
import 'package:choice_bussiness/styles/commonmodule/my_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/radio_model.dart';
import '../styles/commonmodule/radio_item.dart';
class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  List<RadioModel> currencyModel_in = <RadioModel>[];


  @override
  void initState() {
    super.initState();
    // int id,   bool isSelected,   String planname,   String time,   String price
    currencyModel_in
        .add(new RadioModel(1, false, 'BEGINNER', '7 Days', 'Free'));
    currencyModel_in
        .add(new RadioModel(1, false, 'ADVANCED', '1 month', '1000/-'));
    currencyModel_in
        .add(new RadioModel(1, false, 'PRO', '1 year', '10,000/-'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: appBar('Subscription'),
      body: Column(
        children: [
          SizedBox(height: 20),
          /*Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child:

            Table(
                border: TableBorder.all(), // Allows to add a border decoration around your table
                children: [
                  TableRow(children :[
                    Text(''),
                    Center(child: Text('Beginner', style: TextStyle(fontWeight: FontWeight.bold))),
                    Center(child: Text('Advanced', style: TextStyle(fontWeight: FontWeight.bold))),
                    Center(child: Text('Pro', style: TextStyle(fontWeight: FontWeight.bold))),
                  ]),
                  TableRow(children :[
                    Center(child: Text('Visibility',)),
                    Center(child: Text('Lowest')),
                    Center(child: Text('Medium')),
                    Center(child: Text('High')),
                  ]),
                  TableRow(children :[
                    Center(child: Text('Support')),
                    Center(child: Text('X')),
                    Center(child: Text('✔')),
                    Center(child: Text('✔')),
                  ]),
                  TableRow(children :[
                    Center(child: Text('Profile Visibility')),
                    Center(child: Text('7 Days')),
                    Center(child: Text('1 month')),
                    Center(child: Text('1 Year')),
                  ]),
                  TableRow(children :[
                    Center(child: Text('Contact Details')),
                    Center(child: Text('X')),
                    Center(child: Text('✔')),
                    Center(child: Text('✔')),
                  ]),
                  TableRow(children :[
                    Center(child: Text('Whatsapp Chat')),
                    Center(child: Text('X')),
                    Center(child: Text('X')),
                    Center(child: Text('✔')),
                  ]),
                  TableRow(children :[
                    Center(child: Text('Services Area')),
                    Center(child: Text('X')),
                    Center(child: Text('✔')),
                    Center(child: Text('✔')),
                  ]),
                ]
            ),
          ),*/

          Image.asset('assets/images/sub.png'),
          SizedBox(height: 20),
          Container(
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: currencyModel_in.length,
                itemBuilder: (BuildContext context, int index) {
              return
                InkWell(
                  onTap: (){
                    setState(() {

                        currencyModel_in.forEach(
                                (element) => element
                                .isSelected = false);
                        currencyModel_in[index]
                            .isSelected = true;
                      }
                    );
                  },
                  child: Container(

                      margin:
                      EdgeInsets.symmetric(
                          horizontal: 4),
                      child: RadioItem(currencyModel_in[index])),
                );
            }),
          ),
          SizedBox(height: 40),
          ElevatedButton(
              style: elevatedButtonStyleStripe,
              onPressed: (){
                MySnackbar.successSnackBar('Subscription added', 'Your subscription has been added');
                Get.offAll(Dashboard());
              }, child: Text('Get Subscription', style: TextStyle(color: AppColors.white),))
        ],
      )
    );
  }
}
