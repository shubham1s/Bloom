import 'package:flutter/material.dart';
import 'dart:async';

class CaloriePage extends StatefulWidget {
  CaloriePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CaloriePageState createState() => new _CaloriePageState();
}

class _CaloriePageState extends State<CaloriePage> {
  int calorieBase;
  int calorieAvecActivite;
  int radioSelectionnee;
  double weight;
  double age;
  bool genre = false;
  double height = 170.0;
  Map mapActivite = {0: "Beginner", 1: "Ocassional", 2: "Regular"};

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(new FocusNode())),
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
          backgroundColor: setColor(),
          elevation: 0,
          brightness: Brightness.light,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/homepage');
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: new SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              padding(),
              texteAvecStyle(
                  "Fill in all the fields to get your daily calorie requirement."),
              padding(),
              new Card(
                elevation: 10.0,
                child: new Column(
                  children: <Widget>[
                    padding(),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        texteAvecStyle("Women", color: Colors.pink),
                        new Switch(
                            value: genre,
                            inactiveTrackColor: Colors.pink,
                            activeTrackColor: Colors.blue,
                            onChanged: (bool b) {
                              setState(() {
                                genre = b;
                              });
                            }),
                        texteAvecStyle("Men", color: Colors.blue)
                      ],
                    ),
                    padding(),
                    new RaisedButton(
                        color: setColor(),
                        child: texteAvecStyle(
                            (age == null)
                                ? "Press to enter your age"
                                : "Your age is : ${age.toInt()}",
                            color: Colors.white),
                        onPressed: (() => showPicker())),
                    padding(),
                    texteAvecStyle("Your height is : ${height.toInt()} cm.",
                        color: setColor()),
                    padding(),
                    new Slider(
                      value: height,
                      activeColor: setColor(),
                      onChanged: (double d) {
                        setState(() {
                          height = d;
                        });
                      },
                      max: 215.0,
                      min: 100.0,
                    ),
                    padding(),
                    new TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (String string) {
                        setState(() {
                          weight = double.tryParse(string);
                        });
                      },
                      decoration: new InputDecoration(
                          labelText: "  Enter your weight in kilos."),
                    ),
                    padding(),
                    texteAvecStyle("Rate your daily activities?",
                        color: setColor()),
                    padding(),
                    rowRadio(),
                    padding()
                  ],
                ),
              ),
              padding(),
              new RaisedButton(
                color: setColor(),
                child: texteAvecStyle("Calculate", color: Colors.white),
                onPressed: calculateCalories,
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding padding() {
    return new Padding(padding: EdgeInsets.only(top: 20.0));
  }

  Future<Null> showPicker() async {
    DateTime choice = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now(),
        initialDatePickerMode: DatePickerMode.year);
    if (choice != null) {
      var difference = new DateTime.now().difference(choice);
      var days = difference.inDays;
      var year = (days / 365);
      setState(() {
        age = year;
      });
    }
  }

  Color setColor() {
    if (genre) {
      return Colors.blue;
    } else {
      return Colors.pink;
    }
  }

  Text texteAvecStyle(String data, {color: Colors.black, fontSize: 15.0}) {
    return new Text(data,
        textAlign: TextAlign.center,
        style: new TextStyle(color: color, fontSize: fontSize));
  }

  Row rowRadio() {
    List<Widget> l = [];
    mapActivite.forEach((key, value) {
      Column colonne = new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Radio(
              activeColor: setColor(),
              value: key,
              groupValue: radioSelectionnee,
              onChanged: (Object i) {
                setState(() {
                  radioSelectionnee = i;
                });
              }),
          texteAvecStyle(value, color: setColor())
        ],
      );
      l.add(colonne);
    });
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: l,
    );
  }

  void calculateCalories() {
    if (age != null && weight != null && radioSelectionnee != null) {
      //Calculer
      if (genre) {
        calorieBase =
            (66.4730 + (13.7516 * weight) + (5.0033 * height) - (6.7550 * age))
                .toInt();
      } else {
        calorieBase =
            (655.0955 + (9.5634 * weight) + (1.8496 * height) - (4.6756 * age))
                .toInt();
      }
      switch (radioSelectionnee) {
        case 0:
          calorieAvecActivite = (calorieBase * 1.2).toInt();
          break;
        case 1:
          calorieAvecActivite = (calorieBase * 1.5).toInt();
          break;
        case 2:
          calorieAvecActivite = (calorieBase * 1.8).toInt();
          break;
        default:
          calorieAvecActivite = calorieBase;
          break;
      }

      setState(() {
        dialogue();
      });
    } else {
      alerte();
    }
  }

  Future<Null> dialogue() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return SimpleDialog(
            title:
                texteAvecStyle("Your calorie requirement", color: setColor()),
            contentPadding: EdgeInsets.all(15.0),
            children: <Widget>[
              padding(),
              texteAvecStyle("Your basic need is to: $calorieBase"),
              padding(),
              texteAvecStyle(
                  "your need with sport activities is : $calorieAvecActivite"),
              new RaisedButton(
                onPressed: () {
                  Navigator.pop(buildContext);
                },
                child: texteAvecStyle("OK", color: Colors.white),
                color: setColor(),
              )
            ],
          );
        });
  }

  Future<Null> alerte() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return new AlertDialog(
            title: texteAvecStyle("Error"),
            content: texteAvecStyle("NOT ALL FIELDS ARE FILLED"),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(buildContext);
                  },
                  child: texteAvecStyle("OK", color: Colors.red))
            ],
          );
        });
  }
}
