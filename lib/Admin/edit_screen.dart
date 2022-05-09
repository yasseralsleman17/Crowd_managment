import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'dart:convert';

class EditScreen extends StatefulWidget {
  final String buildingId;

  const EditScreen(this.buildingId, {Key key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _buildingNameController = new TextEditingController();
  TextEditingController _buildingCapacityController =
      new TextEditingController();
  List<TextEditingController> _gateNameControllers = new List();

  List<TextEditingController> _gateSensorControllers = new List();

  int gatesNum = 0;

  final _formKey = GlobalKey<FormState>();


  List<dynamic> gates;
  int crowd_limit = 0;
  var max_capaity = "";
  var building_name = "building name";

  @override
  void initState() {
    getBuildingData();
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
                        "edit Building - $building_name",
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
                    validator: (val) =>
                    val.isNotEmpty  ? null : "Please enter building name",

                    textAlign: TextAlign.center,
                    controller: _buildingNameController,
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
                          textAlign: TextAlign.center,
                          validator: (val) =>
                          val.isNotEmpty  ? null : "* Please enter maximum capacity",

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
                          value: crowd_limit.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              crowd_limit = value.toInt();
                            });
                          },
                          min: 0,
                          max: 100,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.12,
                        child: Text(
                          "${crowd_limit} %",
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
                    itemCount: gatesNum,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      gatesNum++;
                      _gateNameControllers.add(new TextEditingController());
                      _gateSensorControllers.add(new TextEditingController());
                    });
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
                      editBuilding();
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
                        "save changes",
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
          height: 150,
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

  Future<void> getBuildingData() async {
    var request =
        http.MultipartRequest('POST', Uri.parse(API + "get_building_data.php"));
    request.fields.addAll({'building_id': widget.buildingId});
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var allresponse = json.decode(await response.stream.bytesToString());

      gates =
          allresponse['gates'] != null ? List.from(allresponse['gates']) : null;
      gatesNum = gates.length;

      crowd_limit = int.parse(allresponse['crowd_limit']);
      max_capaity = allresponse['max_capaity'];
      building_name = allresponse['building_name'];

      _buildingNameController.text=building_name;
      _buildingCapacityController.text=max_capaity;

      for (int i = 0; i < gatesNum; i++) {
        _gateNameControllers.add(new TextEditingController());
        _gateSensorControllers.add(new TextEditingController());

        _gateNameControllers[i].text=gates[i]["gate_name"];
            _gateSensorControllers[i].text=gates[i]["sensor_id"];

      }

      setState(() {});
    }
  }


  Future<void> editBuilding() async {
    String gateNames = "";
    String gateSensorIds = "";
    gateNames = _gateNameControllers[0].text;
    gateSensorIds = _gateSensorControllers[0].text;

    for (int i = 1; i < _gateNameControllers.length; i++) {
      gateNames = gateNames + "," + _gateNameControllers[i].text;
      gateSensorIds = gateSensorIds + "," + _gateSensorControllers[i].text;
    }

    var request =
    http.MultipartRequest('POST', Uri.parse(API + "edit_building.php"));
    request.fields.addAll({
      'building_id':widget.buildingId,
      'building_name': _buildingNameController.text,
      'max_capaity': _buildingCapacityController.text,
      'crowd_limit': crowd_limit.toString(),
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
