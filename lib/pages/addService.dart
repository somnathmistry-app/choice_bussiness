import 'package:choice_bussiness/controller/add_service_controller.dart';
import 'package:choice_bussiness/styles/button_style.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../styles/app_colors.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final _formKey = GlobalKey<FormState>();
  var count = 0;

  AddServiceController addServiceController = AddServiceController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<AddServiceController>(initState: (context) {
            addServiceController.getSubCategory();
          }, builder: (controller) {
            if (controller.isLoading.value) {
              return Scaffold(
                  body: Center(
                      child: CircularProgressIndicator(
                color: AppColors.themeColor,
              )));
            } else {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            padding: const EdgeInsets.only(top: 50),
            children: [
              MyWidgets.textView(
                  'Add service :', AppColors.themeColorLight, 16),

              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Container(
                    //   //height: 50,
                    //
                    //   child: DropdownButtonFormField(
                    //     validator: (input) =>
                    //     input == null ? "Please Enter a category" : null,
                    //    // iconSize: 0,
                    //     decoration: InputDecoration(
                    //       //suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                    //       contentPadding:
                    //       const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    //       hintText: '     Select Entry category',
                    //       hintStyle: TextStyle(fontSize: 16,color: AppColors.themeColorTwo),
                    //       border: OutlineInputBorder(
                    //           borderSide: const BorderSide(color: Colors.black),
                    //           borderRadius: BorderRadius.circular(8)),
                    //     ),
                    //     items: controller.allCatList.map((var value) {
                    //       print(value.subcat!.length);
                    //       return DropdownMenuItem(
                    //           value: value.id,
                    //           child: Text('     ${value.title}'));
                    //     }).toList(),
                    //     onChanged: (var value) {
                    //       setState(() {
                    //         count = int.parse(value.toString()) -1;
                    //         print(count);
                    //         controller.categoryy = value.toString();
                    //       });
                    //     },
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    //  controller.allCatList[count].subcat!.isEmpty?
                    //     SizedBox():
                    // Container(
                    //   child: DropdownButtonFormField(
                    //     validator: (input) =>
                    //     input == null ? "Please Enter Sub category" : null,
                    //     // iconSize: 0,
                    //     decoration: InputDecoration(
                    //       //suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                    //       contentPadding:
                    //       const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    //       hintText: '     Select Entry Sub category',
                    //       hintStyle: TextStyle(fontSize: 16,color: AppColors.themeColorTwo),
                    //       border: OutlineInputBorder(
                    //           borderSide: const BorderSide(color: Colors.black),
                    //           borderRadius: BorderRadius.circular(8)),
                    //     ),
                    //     items: controller.allSubCatList.map((var value) {
                    //       return DropdownMenuItem(
                    //           value: value.id,
                    //           child: Text('   ${value.title}'));
                    //     }).toList(),
                    //     onChanged: (var value) {
                    //       setState(() {
                    //         print(value);
                    //         controller.categoryy = value.toString();
                    //       });
                    //     },
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.themeColorTwo,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: DropdownButton(
                        underline: const SizedBox(),
                        style: TextStyle(color: AppColors.themeColorTwo),
                        hint: MyWidgets.textView(
                            'Please select your Subcategory',
                            AppColors.themeColorTwo,
                            16),
                        // Not necessary for Option 1
                        value: addServiceController.subCategory,
                        onChanged: (newValue) {
                          setState(() {
                            addServiceController.subCategory =
                                newValue.toString();
                          });
                        },
                        items: addServiceController.allSubCatList
                            .map((subCat) {
                          return DropdownMenuItem(
                            value: subCat.id,
                            child:
                                MyWidgets.textView(subCat.title, Colors.black, 16),
                          );
                        }).toList(),
                      ),
                    ),
                    // const SizedBox(height: 20),
                    // TextFormField(
                    //     style: TextStyle(
                    //         color: AppColors.themeColorTwo, fontSize: 18),
                    //     controller: addServiceController.serviceName,
                    //     validator: (value) => value!.isEmpty
                    //         ? 'Please enter Artist profile name'
                    //         : null,
                    //     decoration: InputDecoration(
                    //         contentPadding: const EdgeInsets.symmetric(
                    //             vertical: 16, horizontal: 14),
                    //         enabled: true,
                    //         labelText: 'Enter Artist profile name',
                    //         labelStyle: TextStyle(
                    //           fontSize: 16,
                    //           color: AppColors.themeColorTwo,
                    //           fontWeight: FontWeight.w600,
                    //           // light
                    //           fontStyle: FontStyle.normal,
                    //         ),
                    //         errorStyle: const TextStyle(
                    //           fontSize: 16,
                    //           color: Colors.red,
                    //           fontWeight: FontWeight.w600,
                    //           // light
                    //           fontStyle: FontStyle.normal,
                    //         ),
                    //         border: OutlineInputBorder(
                    //             borderSide:
                    //                 BorderSide(color: AppColors.themeColor)),
                    //         enabledBorder: OutlineInputBorder(
                    //             borderSide:
                    //                 BorderSide(color: AppColors.themeColorTwo)),
                    //         errorBorder: const OutlineInputBorder(
                    //             borderSide: BorderSide(color: Colors.red)))),
                    const SizedBox(height: 20),
                    TextFormField(
                        controller: addServiceController.price,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: AppColors.themeColorTwo, fontSize: 18),
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter price' : null,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 14),
                            enabled: true,
                            labelText: 'Enter price',
                            labelStyle: TextStyle(
                              fontSize: 16,
                              color: AppColors.themeColorTwo,
                              fontWeight: FontWeight.w600,
                              // light
                              fontStyle: FontStyle.normal,
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              // light
                              fontStyle: FontStyle.normal,
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.themeColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.themeColorTwo)),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)))),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.themeColorTwo,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: DropdownButton(
                        underline: const SizedBox(),
                        style: TextStyle(color: AppColors.themeColorTwo),
                        hint: MyWidgets.textView('Please select your location',
                            AppColors.themeColorTwo, 16),
                        // Not necessary for Option 1
                        value: addServiceController.selectedLocation,
                        onChanged: (newValue) {
                          setState(() {
                            addServiceController.selectedLocation =
                                newValue.toString();
                          });
                        },
                        items: addServiceController.locations.map((location) {
                          return DropdownMenuItem(
                            value: location,
                            child:
                                MyWidgets.textView(location, Colors.black, 16),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                        style: TextStyle(
                            color: AppColors.themeColorTwo, fontSize: 18),
                        controller: addServiceController.description,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter description' : null,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 14),
                            enabled: true,
                            labelText: 'Please enter description',
                            labelStyle: TextStyle(
                              fontSize: 16,
                              color: AppColors.themeColorTwo,
                              fontWeight: FontWeight.w600,
                              // light
                              fontStyle: FontStyle.normal,
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              // light
                              fontStyle: FontStyle.normal,
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.themeColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.themeColorTwo)),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)))),
                    const SizedBox(height: 20),
                    TextFormField(
                        controller: addServiceController.about,
                        style: TextStyle(
                            color: AppColors.themeColorTwo, fontSize: 18),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter about your business'
                            : null,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 14),
                            enabled: true,
                            labelText: 'Enter About your business',
                            labelStyle: TextStyle(
                              fontSize: 16,
                              color: AppColors.themeColorTwo,
                              fontWeight: FontWeight.w600,
                              // light
                              fontStyle: FontStyle.normal,
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              // light
                              fontStyle: FontStyle.normal,
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.themeColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.themeColorTwo)),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)))),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        style: elevatedButtonStyleWhiteCurve,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addServiceController.addService();
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
              const SizedBox(height: 20),
            ],
          ),
        );
      }
    }));
  }
}
