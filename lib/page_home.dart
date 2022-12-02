import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidaproposito/classes/prefs.dart';
import 'package:vidaproposito/page_dayview.dart';
import 'package:vidaproposito/page_debug2.dart';

class PageHome extends StatefulWidget {
  static const routeName = '/pagehome';

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  Map<String, dynamic>? _readedmap;
  final Prefs _prefs = Prefs();

  @override
  void initState() {
    super.initState();
    _reloadStatus();
  }

  _reloadStatus() async {
    _readedmap = await _prefs.completedMap();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_readedmap == null) return Container();
    int readcnt = _readedmap!.entries
        .where(
          (element) => element.value == true,
        )
        .length;

    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/concrete_seamless.jpg'),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(PageDebug2.routeName);
                  },
                  child: const Text(
                    'Uma Vida com Propósito',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Seu progresso: $readcnt/41',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: 43,
                    itemBuilder: (BuildContext context, int index) =>
                        _buildListItem(index),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(int index) {
    bool readed = false;

    if (_readedmap![index.toString()] == true) {
      readed = true;
    }

    String name = 'Dia ${index}';
    if (index == 0) {
      name = 'Introdução';
    }
    if (index == 41) {
      name = 'Dia 41 (bônus)';
    }
    if (index == 42) {
      name = 'Dia 42 (bônus)';
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, PageDayView.routeName,
              arguments: index);
          _reloadStatus();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color:
                readed ? Color(0xffAF762F) : Color.fromARGB(255, 206, 206, 206),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/cross.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      name,
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
