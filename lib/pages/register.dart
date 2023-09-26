import 'package:choice_bussiness/logincontroller.dart';
import 'package:choice_bussiness/styles/button_style.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeColorTwo,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              scale: 6,
              color: AppColors.themeColor,
            ),
            //SizedBox(height: 20),
            MyWidgets.textView('Welcome Back to Choice 99', AppColors.themeColorLight, 22),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [

                  const SizedBox(height: 20),
                  //Password TextField
                  TextFormField(keyboardType: TextInputType.number,
                      style: TextStyle(color: AppColors.themeColorTwo, fontSize: 18),
                      controller: LoginController.passwordTec,
                      validator: (value) => value!.isEmpty
                          ? 'Please enter mobile number'
                          : value.length < 8
                          ? 'Please enter 10 digit number'
                          : null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                          enabled: true,
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
                  TextFormField(keyboardType: TextInputType.number,
                      style: TextStyle(color: AppColors.themeColorTwo, fontSize: 18),
                      controller: LoginController.passwordTec,
                      validator: (value) => value!.isEmpty
                          ? 'Please enter password':null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                          enabled: true,
                          labelText: 'Enter password',
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

                      }, child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: MyWidgets.textView('Continue', AppColors.themeColorTwo, 15),
                  )),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            InkWell(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: MyWidgets.textView('Not a vendor yet? Singup', AppColors.white, 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
