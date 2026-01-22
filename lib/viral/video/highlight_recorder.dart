import 'dart:async';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';

class HighlightRecorder {
  static bool _recording = false;

  static bool get isRecording => _recording;

  /// Start screen recording (no audio, optimized for short clips)
  static Future<bool> start() async {
    if (_recording) return true;

    try {
      final ok = await FlutterScreenRecording.startRecordScreen(
        "tap_the_dot_highlight",
        titleNotification: "Recording highlight",
        messageNotification: "Tap The Dot is recording a short highlight",
      );
      _recording = ok;
      return ok;
    } catch (_) {
      return false;
    }
  }

  /// Stop recording and return path to video file
  static Future<String?> stop() async {
    if (!_recording) return null;

    try {
      final path = await FlutterScreenRecording.stopRecordScreen;
      _recording = false;
      return path;
    } catch (_) {
      _recording = false;
      return null;
    }
  }

  /// Safety stop (no return)
  static Future<void> forceStop() async {
    if (_recording) {
      try {
        await FlutterScreenRecording.stopRecordScreen;
      } catch (_) {}
      _recording = false;
    }
  }
}
