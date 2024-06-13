import 'package:choice_bussiness/styles/app_colors.dart';
import 'package:choice_bussiness/styles/commonmodule/app_bar.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Notification'),
      body: Center(child: MyWidgets.textView('No notification', AppColors.black, 13),),
    );
  }
}
