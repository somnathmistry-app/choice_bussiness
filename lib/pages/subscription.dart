import 'package:choice_bussiness/styles/commonmodule/app_bar.dart';
import 'package:flutter/material.dart';
class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Subscription'),
    );
  }
}
