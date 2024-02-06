import 'package:choice_bussiness/styles/app_colors.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/radio_model.dart';


class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    //bool lightMode = MagicFunctions.isLightMode(context);

    return Center(
      child: new Container(
        // margin: new EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              // padding: EdgeInsets.symmetric(vertical: 10),
              decoration: new BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: new Border.all(
                    width: 1.5,
                    color: _item.isSelected ? Colors.deepPurple : AppColors.themeColor),
              ),
              child: Container(
                width: context.mediaQuery.size.width/3.4,
                height: 80,
                margin: EdgeInsets.all(1.6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyWidgets.textView(_item.planname, Colors.purple, 13, fontWeight: FontWeight.bold),
                    SizedBox(height: 6),
                    MyWidgets.textView(_item.price, AppColors.black, 13, fontWeight: FontWeight.bold),
                    MyWidgets.textView(_item.time, AppColors.black, 12),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
