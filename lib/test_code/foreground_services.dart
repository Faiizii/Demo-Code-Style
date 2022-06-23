
import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:audio_manager/audio_manager.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class MyTaskHandler extends TaskHandler {
  int _seconds = 0;

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    sendPort;
    // AudioPlayer player = AudioPlayer();

    // You can use the getData function to get the stored data.
    final seconds = await FlutterForegroundTask.getData<int>(key: 'seconds');
    if(seconds is int){
      _seconds = seconds;

      Timer.periodic(const Duration(seconds: 1), (timer) async {
        if(_seconds < 1){
          // //play the sound file here
          // // await player.play(AssetSource('timer_song.mp3'));
          // AudioManager.instance.start(
          //     "assets/timer_song.mp3",
          //     // "network format resource"
          //     // "local resource (file://${file.path})"
          //     "title",
          //     desc: "desc",
          //     // cover: "network cover image resource"
          //     cover: "assets/ic_launcher.png",
          // ).then((err) {print(err);});
          // AudioManager.instance.playOrPause();
          // AudioManager.instance.onEvents((AudioManagerEvents events, args) {
          //   if(events == AudioManagerEvents.ended){
          //     AudioManager.instance.stop();
          //     AudioManager.instance.release();
          //   }
          // });
          timer.cancel();
          sendPort?.send("moveForward");
          // player.setReleaseMode(ReleaseMode.release);
          // player.release();
        } else {
          _seconds--;
          print("seconds $_seconds");
          sendPort?.send("Remaining Time: $_seconds");
          if(!Platform.isIOS) {
            //on iOS it is not working as expecting
            FlutterForegroundTask.updateService(
                notificationTitle: 'On Going Timer',
                notificationText: 'eventCount: $_seconds'
            );
          }
        }
      });
    }
    print('seconds: $seconds');
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    print("test");
  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {
    // You can use the clearAllData function to clear all the stored data.
    print("on destroy called");
    await FlutterForegroundTask.clearAllData();
  }

  @override
  void onNotificationPressed() {
    if(_seconds < 1){
      FlutterForegroundTask.stopService();
    }
  }
}