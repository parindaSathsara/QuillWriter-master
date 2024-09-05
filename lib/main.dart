import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quilwriterfinal/View/login.dart';
import 'package:quilwriterfinal/View/mainscreen.dart';
import 'package:quilwriterfinal/View/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(quilwriterfinal());
}

class quilwriterfinal extends StatefulWidget {
  @override
  State<quilwriterfinal> createState() => _quilwriterfinalState();
}

class _quilwriterfinalState extends State<quilwriterfinal> {
  StreamSubscription<User> user;

  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen(
      (user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      },
    );
  }
  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quill Writer',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Color(0XFFf9f6f2),
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: PageTransitionsTheme(builders: const {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
      ),

      initialRoute:
      FirebaseAuth.instance.currentUser == null ? LoginPage.id: MainBookScreen.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        MainBookScreen.id: (context) => MainBookScreen(),
        SplashScreen.id: (context) => SplashScreen(),
      },
      home: SplashScreen(),
    );
  }
}
