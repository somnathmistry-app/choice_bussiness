import 'package:choice_bussiness/controller/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:timer_button/timer_button.dart';

import '../../styles/app_colors.dart';
import '../../styles/commonmodule/my_widgets.dart';





class EnterOTPPage extends StatelessWidget {
  final String number;
  const EnterOTPPage({Key? key,required this.number}): super(key: key);

  @override
  Widget build(BuildContext context) {
    OtpController otpController = OtpController.to;
    return Scaffold(
      backgroundColor: AppColors.themeColorTwo,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            Center(child: MyWidgets.textView('Verify OTP', AppColors.themeColorLight, 22)),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: MyWidgets.textView('Please Enter the OTP Sent To $number', AppColors.white, 16),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            OTPTextField(
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 50,
              style: const TextStyle(
                  fontSize: 17
              ),
              textFieldAlignment: MainAxisAlignment.center,
              margin:  const EdgeInsets.all(8),
              otpFieldStyle: OtpFieldStyle(borderColor: Colors.white,backgroundColor: Colors.white54),
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                //  debugPrint("Completed: $pin");
                 otpController.verify(pin);
               // phoneTEC.text = pin;
              },
              onChanged: (value) {

              },
            ),
            // Text(' Phone Number',style: AppStyles().OutlinetextStyle(),),
            // MyWidgets.textFormFields(phoneTEC, TextInputType.number,
            //     false.obs,false, 'Email',maxLength: 10),
            SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: TimerButton(
                label: 'Resend',
                timeOutInSeconds: 60,
                onPressed: () {
                  print('resend');
                  otpController.sendOtp();
                },
                buttonType: ButtonType.outlinedButton,
                disabledColor: Colors.white,
                color: AppColors.themeColor,
                activeTextStyle: TextStyle(color: AppColors.themeColor),
                disabledTextStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            // Center(
            //   child: TextButton(onPressed: () {
            //     forgotPasswordController.reSendOTP(number);
            //   }, child: Text('Resend',style: TextStyle(fontSize: 17,color: AppColors.themeColor),)),
            // )

          ],
        ),
      ),
    );
  }
}
