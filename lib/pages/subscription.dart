import 'package:choice_bussiness/pages/dashboard.dart';
import 'package:choice_bussiness/styles/app_colors.dart';
import 'package:choice_bussiness/styles/button_style.dart';
import 'package:choice_bussiness/styles/commonmodule/app_bar.dart';
import 'package:choice_bussiness/styles/commonmodule/my_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../models/radio_model.dart';
import '../onlinepayment/rozer_pay.dart';
import '../styles/commonmodule/radio_item.dart';
class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  List<RadioModel> currencyModel_in = <RadioModel>[];
int? selectedIndex=0;
  int payableAmount=3000;
  @override
  void initState() {
    super.initState();
    // int id,   bool isSelected,   String planname,   String time,   String price
    currencyModel_in
        .add(new RadioModel(1, false, 'BEGINNER', '7 Days', 'Free'));
    currencyModel_in
        .add(new RadioModel(1, false, 'ADVANCED', '3 Month', '3000/-'));
    currencyModel_in
        .add(new RadioModel(1, false, 'PRO', '1 Year', '10,000/-'));
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
                      selectedIndex= index;
                      payableAmount = selectedIndex==1?3000:10000;
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
        currencyModel_in[0]
            .isSelected?SizedBox():ElevatedButton(
              style: elevatedButtonStyleStripe,
              onPressed: (){

                print('selectedIndex: $selectedIndex, payableAmount: $payableAmount');

               // MySnackbar.successSnackBar('Subscription added', 'Your subscription has been added');
                //Get.offAll(RozerPayScreen(title:'Subscription', mobile: '9547607753', email: 'sam@gmail.com',description: 'Subscription des',amount: 100.00));
                //Get.offAll(RozerPayScreen(title:'Subscription'));
makePayment(payableAmount, 'Subscription of Rs. $payableAmount',box.read('userNumber').toString(),'somnath222666@gmail.com' );

              }, child: Text('Get Subscription', style: TextStyle(color: AppColors.white),))
        ],
      )
    );
  }

  void makePayment(payableAmount, description, mobile, email) {
    print('payment data: $payableAmount, $description, $mobile, $email');
    Razorpay razorpay = Razorpay();
    var options = {

      //'key':'uVmVtthlb7jlrq9OW7DqjmAK',
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount':payableAmount * 100,
      'name': 'Choice 99',
      'description': description,
      'retry': {'enabled': true, 'max_count': 3},
      'send_sms_hash': true,
      'prefill': {'contact': mobile, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response){
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }
  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text('Please try again'),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
