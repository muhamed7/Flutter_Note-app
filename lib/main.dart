import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/widget.dart';
import './screens/homepage.dart';
void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title:" Achievers hub",
        theme: ThemeData(
        primaryColor: Colors.white,)
        ,
      home: Homepage(),

    );


      /*MaterialApp(

      theme: ThemeData(
        textTheme: GoogleFonts.numansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),*/

  //  );
  }
}
