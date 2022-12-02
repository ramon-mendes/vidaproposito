import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:vidaproposito/classes/consts.dart';
import 'package:vidaproposito/classes/prefs.dart';
import 'package:vidaproposito/widgets/audio_player.dart';

class PageDayView extends StatelessWidget {
  const PageDayView({Key? key}) : super(key: key);
  static const routeName = '/pagedayview';

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(builder: (context) => const DayWidget()),
    );
  }
}

class DayWidget extends StatefulWidget {
  const DayWidget({Key? key}) : super(key: key);

  @override
  State<DayWidget> createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {
  static bool _showcase_shown = false;
  bool _loaded = false;
  int _idx = 0;
  bool _readed = false;
  final Prefs _prefs = Prefs();
  GlobalKey _one = GlobalKey();

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
      if (!_showcase_shown) {
        _showcase_shown = true;
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => ShowCaseWidget.of(context).startShowCase([_one]));
      }
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

    String name = 'Dia ${_idx}';
    if (_idx == 0) {
      name = 'Introdução';
    }
    if (_idx == 41) {
      name = 'Dia 41 (bônus)';
    }
    if (_idx == 42) {
      name = 'Dia 42 (bônus)';
    }

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
                        name,
                        style: const TextStyle(fontSize: 34),
                      ),
                      Showcase(
                        key: _one,
                        description:
                            'Clique aqui para marcar esse dia como lido',
                        child: Switch(
                          activeColor: Theme.of(context).colorScheme.primary,
                          value: _readed,
                          onChanged: (value) {
                            _toggleReaded();
                          },
                        ),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AudioPlayer(
                  url: Consts.BASEURL + _idx.toString() + '.mp3',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
