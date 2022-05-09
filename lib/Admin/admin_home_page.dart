import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'manage_building.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  bool showpassword = true;


  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  Future<void> log_in() async {
    var request = http.MultipartRequest('POST', Uri.parse(API + "signin.php"));
    request.fields.addAll(
        {'email': email, 'password': password});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var allresponse = json.decode(await response.stream.bytesToString());
      var code = allresponse['code'].toString();
      var message = allresponse['message'];
      if (code == "-1") {
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Logged in successfully",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ManageBuilding()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: Color(0xFF3B3B3B),
                          ),
                        ),
                        Text(
                          "sign in",
                          style:
                              TextStyle(color: Color(0xFF3B3B3B), fontSize: 30),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xFF3B3B3B),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/Logo.png",
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blue),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      validator: (val) =>
                      val.isNotEmpty ? null : "Please enter a valid email",
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      textDirection: TextDirection.ltr,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.person_outline,
                              color: Color(0xFF2A66EC),
                            ),
                          ),
                        ),

                        hintTextDirection: TextDirection.ltr,
                        filled: false,
                        hintText: "Username",
                        hintStyle: TextStyle(color: Colors.black26),
                        labelStyle: TextStyle(fontSize: 18),
                        // suffixIcon: icon,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(

                      validator: (val) =>
                      val.isNotEmpty  ? null : "Please enter a valid password",
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: showpassword,


                      textDirection: TextDirection.ltr,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.visibility,
                              color: Color(0xFF2A66EC),
                            ),
                            onPressed: () {
                              setState(() {
                                showpassword = !showpassword;
                              });
                            },
                          ),
                        ),

                        prefixIcon: Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.vpn_key_outlined,
                              color: Color(0xFF2A66EC),
                            ),
                          ),
                        ),

                        hintTextDirection: TextDirection.ltr,
                        filled: false,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.black26),
                        labelStyle: TextStyle(fontSize: 18),
                        // suffixIcon: icon,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        log_in();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Center(
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
