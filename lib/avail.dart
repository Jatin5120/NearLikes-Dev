import 'package:flutter/material.dart';

class Available extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Text('The APP is not available for now! \n \n Will be available on 10-Sep-2021',
        style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),),
      ),),
    );
  }
}
