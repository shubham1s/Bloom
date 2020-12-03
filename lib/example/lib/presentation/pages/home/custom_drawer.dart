import 'package:flutter/material.dart';

/// builds drawer of [BLOOM]
class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text('Shubham'),
                onTap: null,
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('Calorie Calculator '),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/calorie');
                },
              ),
              ListTile(
                title: Text('fit data '),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/fitdat');
                },
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {},
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                title: Text('Health Data'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/health');
                },
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                  title: Text('Sign out'),
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Sign out of BLOOM'),
                        content: Text('Do you want to sign out?'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('No'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          FlatButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/onb');
                              }),
                        ],
                      ),
                      barrierDismissible: false,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
