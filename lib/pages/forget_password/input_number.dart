import 'package:choice_bussiness/controller/otp_controller.dart';
import 'package:choice_bussiness/styles/button_style.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';


class InputNumber extends StatefulWidget {
  const InputNumber({Key? key}) : super(key: key);

  @override
  State<InputNumber> createState() => _InputNumberState();
}

class _InputNumberState extends State<InputNumber> {
  final _formKey = GlobalKey<FormState>();

  OtpController otpController = OtpController.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeColorTwo,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              scale: 6,
            ),
            //SizedBox(height: 20),
            MyWidgets.textView('Forget Password?', AppColors.themeColorLight, 22),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: MyWidgets.textView('Enter your registered number to change password', AppColors.white, 18),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(keyboardType: TextInputType.number,
                      style: TextStyle(color: AppColors.white, fontSize: 18),
                      controller: OtpController.number,
                      validator: (value) => value!.isEmpty
                          ? 'Please enter mobile number'
                          : value.length < 8
                          ? 'Please enter 10 digit number'
                          : null,
                      maxLength: 10,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                          enabled: true,
                          counterText: '',
                          labelText: 'Enter mobile number',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            // light
                            fontStyle: FontStyle.normal,
                          ),
                          errorStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.w600,
                            // light
                            fontStyle: FontStyle.normal,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.themeColor)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.white)),
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.orangeAccent))
                      )),

                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: elevatedButtonStyleWhiteCurve,
                      onPressed: (){
                        if (_formKey.currentState!.validate()) {
                          otpController.sendOtp();
                        }
                      }, child: Padding(
                      padding: const EdgeInsets.all(14.0),
                       child: MyWidgets.textView('Send Otp', AppColors.themeColorTwo, 15),
                  )),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
