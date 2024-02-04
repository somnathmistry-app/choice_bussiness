import 'package:choice_bussiness/controller/otp_controller.dart';
import 'package:choice_bussiness/styles/button_style.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';


class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
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
            Center(child: MyWidgets.textView('New Password', AppColors.themeColorLight, 22)),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: MyWidgets.textView('Enter a new password to continue', AppColors.white, 18),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                      style: TextStyle(color: AppColors.white, fontSize: 18),
                      controller: OtpController.new_password,
                      validator: (value) => value!.isEmpty
                          ? 'Please enter password':null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                          enabled: true,
                          labelText: 'Enter New Password',
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
                          otpController.changePassword();
                        }
                      }, child: Padding(
                      padding: const EdgeInsets.all(14.0),
                       child: MyWidgets.textView('Continue', AppColors.themeColorTwo, 15),
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
