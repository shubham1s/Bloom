import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class CreaterPage extends StatefulWidget {
  @override
  _CreaterPageState createState() => _CreaterPageState();
}

class _CreaterPageState extends State<CreaterPage> {
  // final String url = "https://youtu.be/VFrKjhcTAzE";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffffffff),
            iconTheme: IconThemeData(color: Colors.blue),
            title: Text(
              "Creater Section",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 10),
                  child: Container(
                    height: 180,
                    width: 180,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("Images/createrImage.jpg"),
                    ),
                  ),
                ),
                Text(
                  "Shubham Singh",
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Text(
                    "This app was created to help people who wish to do their daily routine of workout " +
                        "without disturbing their day to day activities." +
                        " The App is still in beta mode , some features are still yet to come . " +
                        "Your feedback is valuable to us . " +
                        "KEEP BLOOMING",
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.justify,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: GestureDetector(
                //     onTap: () async {
                //       if (await canLaunch(url)) {
                //         launch(url);
                //       }
                //     },
                //     child: Text(
                //       url,
                //       style: TextStyle(fontSize: 18, color: Colors.blue),
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // ),
                // Padding(
                //     padding: EdgeInsets.only(top: 20),
                //     child: Text(
                //       r"$ 49",
                //       style: TextStyle(fontSize: 40, color: Colors.blue),
                //     ))
              ],
            ),
          )),
    );
  }
}
