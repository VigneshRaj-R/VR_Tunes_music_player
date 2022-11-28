import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player_app/controller/favourite_database.dart';
import 'package:music_player_app/core/provider/favoutrites_db.dart';
import 'package:music_player_app/core/model/playlist_model.dart';
import 'package:music_player_app/ui/screens/splash_screen.dart';

class PlaylistProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  List<MusicModel> musicListNotifier = [];

  Future<void> addPlaylist(MusicModel value) async {
    final playlistDB = Hive.box<MusicModel>('playlistDB');
    await playlistDB.add(value);
    getAllDetails();
    notifyListeners();
  }

  Future<void> getAllDetails() async {
    final playlistDB = Hive.box<MusicModel>('playlistDB');
    musicListNotifier.clear();
    musicListNotifier.addAll(playlistDB.values.toList());
    notifyListeners();
  }

  Future<void> deletePlaylist(int index) async {
    final playlistDB = Hive.box<MusicModel>('playlistDB');
    await playlistDB.deleteAt(index);
    getAllDetails();
    notifyListeners();
  }

  Future<void> appReset(context) async {
    final playlistDB = Hive.box<MusicModel>("playlistDB");
    final musiCDB = Hive.box<int>('favoriteDB');
    await playlistDB.clear();
    await musiCDB.clear();
    FavoriteDB.favoriteSongs.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SplashScreen()),
        (route) => false);
    notifyListeners();
  }

  Future<void> whenButtonClicked() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      return;
    } else {
      final music = MusicModel(name: name, songData: []);
      await addPlaylist(music);
    }
    nameController.clear();
    notifyListeners();
  }

  @override
  notifyListeners();
}
