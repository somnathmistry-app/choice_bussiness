import 'package:choice_bussiness/controller/add_service_controller.dart';
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
  AddServiceController addServiceController = AddServiceController.to;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeColorTwo,
      body:


      GetX<AddServiceController>(initState: (context) {
        addServiceController.getSubCategory();
        addServiceController.getLocationList();
      }, builder: (controller) {
        if (controller.isLoading.value || controller.isLoading2.value) {
          return Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
            color: AppColors.themeColor,
          )));
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              padding: EdgeInsets.zero,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 180,
                  child: Image.asset(
                    'assets/images/logo.png',
                    scale: 1,
                    color: AppColors.themeColor,
                  ),
                ),
                //SizedBox(height: 20),
                MyWidgets.textView(
                    'Welcome to Choice 99\nRegister as an merchant',
                    AppColors.themeColorLight,
                    20),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                          controller: UserController.businessTec,
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your business name'
                              : null,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 14),
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
                                  borderSide:
                                      BorderSide(color: AppColors.themeColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.white)),
                              errorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.orangeAccent)))),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.white,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: DropdownButton(
                          underline: const SizedBox(),
                          dropdownColor: AppColors.themeColorTwo,
                          style: const TextStyle(color: Colors.white),
                          hint: MyWidgets.textView(
                              'Please select your location', Colors.white, 16),
                          // Not necessary for Option 1
                          value: controller.selectedLocation,
                          onChanged: (newValue) {
                            setState(() {
                              controller.selectedLocation =
                                  newValue.toString();
                            });
                          },
                          items: controller.locationData.map((element) {
                            return DropdownMenuItem(
                              value: element.name,
                              child: MyWidgets.textView(
                                  element.name, Colors.white, 16),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.white,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: DropdownButton(
                          underline: const SizedBox(),
                          dropdownColor: AppColors.themeColorTwo,
                          style: const TextStyle(color: Colors.white),
                          hint: MyWidgets.textView(
                              'Please select business category',
                              Colors.white,
                              16),
                          // Not necessary for Option 1
                          value: userController.selectedCatID,
                          onChanged: (newValue) {
                            print(newValue);
                            setState(() {
                              userController.selectedCatID =
                                  newValue.toString();
                            });
                          },

                          items: controller.allCatList.map((cat) {
                            return DropdownMenuItem(
                              value: cat.id,
                              child: MyWidgets.textView(cat.title, Colors.white, 16),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      //Password TextField
                      TextFormField(
                          keyboardType: TextInputType.number,
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                          controller: UserController.mobileTec,
                          validator: (value) => value!.isEmpty
                              ? 'Please enter mobile number'
                              : value.length < 8
                                  ? 'Please enter 10 digit number'
                                  : null,
                          maxLength: 10,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 14),
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
                                  borderSide:
                                      BorderSide(color: AppColors.themeColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.white)),
                              errorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.orangeAccent)))),
                      const SizedBox(height: 20),
                      TextFormField(
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                          controller: UserController.passTec,
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter password' : null,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 14),
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
                                  borderSide:
                                      BorderSide(color: AppColors.themeColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.white)),
                              errorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.orangeAccent)))),
                      const SizedBox(height: 20),
                      TextFormField(
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                          controller: UserController.descriptionTec,
                          validator: (value) => value!.isEmpty
                              ? 'Please enter description'
                              : null,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 14),
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
                                  borderSide:
                                      BorderSide(color: AppColors.themeColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.white)),
                              errorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.orangeAccent)))),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          style: elevatedButtonStyleWhiteCurve,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              userController.registerUser(controller.selectedLocation.toString());
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: MyWidgets.textView(
                                'Continue', AppColors.themeColorTwo, 15),
                          )),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(const LoginView());
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: MyWidgets.textView(
                          'Already a vendor? Login', AppColors.white, 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        }
      }),
    );
  }
}


