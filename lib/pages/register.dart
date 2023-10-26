import 'package:choice_bussiness/controller/user.dart';
import 'package:choice_bussiness/pages/login.dart';
import 'package:choice_bussiness/styles/button_style.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../styles/app_colors.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
            SizedBox(
              height: 200,
              child: Image.asset(
                'assets/images/logo.png',
                scale: 1,
                color: AppColors.themeColor,
              ),
            ),
            //SizedBox(height: 20),
            MyWidgets.textView('Welcome to Choice 99\nRegister as an merchant', AppColors.themeColorLight, 20),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [

                  TextFormField(
                      style: TextStyle(color: AppColors.white, fontSize: 18),
                      controller: UserController.businessTec,
                      validator: (value) => value!.isEmpty
                          ? 'Please enter your business name'
                          : null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                          enabled: true,
                          labelText: 'Please enter your business name',
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.white,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      style: const TextStyle(color: Colors.white),
                      hint: MyWidgets.textView('Please select your location', Colors.white, 16), // Not necessary for Option 1
                      value: userController.selectedLocation,
                      onChanged: (newValue) {
                        setState(() {
                          userController.selectedLocation = newValue.toString();
                        });
                      },
                      items: userController.locations.map((location) {
                        return DropdownMenuItem(
                          child: MyWidgets.textView(location, Colors.black, 16),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Password TextField
                  TextFormField(keyboardType: TextInputType.number,
                      style: TextStyle(color: AppColors.white, fontSize: 18),
                      controller: UserController.mobileTec,
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
                  TextFormField(
                      style: TextStyle(color: AppColors.white, fontSize: 18),
                      controller: UserController.passTec,
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
                  TextFormField(
                      style: TextStyle(color: AppColors.white, fontSize: 18),
                      controller: UserController.descriptionTec,
                      validator: (value) => value!.isEmpty
                          ? 'Please enter description'
                          : null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                          enabled: true,
                          labelText: 'Please enter description',
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
                         userController.registerUser();
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
                Get.to(const LoginView());
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: MyWidgets.textView('Already a vendor? Login', AppColors.white, 16),
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


