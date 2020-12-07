import 'package:BLOOM_BETA/features/timer.dart';
import 'package:BLOOM_BETA/fitness_app/fitness_app_home_screen.dart';
import 'package:BLOOM_BETA/heart/chart.dart';
import 'package:BLOOM_BETA/ui_pages/calorie.dart';
import 'package:BLOOM_BETA/ui_pages/onb_sceen.dart';
import 'package:BLOOM_BETA/ui_pages/sign_up1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:BLOOM_BETA/heart/fit.dart';
import 'package:flutter/material.dart';
import 'package:BLOOM_BETA/services/auth_service.dart';
import 'package:BLOOM_BETA/services/provider.dart';
import 'package:BLOOM_BETA/features/input.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      db: FirebaseFirestore.instance,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext cvontext) => HomeController(),
          '/time': (BuildContext context) => ExerciseMode(),
          '/homepage': (BuildContext context) => FitnessAppHomeScreen(),
          '/fitdat': (BuildContext context) => FitDat(),
          '/onb': (BuildContext context) => OnboardingScreen(),
          '/health': (BuildContext context) => HealthFit(),
          '/calorie': (BuildContext context) =>
              CaloriePage(title: 'Calorie Calculator'),
          '/login': (BuildContext context) => SignUpView(
                authFormType: AuthFormType.signUp,
              ),
          '/signIn': (BuildContext context) =>
              SignUpView(authFormType: AuthFormType.signIn),
          '/signout': (BuildContext context) =>
              SignUpView(authFormType: AuthFormType.signOut),
          '/input': (BuildContext context) => DataEntryScreen(),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? FitnessAppHomeScreen() : OnboardingScreen();
        }
        return Container();
      },
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
