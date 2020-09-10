import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  final String userName,jwt,email;


  HomePage(this.userName, this.jwt,this.email);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome " + widget.userName),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.jwt),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.email,style: TextStyle(fontSize: 30,color: Colors.green),),
            ),
          ],
        ),
      ),
    );
  }
}
