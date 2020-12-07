import 'package:BLOOM_BETA/services/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User user = User("");
  bool _isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final authData = snapshot.data;

    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // CircleAvatar(
                //             backgroundImage: getProfileImage(),
                //           ),
                //           SizedBox(height: 15,),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Name: ${authData.displayName ?? 'Anonymous'}",
                    style: GoogleFonts.poppins(
                        fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Email: ${authData.email ?? 'Anonymous'}",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Account Created: ${DateFormat('MM/dd/yyyy').format(authData.metadata.creationTime)}",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                  ),
                ]),
              ],
            )
          ]))
    ]);
  }

  // ignore: unused_element
  _getProfileData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .get()
        .then((result) {
      user.admin = result.data['admin'];
    });
  }

  Widget adminFeature() {
    if (_isAdmin == true) {
      return Text("You are an admin");
    } else {
      return Container();
    }
  }
}

class User {
  String homeCountry;
  bool admin;

  User(this.homeCountry);

  Map<String, dynamic> toJson() => {
        'homeCountry': homeCountry,
        'admin': admin,
      };
}
