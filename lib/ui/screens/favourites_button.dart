import 'package:flutter/material.dart';
import 'package:music_player_app/core/provider/favoutrites_db.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../controller/favourite_database.dart';

class FavoriteBut extends StatelessWidget {
  const FavoriteBut({Key? key, required this.song}) : super(key: key);
  final SongModel song;

  Widget build(BuildContext context) {
    return Consumer<FavoriteDB>(builder: (context, value, child) {
      return IconButton(
        onPressed: () {
          if (FavoriteDB.isfavor(song)) {
            FavoriteDB.delete(song.id);
            // FavoriteDB.favoriteSongs.notifyListeners();
            value.notifyListeners();
            const snackBar = SnackBar(
                duration: Duration(milliseconds: 500),
                content: Text(
                  'Removed From Favorite',
                  style: TextStyle(color: Color.fromARGB(255, 247, 247, 247)),
                ));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            FavoriteDB.add(song);
            // FavoriteDB.favoriteSongs.notifyListeners();
            value.notifyListeners();
            const snackbar = SnackBar(
              duration: Duration(milliseconds: 500),
              backgroundColor: Colors.black,
              content: Text(
                'Song Added to Favorite',
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }

          // FavoriteDB.favoriteSongs.notifyListeners();
          value.notifyListeners();
        },
        icon: FavoriteDB.isfavor(song)
            ? const Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : const Icon(Icons.favorite_border,
                color: Color.fromARGB(255, 255, 255, 255)),
      );
    });
  }
}
