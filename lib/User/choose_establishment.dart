import 'package:crowd_managment/User/choose_category.dart';
import 'package:flutter/material.dart';

import 'choose_building.dart';

class ChooseEstablishment extends StatefulWidget {
  const ChooseEstablishment({Key key}) : super(key: key);

  @override
  _ChooseEstablishmentState createState() => _ChooseEstablishmentState();
}

class _ChooseEstablishmentState extends State<ChooseEstablishment> {
  List<String> buildingImages = [
    'PNU.png',
    'Logo (2).png',
    "University logo.png",
    "KACST.png",
    "Fahd.png",
    "Umm Al-Qura.png"
  ];

  List<String> Category = [
    'PNU',
    'KSU',
    "KAUST",
    "KAU",
    "KFUPM",
    "UQU"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                      "Choose Establishment",
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
              Flexible(
                fit: FlexFit.tight,
                child: GridView.builder(
                  physics: ScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) => category(index),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.9,
                    crossAxisCount: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget category(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChooseBuilding(Category: Category[index])));
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Image.asset(
              "assets/" + buildingImages[index],
            ),
          ),
          Text(
            Category[index],
            style: TextStyle(color: Colors.grey, fontSize: 18),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
