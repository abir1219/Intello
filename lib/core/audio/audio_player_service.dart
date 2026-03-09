/*
import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
*/

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();

  factory AudioPlayerService() => _instance;

  AudioPlayerService._internal();

  final AudioPlayer _player = AudioPlayer();

  String? _currentAudio;
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;
  String? get currentAudio => _currentAudio;

  Future<void> toggle(String audioPath) async {
    /// If same audio playing → stop
    if (_isPlaying && _currentAudio == audioPath) {
      await stop();
      return;
    }

    /// Stop previous audio
    await _player.stop();

    /// Play new audio
    await _player.play(AssetSource(audioPath));

    _currentAudio = audioPath;
    _isPlaying = true;
  }

  Future<void> stop() async {
    await _player.stop();
    _isPlaying = false;
    _currentAudio = null;
  }

  void dispose() {
    _player.dispose();
  }
}

/*class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();

  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  Future<void> playAsset(String assetPath) async {
    try {
      await _player.setAsset(assetPath);
      await _player.play();
      _isPlaying = true;
    } catch (e) {
      debugPrint("Audio play error: $e");
    }
  }

  Future<void> stop() async {
    await _player.stop();
    _isPlaying = false;
  }

  void dispose() {
    _player.dispose();
  }
}*/
