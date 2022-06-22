
import 'dart:async';
import 'dart:isolate';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class MyTaskHandler extends TaskHandler {
  int _seconds = 0;

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    sendPort;
    AudioCache audioCache = AudioCache(fixedPlayer: AudioPlayer());

    // You can use the getData function to get the stored data.
    final seconds = await FlutterForegroundTask.getData<int>(key: 'seconds');
    if(seconds is int){
      _seconds = seconds;

      Timer.periodic(const Duration(seconds: 1), (timer) async {
        if(_seconds < 1){
          //play the sound file here
          await audioCache.play("timer_song.mp3");
          timer.cancel();
          sendPort?.send("moveForward");

        } else {
          _seconds--;
          sendPort?.send("Remaining Time: $_seconds");
          FlutterForegroundTask.updateService(
              notificationTitle: 'On Going Timer',
              notificationText: 'eventCount: $_seconds'
          );
        }
      });
    }
    print('seconds: $seconds');
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {

  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {
    // You can use the clearAllData function to clear all the stored data.
    await FlutterForegroundTask.clearAllData();
  }

  @override
  void onNotificationPressed() {
    if(_seconds < 1){
      FlutterForegroundTask.stopService();
    }
  }
}