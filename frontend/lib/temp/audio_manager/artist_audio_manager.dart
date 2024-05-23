import 'package:just_audio/just_audio.dart';

class AudioManager {
  late AudioPlayer _audioPlayer;

  AudioManager() {
    _audioPlayer = AudioPlayer();
  }

  Future<void> play(String audioFilePath) async {
    try {
      await _audioPlayer.setUrl(audioFilePath);
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }

  Future<void> dispose() async {
    try {
      await _audioPlayer.dispose();
    } catch (e) {
      print('Error disposing audio player: $e');
    }
  }
}
