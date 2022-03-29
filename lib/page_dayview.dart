import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PageDayView extends StatefulWidget {
  static const routeName = '/pagedayview';

  @override
  State<PageDayView> createState() => _PageDayViewState();
}

class _PageDayViewState extends State<PageDayView> {
  YoutubePlayerController? _controller;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final idx = ModalRoute.of(context)!.settings.arguments as int;

    _controller = YoutubePlayerController(
      initialVideoId: 'IrhzOATA-Gk',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

    setState(() {
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return Container();

    return SafeArea(
      child: Material(
        child: Column(
          children: [
            Text('Dia1'),
            Container(
              child: YoutubePlayer(
                controller: _controller!,
                showVideoProgressIndicator: true,
                progressColors: ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  _controller!.addListener(() {});
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Marcar como lido'),
            )
          ],
        ),
      ),
    );
  }
}
