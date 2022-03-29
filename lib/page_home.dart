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
  List<int>? _readed;

  @override
  void initState() {
    super.initState();
    _reloadStatus();
  }

  _reloadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      var list = prefs.getStringList('readed');
      list ??= [];
      _readed = list.map((e) => int.parse(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_readed == null) return Container();

    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/concrete_seamless.jpg'),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Uma vida com propósito',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Seu progresso: 1/41',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
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
            color: _readed!.contains(index)
                ? const Color(0xffAF762F)
                : const Color.fromARGB(255, 206, 206, 206),
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
                      index == 0 ? 'Introdução' : 'Dia ${index + 1}',
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
