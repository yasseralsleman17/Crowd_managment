import 'dart:convert';

import 'package:crowd_managment/User/building_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
class ChooseBuilding extends StatefulWidget {


  final String  Category;
  const ChooseBuilding({Key key, this.Category}) : super(key: key);

  @override
  _ChooseBuildingState createState() => _ChooseBuildingState();
}

class _ChooseBuildingState extends State<ChooseBuilding> {
  @override
  void initState() {
    getBuilding();
  }

  List<dynamic> buildings;
  int buildingNum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: SingleChildScrollView(
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
                        widget.Category,
                        style:
                        TextStyle(color: Color(0xFF3B3B3B), fontSize: 20),
                      ),
                      Container(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 1,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: Color(0xFF3B3B3B),
                ),
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.9,
                  child: Column(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: GridView.builder(
                          physics: ScrollPhysics(),
                          itemCount: buildingNum,
                          itemBuilder: (context, index) =>
                              GestureDetector(
                                onTap: () {

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BuildingPage(Id: buildings[index]["id"])));

                                },
                                child: Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.45,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.45,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/Building.png",
                                      ),
                                      Text(
                                        buildings[index]["building_name"],
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 18),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.8,
                            crossAxisCount: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getBuilding() async {
    var request =
    http.MultipartRequest('POST', Uri.parse(API + "get_category_building.php"));
    request.fields.addAll({

      'category': widget.Category,

    });
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var allresponse = json.decode(await response.stream.bytesToString());
      var message = allresponse['message'];
      var code = allresponse['code'];
      if (code == 1) {
        var data = allresponse['data'];
        buildings = data != null ? List.from(data) : null;
        buildingNum = buildings.length;
        setState(() {});
      }
      else {
        buildings = null;
        buildingNum = 0;
        setState(() {});
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

}
