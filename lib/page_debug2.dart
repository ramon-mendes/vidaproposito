// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class PageDebug2 extends StatefulWidget {
  static const routeName = '/PageDebug2';

  @override
  State<PageDebug2> createState() => _PageDebug2State();
}

class _PageDebug2State extends State<PageDebug2> {
  final _audioPlayer = AudioPlayer();
  String _str1 = "none";
  String _str2 = "none";

  int _total = 0, _received = 0;
  late http.StreamedResponse _response;
  final List<int> _bytes = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;

      setState(() {
        _str1 = "Version: ${version}, build: ${buildNumber}";
      });

      _downloadAudio();
    });
  }

  Future<void> _downloadAudio() async {
    setState(() {
      _str2 = "Starting download";
    });

    await _audioPlayer.play(UrlSource(
        'https://storagemvc.blob.core.windows.net/vidacomproposito/1.mp3'));
    return;

    try {
      Response<List<int>> rs = await Dio().get(
          'https://storagemvc.blob.core.windows.net/vidacomproposito/1.mp3',
          onReceiveProgress: (count, total) {
        setState(() {
          _str2 = "Download: ${count}/${total}";
        });
      }, options: Options(responseType: ResponseType.bytes));

      await _audioPlayer.setSourceBytes(Uint8List.fromList(rs.data!));
      await _audioPlayer.resume();
    } catch (e) {
      setState(() {
        _str2 = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(_str1),
            Text(_str2),
          ],
        ),
      ),
    );
  }
}
