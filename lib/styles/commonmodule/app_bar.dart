import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../app_colors.dart';


var box = GetStorage();
AppBar appBar(String name) => AppBar(
  backgroundColor: AppColors.themeColor,
    title: Text(name,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16)));
