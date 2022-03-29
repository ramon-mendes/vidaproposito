import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidaproposito/page_dayview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageHome extends StatefulWidget {
  static const routeName = '/pagehome';

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Column(
            children: [
              const Text('Uma vida com propósito'),
              Expanded(
                child: ListView.builder(
                  itemCount: 40,
                  itemBuilder: (BuildContext context, int index) =>
                      _buildListItem(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, PageDayView.routeName,
              arguments: index);
          //_reloadData();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: const Color(0xffAF762F),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/cross.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      'Dia $index',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        // ignore: prefer_const_constructors
                        textStyle: const TextStyle(
                            color: Color(0xffDBE1F7),
                            fontSize: 30,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
