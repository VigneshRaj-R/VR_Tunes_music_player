import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player_app/favourites/favourite_database.dart';
import 'package:music_player_app/playlist/playlist_model.dart';
import 'package:music_player_app/screens/splash_screen.dart';

ValueNotifier<List<MusicModel>> musicListNotifier = ValueNotifier([]);

Future<void> addPlaylist(MusicModel value) async {
  final playlistDB = Hive.box<MusicModel>('playlistDB');
  await playlistDB.add(value);
}

Future<void> getAllDetails() async {
  final playlistDB = Hive.box<MusicModel>('playlistDB');
  musicListNotifier.value.clear();

  musicListNotifier.value.addAll(playlistDB.values);
  musicListNotifier.notifyListeners();
}

Future<void> deletePlaylist(int index) async {
  final playlistDB = Hive.box<MusicModel>('playlistDB');
  await playlistDB.deleteAt(index);
  getAllDetails();
}

Future<void> appReset(context) async {
  final playlistDB = Hive.box<MusicModel>("playlistDB");
  final MusiCDB = Hive.box<int>('favoriteDB');
  await playlistDB.clear();
  await MusiCDB.clear();
  FavoriteDB.favoriteSongs.value.clear();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => SplashScreen()),
      (route) => false);
}
