import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../main.dart';

class BuildingPage extends StatefulWidget {
  final String Id;

  const BuildingPage({Key key, this.Id}) : super(key: key);

  @override
  _BuildingPageState createState() => _BuildingPageState();
}

class _BuildingPageState extends State<BuildingPage> {
  int crowd_limit = 0;
  double max_capaity = 0.0;
  var building_name = "building name";

  double gatecrowded = 0.0;
  List<dynamic> values;

  List<EarningsTimeline> datad = new List<EarningsTimeline>();
  List<EarningsTimeline> datad_unic = new List<EarningsTimeline>();
  List<charts.Series<EarningsTimeline, String>> timeline;

  List<String> days = List.generate(7, (index) {
    final weekday = DateTime.now().subtract(Duration(days: index));

    return DateFormat.E().format(weekday);
  });

  int choosed_day = 6;
  int choosed_gate = 0;

  List<dynamic> gates;
  int gatesNum = 0;

  @override
  void initState() {
    getBuildinginfo();
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
                        building_name,
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
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFF3B3B3B),
                ),
                Column(
                  children: <Widget>[
                    new Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: new ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: gatesNum,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                choosed_gate = index;
                                getBuildingData();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  right:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  choosed_gate == index
                                      ? Image.asset(
                                          "assets/gate_on.PNG",
                                        )
                                      : Image.asset(
                                          "assets/gate_off.PNG",
                                        ),
                                  Text(
                                    "gate ${index + 1}",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 20, top: 10),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.5,
                            child: gatecrowded < 25
                                ? Image.asset(
                                    "assets/not_crowded.PNG",
                                  )
                                : (gatecrowded < 65
                                    ? Image.asset(
                                        "assets/sime_crowded.PNG",
                                      )
                                    : Image.asset(
                                        "assets/crowded.PNG",
                                      )),
                          ),
                          Text(
                            gatecrowded < 25
                                ? "not crowded"
                                : (gatecrowded < 65
                                    ? "semi crowded"
                                    : "crowded"),
                            style: TextStyle(color: Colors.grey, fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            gatecrowded < 25
                                ? " 0 - 25 % "
                                : (gatecrowded < 65
                                    ? "25 - 65 % "
                                    : "65 - 100 % "),
                            style: TextStyle(color: Colors.grey, fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(15),
                        color: Colors.grey[400],
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                choosed_day = 6;
                                filterdata();
                              });
                            },
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  days[6],
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              color: choosed_day == 6
                                  ? Colors.white
                                  : Colors.grey[400],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                choosed_day = 5;
                                filterdata();
                              });
                            },
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  days[5],
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              color: choosed_day == 5
                                  ? Colors.white
                                  : Colors.grey[400],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                choosed_day = 4;
                                filterdata();
                              });
                            },
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  days[4],
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              color: choosed_day == 4
                                  ? Colors.white
                                  : Colors.grey[400],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                choosed_day = 3;
                                filterdata();
                              });
                            },
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  days[3],
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              color: choosed_day == 3
                                  ? Colors.white
                                  : Colors.grey[400],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                choosed_day = 2;
                                filterdata();
                              });
                            },
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  days[2],
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              color: choosed_day == 2
                                  ? Colors.white
                                  : Colors.grey[400],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                choosed_day = 1;
                                filterdata();
                              });
                            },
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  days[1],
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              color: choosed_day == 1
                                  ? Colors.white
                                  : Colors.grey[400],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                choosed_day = 0;
                                filterdata();
                              });
                            },
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  days[0],
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              color: choosed_day == 0
                                  ? Colors.white
                                  : Colors.grey[400],
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: timeline == null
                          ? Container()
                          : Column(
                              children: [
                                Expanded(
                                  child: charts.BarChart(
                                    timeline,
                                    animate: true,
                                    vertical: true,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getBuildinginfo() async {
    var request =
        http.MultipartRequest('POST', Uri.parse(API + "get_building_data.php"));
    request.fields.addAll({
      'building_id': widget.Id,
    });
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var allresponse = json.decode(await response.stream.bytesToString());

      gates =
          allresponse['gates'] != null ? List.from(allresponse['gates']) : null;
      gatesNum = gates.length;

      crowd_limit = int.parse(allresponse['crowd_limit']);
      max_capaity = double.parse(allresponse['max_capaity']);
      building_name = allresponse['building_name'];
    }

    getBuildingData();
  }

  Future<void> getBuildingData() async {
    var headers = {'X-Auth-Token': 'BBFF-w0DpJzY7JGfRS3Fsgfqf1r4Go18IFh'};
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'https://things.ubidots.com/api/v1.6/variables/${gates[choosed_gate]["sensor_id"]}/values'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var allresponse = json.decode(await response.stream.bytesToString());
      var results = allresponse['results'];
      values = results != null ? List.from(results) : null;

      filterdata();
    } else {
      getBuildingData();
    }
  }

  void filterdata() {

    datad = new List<EarningsTimeline>();
    gatecrowded = 0.0;
    for (int i = 0; i < 24; i++) {
      datad.add(new EarningsTimeline(date: i, value: 0));
    }

    for (int i = 0; i < values.length; i++) {
      var date = new DateTime.fromMicrosecondsSinceEpoch(
          values[i]["timestamp"] * 1000);
      if (date.isAfter(DateTime.now().subtract(Duration(minutes: DateTime.now().minute))) && date.isBefore(DateTime.now())) {
        gatecrowded += values[i]["value"];}
      if (date.isAfter(DateTime.now().subtract(Duration(
              days: choosed_day,
              hours: DateTime.now().hour,
              minutes: DateTime.now().minute))) &&
          date.isBefore(DateTime.now().subtract(Duration(
            days: choosed_day - 1,
            hours: DateTime.now().hour,
            minutes: DateTime.now().minute,)))) {
        datad.add( new EarningsTimeline(date: date.hour, value: values[i]["value"]));
      }
    }
    gatecrowded = (gatecrowded * 100) / (max_capaity);



    datad.sort((a, b) => a.date.compareTo(b.date));


    datad_unic = List.generate(24, (index) {
      double val = 0;
      for (int i = 0; i < datad.length; i++) {
        if (datad[i].date == index) val += datad[i].value;
      }
      return EarningsTimeline(date: index, value: val);
    });

    for (int i = 0; i < datad_unic.length; i++)
      timeline = [
        charts.Series(
          id: "data",
          data: datad_unic,
          domainFn: (EarningsTimeline timeline, _) => timeline.date.toString(),
          measureFn: (EarningsTimeline timeline, _) => timeline.value,
        )
      ];

    setState(() {});
  }
}

class EarningsTimeline {
  final int date;
  final double value;

  EarningsTimeline({
    @required this.date,
    @required this.value,
  });
}
