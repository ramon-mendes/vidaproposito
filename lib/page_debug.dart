import 'package:flutter/material.dart';
import 'package:vidaproposito/widgets/audio_player.dart';

class PageDebug extends StatefulWidget {
  static const routeName = '/pagedebug';

  @override
  State<PageDebug> createState() => _PageDebugState();
}

class _PageDebugState extends State<PageDebug> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        child: const AudioPlayer(
            url:
                'https://storagemvc.blob.core.windows.net/vidacomproposito/1.mp3'),
      ),
    );
  }
}
