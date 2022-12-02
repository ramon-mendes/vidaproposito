// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as ap;

class AudioPlayer extends StatefulWidget {
  /// Path from where to play recorded audio
  final String url;

  const AudioPlayer({required this.url});

  @override
  AudioPlayerState createState() => AudioPlayerState();
}

class AudioPlayerState extends State<AudioPlayer> {
  static const double _controlSize = 56;

  final _audioPlayer = ap.AudioPlayer();
  StreamSubscription<ap.PlayerState>? _playerStateChangedSubscription;
  StreamSubscription<Duration?>? _durationChangedSubscription;
  StreamSubscription<Duration?>? _positionChangedSubscription;

  @override
  void initState() {
    super.initState();

    _playerStateChangedSubscription =
        _audioPlayer.playerStateStream.listen((state) async {
      if (state.processingState == ap.ProcessingState.completed) {
        await stop();
      }
      setState(() {});
    });

    _positionChangedSubscription =
        _audioPlayer.positionStream.listen((position) => setState(() {}));
    _durationChangedSubscription =
        _audioPlayer.durationStream.listen((duration) => setState(() {}));
    _audioPlayer.setUrl(widget.url);
  }

  @override
  void dispose() {
    _playerStateChangedSubscription!.cancel();
    _positionChangedSubscription!.cancel();
    _durationChangedSubscription!.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildControl(),
            _buildSlider(constraints.maxWidth),
          ],
        );
      },
    );
  }

  Widget _buildControl() {
    Icon icon;
    Color color;
    final theme = Theme.of(context);

    if (_audioPlayer.playerState.playing) {
      icon = Icon(Icons.pause, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    } else {
      icon = Icon(Icons.play_arrow, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child:
              SizedBox(width: _controlSize, height: _controlSize, child: icon),
          onTap: () async {
            if (_audioPlayer.playerState.playing) {
              await pause();
            } else {
              await play();
            }
          },
        ),
      ),
    );
  }

  Widget _buildSlider(double widgetWidth) {
    final position = _audioPlayer.position;
    final duration = _audioPlayer.duration;
    bool canSetValue = false;
    if (duration != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }

    double width = widgetWidth - _controlSize;

    return SizedBox(
      width: width,
      child: Slider(
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Color.fromARGB(255, 185, 185, 185),
        onChanged: (v) {
          if (duration != null) {
            final position = v * duration.inMilliseconds;
            _audioPlayer.seek(Duration(milliseconds: position.round()));
          }
        },
        value: canSetValue && duration != null
            ? position.inMilliseconds / duration.inMilliseconds
            : 0.0,
      ),
    );
  }

  Future<void> play() {
    return _audioPlayer.play();
  }

  Future<void> pause() {
    return _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    return _audioPlayer.seek(const Duration(milliseconds: 0));
  }
}
