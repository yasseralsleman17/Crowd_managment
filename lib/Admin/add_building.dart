import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class AddBuilding extends StatefulWidget {
  final String  Category;

  const AddBuilding({Key key, this.Category}) : super(key: key);

  @override
  _AddBuildingState createState() => _AddBuildingState();
}

class _AddBuildingState extends State<AddBuilding> {
  TextEditingController _buildingNameController = new TextEditingController();
  TextEditingController _buildingCapacityController =
      new TextEditingController();
  List<TextEditingController> _gateNameControllers = new List();
  List<TextEditingController> _gateSensorControllers = new List();

  int slid = 1;
  int gates = 1;

  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    _gateNameControllers.add(new TextEditingController());
    _gateSensorControllers.add(new TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:Form(
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
                        onTap:()=> Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Color(0xFF3B3B3B),
                        ),
                      ),
                      Text(
                        "Add Building",
                        style: TextStyle(color: Color(0xFF3B3B3B), fontSize: 20),
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
                  margin: EdgeInsets.only(top: 15),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.grey[100],
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _buildingNameController,

                    validator: (val) =>
                    val.isNotEmpty  ? null : "Please enter building name",

                    textDirection: TextDirection.ltr,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.ltr,
                      border: InputBorder.none,
                      filled: false,
                      hintText: "building name",
                      hintStyle: TextStyle(color: Colors.black26),
                      contentPadding: EdgeInsets.all(0),
                      labelStyle: TextStyle(fontSize: 15),
                      // suffixIcon: icon,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "maximum capacity",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey[100],
                        ),
                        child: TextFormField(
                          validator: (val) =>
                          val.isNotEmpty  ? null : "* Please enter maximum capacity",

                          textAlign: TextAlign.center,
                          controller: _buildingCapacityController,
                          textDirection: TextDirection.ltr,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintTextDirection: TextDirection.ltr,
                            border: InputBorder.none,
                            filled: false,
                            hintText: "",
                            hintStyle: TextStyle(color: Colors.black26),
                            contentPadding: EdgeInsets.all(0),
                            labelStyle: TextStyle(fontSize: 15),
                            // suffixIcon: icon,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.27,
                        child: Text(
                          "crowed % limit",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.48,
                        child: Slider(
                          activeColor: Colors.deepPurple[300],
                          value: slid.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              slid = value.toInt();
                            });
                          },
                          min: 0,
                          max: 100,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.12,
                        child: Text(
                          "$slid %",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                new Flexible(
                  child: new ListView.builder(
                    padding: new EdgeInsets.all(8.0),
                    itemBuilder: (_, int index) => gate(index),
                    itemCount: gates,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    gates++;
                    _gateNameControllers.add(new TextEditingController());
                    _gateSensorControllers.add(new TextEditingController());
                    setState(
                      () {

                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10),
                      color: Colors.green,
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Text(
                        "add gate",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: (){
                    if (_formKey.currentState.validate()) {
                    addBuilding();
                    }},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10),
                      color: Colors.deepPurple,
                    ),
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Text(
                        "save",
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
    );
  }

  Widget gate(int index) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(5),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "gate name",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey[100],
                      ),
                      child: TextFormField(
                        validator: (val) =>
                        val.isNotEmpty  ? null : "* Please enter gate name",

                        textAlign: TextAlign.center,
                        controller: _gateNameControllers[index],
                        textDirection: TextDirection.ltr,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintTextDirection: TextDirection.ltr,
                          border: InputBorder.none,
                          filled: false,
                          hintText: "",
                          hintStyle: TextStyle(color: Colors.black26),
                          contentPadding: EdgeInsets.all(0),
                          labelStyle: TextStyle(fontSize: 15),
                          // suffixIcon: icon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "paired sensor id",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey[100],
                      ),
                      child: TextFormField(
                        validator: (val) =>
                        val.isNotEmpty  ? null : "* Please enter sensor id",

                        textAlign: TextAlign.center,
                        controller: _gateSensorControllers[index],
                        textDirection: TextDirection.ltr,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintTextDirection: TextDirection.ltr,
                          border: InputBorder.none,
                          filled: false,
                          hintText: "",
                          hintStyle: TextStyle(color: Colors.black26),
                          contentPadding: EdgeInsets.all(0),
                          labelStyle: TextStyle(fontSize: 15),
                          // suffixIcon: icon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            left: 50,
            top: 10,
            child: Container(
              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              color: Colors.white,
              child: Text(
                'gate #${index + 1}',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            )),
      ],
    );
  }

  Future<void> addBuilding() async {
    String gateNames = "";
    String gateSensorIds = "";
    gateNames = _gateNameControllers[0].text;
    gateSensorIds = _gateSensorControllers[0].text;
    for (int i = 1; i < _gateNameControllers.length; i++) {
      gateNames = gateNames + "," + _gateNameControllers[i].text;
      gateSensorIds = gateSensorIds + "," + _gateSensorControllers[i].text;
    }
    var request =
        http.MultipartRequest('POST', Uri.parse(API + "add_building.php"));
    request.fields.addAll({
      'building_name': _buildingNameController.text,
      'max_capaity': _buildingCapacityController.text,
      'crowd_limit': slid.toString(),
      'category': widget.Category,
      'gate_names': gateNames,
      'gate_sensor_ids': gateSensorIds
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var allresponse = json.decode(await response.stream.bytesToString());
      var message = allresponse['message'];

      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
  }
}
