import 'package:flutter/material.dart';


class Check_Stry extends StatefulWidget {
  @override
  _Check_StryState createState() => _Check_StryState();
}

class _Check_StryState extends State<Check_Stry> {
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          loading==true?Center(
            child: Padding(padding: EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Text('Checking your instagram story'),
                    CircularProgressIndicator(backgroundColor: Colors.white,
                      // color: Colors.black,
                    ),
                    SizedBox(height: 20,),
                    FlatButton(onPressed: (){setState(() {loading=false;});}, child: Text('checking done'),color: Colors.grey,)
                  ],
                )
            ),
          ):Text('checking done!!'),
        ],
      ),
    );
  }
}
