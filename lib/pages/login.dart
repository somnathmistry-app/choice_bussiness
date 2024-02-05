import 'package:choice_bussiness/controller/user.dart';
import 'package:choice_bussiness/pages/register.dart';
import 'package:choice_bussiness/styles/button_style.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/app_colors.dart';
import 'forget_password/input_number.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  UserController userController = UserController();

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
            MyWidgets.textView('Welcome Back to Choice 99', AppColors.themeColorLight, 22),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  //Password TextField
                  TextFormField(keyboardType: TextInputType.number,
                      style: TextStyle(color: AppColors.white, fontSize: 18),
                      controller: UserController.mobileTec_login,
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
                  TextFormField(
                      style: TextStyle(color: AppColors.white, fontSize: 18),
                      controller: UserController.passTec_login,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     TextButton(onPressed: () {
                       Get.to(()=>  InputNumber());
                     }, child: Text('Forget Password?',style: TextStyle(
                       fontSize: 16,
                       color: AppColors.white,
                       fontWeight: FontWeight.w600,
                       // light
                       fontStyle: FontStyle.normal,
                     ),))
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: elevatedButtonStyleWhiteCurve,
                      onPressed: (){
                        if (_formKey.currentState!.validate()) {
                          userController.loginUser();
                        }
                  }, child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: MyWidgets.textView('Continue', AppColors.themeColorTwo, 15),
                  )),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Get.to(const RegisterView());
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: MyWidgets.textView('Not a vendor yet? SingUp', AppColors.white, 16),
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
