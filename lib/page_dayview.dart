import 'package:flutter/material.dart';
import 'package:vidaproposito/classes/consts.dart';
import 'package:vidaproposito/classes/prefs.dart';
import 'package:vidaproposito/widgets/audio_player.dart';

class PageDayView extends StatefulWidget {
  static const routeName = '/pagedayview';

  @override
  State<PageDayView> createState() => _PageDayViewState();
}

class _PageDayViewState extends State<PageDayView> {
  bool _loaded = false;
  int _idx = 0;
  bool _readed = false;
  final Prefs _prefs = Prefs();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    _idx = ModalRoute.of(context)!.settings.arguments as int;
    _readed = await _prefs.isCompleted(_idx);

    setState(() {
      _loaded = true;
    });
  }

  _toggleReaded() async {
    await _prefs.setCompleted(_idx, !_readed);

    setState(() {
      _readed = !_readed;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return Container();

    return SafeArea(
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/cross.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 14, 22, 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _idx == 0 ? 'Introdução' : ('Dia ' + _idx.toString()),
                        style: const TextStyle(fontSize: 34),
                      ),
                      Switch(
                        activeColor: Theme.of(context).colorScheme.primary,
                        value: _readed,
                        onChanged: (value) {
                          _toggleReaded();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/concrete_seamless.jpg'),
                  repeat: ImageRepeat.repeat,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: AudioPlayer(
                  url: Consts.BASEURL + '1.mp3',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
