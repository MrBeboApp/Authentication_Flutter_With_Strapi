import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController userNameTextControl = TextEditingController();
  TextEditingController emailTextControl = TextEditingController();
  TextEditingController passwordextControl = TextEditingController();

  @override
  void dispose() {
    emailTextControl.dispose();
    passwordextControl.dispose();
    userNameTextControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Register New Account Now",style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(

          child: Column(
            children: [
              customTextField("UserName", userNameTextControl, 1),
              customTextField("Email", emailTextControl, 1),
              customTextField("Password", passwordextControl, 1),
              FlatButton.icon(onPressed: () async {
                var url = "http://161.35.205.247/auth/local/register";

                var response = await http.post(url, body: {
                  "username": userNameTextControl.text,
                  "email": emailTextControl.text,
                  "password": passwordextControl.text
                });
                if (response.statusCode == 200) {
                  var body  =jsonDecode(response.body);
                  print(body["jwt"]);



                } else {
                  print('Request failed with status: ${response.statusCode}.');
                }


              }, icon:Icon(Icons.add), label: Text('Create')),

            ],
          ),

        ),
      ),
    );
  }

  Widget customTextField(String hitName,TextEditingController textEditingControl,int maxLine){
    return Padding(
      padding: const EdgeInsets.only(right:30,left: 30,top: 8),
      child: Container(
          child: TextField(
            maxLines: maxLine,
            controller:textEditingControl,
            decoration: InputDecoration(
              hoverColor: Colors.black,
              focusColor: Colors.black,
              focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black
                ),

              ),
              labelText: hitName,labelStyle: TextStyle(color: Colors.black),
            ),
          )),
    );
  }
}
