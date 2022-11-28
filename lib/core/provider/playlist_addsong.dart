import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../ui/screens/splash_screen.dart';


//playlist songs created
class PlayListDb extends ChangeNotifier {
  List<SongModel> playlistnotifier = [];

  Future<void> playlistAdd(SongModel value) async {
    final playListDb = Hive.box<SongModel>('playlistDB');
    await playListDb.add(value);
    getAllPlaylist();
    notifyListeners();
  }

  Future<void> getAllPlaylist() async {
    final playListDb = Hive.box<SongModel>('playlistDB');

    playlistnotifier.clear();
    playlistnotifier.addAll(playListDb.values);

    notifyListeners();
  }

  Future<void> playlistDelete(int index) async {
    final playListDb = Hive.box<SongModel>('playlistDB');

    await playListDb.deleteAt(index);
    getAllPlaylist();
    notifyListeners();
  }

  Future<void> appReset(context) async {
    final playListDb = Hive.box<SongModel>('playlistDB');
    final musicDb = Hive.box<int>('favoriteDB');
    await musicDb.clear();
    await playListDb.clear();
    musicDb.clear();
    notifyListeners();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
        (route) => false);
  }

  notifyListeners();
}
