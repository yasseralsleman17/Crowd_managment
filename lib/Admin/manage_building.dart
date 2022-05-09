import 'package:crowd_managment/Admin/add_building.dart';
import 'package:crowd_managment/Admin/choose_category.dart';
import 'package:crowd_managment/Admin/edit_building.dart';
import 'package:crowd_managment/first_page.dart';
import 'package:flutter/material.dart';

import 'delete_building.dart';

class ManageBuilding extends StatelessWidget {
  const ManageBuilding({Key key}) : super(key: key);

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
                        onTap:()=> Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Color(0xFF3B3B3B),
                        ),
                      ),
                      Text(
                        "Manage Building",
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

                Container(
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextButton(
                    onPressed: (){

                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>  ChooseCategory()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Center(
                        child: Text(
                          "Add Building",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>  EditBuilding()));

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Center(
                        child: Text(
                          "Edit Building",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>  DeleteBuilding()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Center(
                        child: Text(
                          "Delete Building",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),

                TextButton(
                  onPressed: (){


                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) =>  FirstPage()));

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10),
                      color: Colors.purpleAccent,
                    ),
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Text(
                        "Logout",
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
}
