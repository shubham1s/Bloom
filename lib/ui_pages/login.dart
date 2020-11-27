// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:BLOOM_BETA/ui_pages/const.dart';
// import 'package:BLOOM_BETA/services/provider.dart';
// import 'package:auto_size_text/auto_size_text.dart';

// enum AuthFormType { signIn, signUp, reset, phone, anonymous, convert }

// class LoginPage extends StatefulWidget {
//   final AuthFormType authFormType;
//   LoginPage({Key key, @required this.authFormType}) : super(key: key);

//   @override
//   _LoginPageState createState() =>
//       _LoginPageState(authFormType: this.authFormType);
// }

// class _LoginPageState extends State<LoginPage> {
//   AuthFormType authFormType;
//   bool _rememberMe = false;
//   @override
//   void initState() {
//     super.initState();
//   }

//   _LoginPageState({this.authFormType});
//   final formKey = GlobalKey<FormState>();
//   String _email, _password, _name, _warning, _phone;
//   void switchFormState(String state) {
//     formKey.currentState.reset();
//     if (state == "signUp") {
//       setState(() {
//         authFormType = AuthFormType.signUp;
//       });
//     } else if (state == 'home') {
//       Navigator.of(context).pop();
//     } else {
//       setState(() {
//         authFormType = AuthFormType.signIn;
//       });
//     }
//   }

//   bool validate() {
//     final form = formKey.currentState;
//     if (authFormType == AuthFormType.anonymous) {
//       return true;
//     }
//     form.save();
//     if (form.validate()) {
//       form.save();
//       return true;
//     } else {
//       return false;
//     }
//   }

//   void submit() async {
//     if (validate()) {
//       try {
//         final auth = Provider.of(context).auth;
//         switch (authFormType) {
//           case AuthFormType.signIn:
//             await auth.signInWithEmailAndPassword(_email, _password);
//             Navigator.of(context).pushReplacementNamed('/');
//             break;
//           case AuthFormType.signUp:
//             await auth.createUserWithEmailAndPassword(_email, _password, _name);
//             Navigator.of(context).pushReplacementNamed('/home');
//             break;
//           case AuthFormType.reset:
//             await auth.sendPasswordResetEmail(_email);
//             setState(() {
//               _warning = "A password reset link has been sent to $_email";
//               authFormType = AuthFormType.signIn;
//             });
//             break;
//           case AuthFormType.anonymous:
//             await auth.singInAnonymously();
//             Navigator.of(context).pushReplacementNamed('/home');
//             break;
//           case AuthFormType.convert:
//             await auth.convertUserWithEmail(_email, _password, _name);
//             Navigator.of(context).pop();
//             break;
//           case AuthFormType.phone:
//             var result = await auth.createUserWithPhone(_phone, context);
//             if (_phone == "" || result == "error") {
//               setState(() {
//                 _warning = "Your phone number could not be validated";
//               });
//             }
//             break;
//         }
//       } catch (e) {
//         setState(() {
//           _warning = e.message;
//         });
//       }
//     }
//   }

//   AutoSizeText buildHeaderText() {
//     String _headerText;
//     if (authFormType == AuthFormType.signIn) {
//       _headerText = "Sign In";
//     } else if (authFormType == AuthFormType.reset) {
//       _headerText = "Reset Password";
//     } else if (authFormType == AuthFormType.phone) {
//       _headerText = "Phone Sign In";
//     } else {
//       _headerText = "Create New Account";
//     }
//     return AutoSizeText(
//       _headerText,
//       maxLines: 1,
//       textAlign: TextAlign.center,
//       style: TextStyle(
//         fontSize: 35,
//         color: Colors.white,
//       ),
//     );
//   }

//   Widget showAlert() {
//     if (_warning != null) {
//       return Container(
//         color: Colors.amberAccent,
//         width: double.infinity,
//         padding: EdgeInsets.all(8.0),
//         child: Row(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: Icon(Icons.error_outline),
//             ),
//             Expanded(
//               child: AutoSizeText(
//                 _warning,
//                 maxLines: 3,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: IconButton(
//                 icon: Icon(Icons.close),
//                 onPressed: () {
//                   setState(() {
//                     _warning = null;
//                   });
//                 },
//               ),
//             )
//           ],
//         ),
//       );
//     }
//     return SizedBox(
//       height: 0,
//     );
//   }

