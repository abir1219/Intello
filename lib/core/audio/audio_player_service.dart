import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();

  factory AudioPlayerService() => _instance;

  AudioPlayerService._internal() {
    _player.onPlayerComplete.listen((event) {
      _isPlaying = false;
      _currentAudio = null;
    });
  }

  final AudioPlayer _player = AudioPlayer();

  String? _currentAudio;
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;
  String? get currentAudio => _currentAudio;

  Future<void> toggle(String audioPath) async {

    /// Case 1: Same item clicked while playing → STOP
    if (_isPlaying && _currentAudio == audioPath) {
      await stop();
      return;
    }

    /// Case 2: Another audio playing → STOP previous
    if (_isPlaying && _currentAudio != audioPath) {
      await _player.stop();
    }

    /// Case 3: Play selected audio
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