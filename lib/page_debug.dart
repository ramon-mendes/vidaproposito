import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PageDebug extends StatefulWidget {
  static const routeName = '/pagedebug';

  @override
  State<PageDebug> createState() => _PageDebugState();
}

class _PageDebugState extends State<PageDebug> {
  final _audioPlayer = AudioPlayer();
  String _error = "none";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await _audioPlayer.setUrl(
            'https://storagemvc.blob.core.windows.net/vidacomproposito/1.mp3');
        await _audioPlayer.play();
      } on PlayerException catch (e) {
        _error = "Error code: ${e.code}, message: ${e.message}";
        setState(() {});
      } on PlayerInterruptedException catch (e) {
        _error = "Connection aborted: ${e.message}";
        setState(() {});
      } catch (e) {
        _error = "An error occured: $e";
        setState(() {});
      }

      // Catching errors during playback (e.g. lost network csonnection)
      _audioPlayer.playbackEventStream.listen(
        (event) {},
        onError: (Object e, StackTrace st) {
          if (e is PlayerException) {
            _error = "Error code: ${e.code}, message: ${e.message}";
            setState(() {});
          } else {
            _error = "An error occured: $e";
            setState(() {});
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Text(_error)));
  }
}