//   Widget _buildEmailTF() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Email',
//           style: kLabelStyle,
//         ),
//         SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             keyboardType: TextInputType.emailAddress,
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'OpenSans',
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.email,
//                 color: Colors.white,
//               ),
//               hintText: 'Enter your Email',
//               hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPasswordTF() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Password',
//           style: kLabelStyle,
//         ),
//         SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             obscureText: true,
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'OpenSans',
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.lock,
//                 color: Colors.white,
//               ),
//               hintText: 'Enter your Password',
//               hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildForgotPasswordBtn() {
//     return Container(
//       alignment: Alignment.centerRight,
//       child: FlatButton(
//         onPressed: () => print('Forgot Password Button Pressed'),
//         padding: EdgeInsets.only(right: 0.0),
//         child: Text(
//           'Forgot Password?',
//           style: kLabelStyle,
//         ),
//       ),
//     );
//   }

//   Widget _buildRememberMeCheckbox() {
//     return Container(
//       height: 20.0,
//       child: Row(
//         children: <Widget>[
//           Theme(
//             data: ThemeData(unselectedWidgetColor: Colors.white),
//             child: Checkbox(
//               value: _rememberMe,
//               checkColor: Colors.green,
//               activeColor: Colors.white,
//               onChanged: (value) {
//                 setState(() {
//                   _rememberMe = value;
//                 });
//               },
//             ),
//           ),
//           Text(
//             'Remember me',
//             style: kLabelStyle,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoginBtn() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 25.0),
//       width: double.infinity,
//       child: RaisedButton(
//         elevation: 5.0,
//         onPressed: () => print('Login Button Pressed'),
//         padding: EdgeInsets.all(15.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         color: Colors.white,
//         child: Text(
//           'LOGIN',
//           style: TextStyle(
//             color: Color(0xFF527DAA),
//             letterSpacing: 1.5,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'OpenSans',
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSignInWithText() {
//     return Column(
//       children: <Widget>[
//         Text(
//           '- OR -',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         SizedBox(height: 20.0),
//         Text(
//           'Sign in with',
//           style: kLabelStyle,
//         ),
//       ],
//     );
//   }

//   Widget _buildSocialBtn(Function onTap, AssetImage logo) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 60.0,
//         width: 60.0,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               offset: Offset(0, 2),
//               blurRadius: 6.0,
//             ),
//           ],
//           image: DecorationImage(
//             image: logo,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialBtnRow() {
//     final _auth = Provider.of(context).auth;
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 30.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           _buildSocialBtn(
//             () => print('Login with Facebook'),
//             AssetImage(
//               'assets/icons/facebook.jpg',
//             ),
//           ),
//           _buildSocialBtn(
//             () => print('Login with Google'),
//             AssetImage(
//               'assets/icons/google.jpg',
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSignupBtn() {
//     return GestureDetector(
//       onTap: () => Navigator.of(context).pushReplacementNamed('/signUp'),
//       child: RichText(
//         text: TextSpan(
//           children: [
//             TextSpan(
//               text: 'Don\'t have an Account? ',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             TextSpan(
//               text: 'Sign Up',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {

//     final _height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 height: double.infinity,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Color(0xFF0FCEF9),
//                       Color(0xFF0DF5F5),
//                       Color(0xFF0FCEF4),
//                       Color(0xFF0FCEF4),
//                     ],
//                     stops: [0.1, 0.4, 0.7, 0.9],
//                   ),
//                 ),
//               ),
//               Container(
//                 height: double.infinity,
//                 child: SingleChildScrollView(
//                   physics: AlwaysScrollableScrollPhysics(),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 40.0,
//                     vertical: 120.0,
//                   ),
//                   child: Column(

//                     mainAxisAlignment: MainAxisAlignment.center,

//                     children: <Widget>[
//                       SizedBox(height: _height * 0.025),
//                   showAlert(),
//                   SizedBox(height: _height * 0.025),
//                   buildHeaderText(),
//                   SizedBox(height: _height * 0.05),
//                       Text(
//                         'Sign In',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'OpenSans',
//                           fontSize: 30.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 30.0),
//                        Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Form(
//                       key: formKey,
//                       child: Column(
//                         children: ,

//                       ),
//                     ),
//                   ),
//                     ],

//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
