
import 'package:flutter/material.dart';

import 'Admin/admin_home_page.dart';
import 'User/choose_category.dart';
import 'User/user_home_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminHomePage()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent
                    ),
                    margin: EdgeInsets.only(top: 40,right: 20),
                    padding: EdgeInsets.all(10),
                    child: Wrap(
                      children: <Widget>[
                        Text(
                          "Admin",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 50),
              child: Image.asset(
                "assets/Logo.png",
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width ,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseCategory()),
                );
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
                    "Find crowd",
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
    );
  }
}
