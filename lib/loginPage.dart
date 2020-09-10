import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_strapi_test/homepage.dart';
import 'package:new_strapi_test/registerPage.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextControl = TextEditingController();
  TextEditingController passwordextControl = TextEditingController();

  @override
  void dispose() {
    emailTextControl.dispose();
    passwordextControl.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Login Now ",style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(

          child: Column(
            children: [
              customTextField("Email", emailTextControl, 1),
              customTextField("Password", passwordextControl, 1),
              FlatButton.icon(onPressed: () async {
                var url = "http://161.35.205.247/auth/local";

                var response = await http.post(url, body: {
                  "identifier" : emailTextControl.text.trim(),
                  "password": passwordextControl.text
                });
                if (response.statusCode == 200) {
                  var body  =jsonDecode(response.body);
                  print(body["jwt"]);

                  Navigator. pushReplacement(context, MaterialPageRoute(
                      builder: (context) => HomePage(body["user"]["username"].toString(),body["jwt"].toString(),body["user"]["email"].toString())));

                } else {
                  print('Request failed with status: ${response.statusCode}.');
                }


              }, icon:Icon(Icons.arrow_forward), label: Text('Login')),
              FlatButton.icon(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)  => RegisterPage()));
              }, icon: Icon(Icons.verified_user), label: Text("Create New User"))
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
