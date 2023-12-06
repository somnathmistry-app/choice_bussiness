import 'package:flutter/material.dart';

class LeadsPage extends StatefulWidget {
  const LeadsPage({Key? key}) : super(key: key);

  @override
  State<LeadsPage> createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Leads'),
      ),
    );
  }
}
