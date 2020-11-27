// import 'package:BLOOM_BETA/ui_pages/onb_sceen.dart';
// import 'package:BLOOM_BETA/ui_pages/sign_up1.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

// import 'package:flutter/material.dart';
// import 'package:BLOOM_BETA/services/auth_service.dart';
// import 'package:BLOOM_BETA/ui_pages/login.dart';
// import 'package:BLOOM_BETA/services/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Provider(
//       auth: AuthService(),
//       db: FirebaseFirestore.instance,
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: HomeController(),
//         routes: <String, WidgetBuilder>{
//           '/home': (BuildContext context) => HomeController(),
//           '/login': (BuildContext context) => LoginPage(),
//           '/signIn': (BuildContext context) =>
//               SignUpView(authFormType: AuthFormType.signIn),
//         },
//       ),
//     );
//   }
// }

// class HomeController extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final AuthService auth = Provider.of(context).auth;
//     return StreamBuilder<String>(
//       stream: auth.onAuthStateChanged,
//       builder: (context, AsyncSnapshot<String> snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           final bool signedIn = snapshot.hasData;
//           return signedIn ? LoginPage( ) : OnboardingScreen();
//         }
//         return Container();
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'example/lib/app.dart';
import 'example/lib/presentation/shared/app_colors.dart';
import 'example/lib/utils/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.appBackgroundColor,
      // navigation bar color
      statusBarColor: AppColors.primaryColor,
      // status bar color
      statusBarIconBrightness: Brightness.dark,
      // status bar icons' color
      systemNavigationBarIconBrightness: Brightness.dark, // bar icons' color
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const HandyApp());
}
