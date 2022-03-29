import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidaproposito/page_dayview.dart';
import 'package:vidaproposito/page_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uma vida com propósito',
      theme: ThemeData(
          fontFamily: 'outfit', textTheme: GoogleFonts.outfitTextTheme()),
      initialRoute: PageHome.routeName,
      debugShowCheckedModeBanner: false,
      routes: {
        PageHome.routeName: (BuildContext context) => PageHome(),
        PageDayView.routeName: (BuildContext context) => PageDayView(),
      },
    );
  }
}
