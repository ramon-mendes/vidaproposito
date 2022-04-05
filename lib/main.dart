import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidaproposito/page_dayview.dart';
import 'package:vidaproposito/page_debug.dart';
import 'package:vidaproposito/page_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final colorMap = {
    50: const Color.fromRGBO(4, 131, 184, .1),
    100: const Color.fromRGBO(4, 131, 184, .2),
    200: const Color.fromRGBO(4, 131, 184, .3),
    300: const Color.fromRGBO(4, 131, 184, .4),
    400: const Color.fromRGBO(4, 131, 184, .5),
    500: const Color.fromRGBO(4, 131, 184, .6),
    600: const Color.fromRGBO(4, 131, 184, .7),
    700: const Color.fromRGBO(4, 131, 184, .8),
    800: const Color.fromRGBO(4, 131, 184, .9),
    900: const Color.fromRGBO(4, 131, 184, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uma vida com propósito',
      theme: ThemeData(
          primarySwatch: MaterialColor(0xffAF762F, colorMap),
          fontFamily: 'outfit',
          textTheme: GoogleFonts.outfitTextTheme()),
      initialRoute: PageHome.routeName,
      debugShowCheckedModeBanner: false,
      routes: {
        PageHome.routeName: (BuildContext context) => PageHome(),
        PageDayView.routeName: (BuildContext context) => PageDayView(),
        PageDebug.routeName: (BuildContext context) => PageDebug(),
      },
    );
  }
}
