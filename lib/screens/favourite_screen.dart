import 'package:flutter/material.dart';
import 'package:music_player_app/screens/favourite_database.dart';
import 'package:music_player_app/screens/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 8, 0, 11),
            Color.fromARGB(255, 16, 3, 89),
            Color.fromARGB(255, 103, 24, 46)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Favourites'),
        ),
        body: ValueListenableBuilder(
            valueListenable: FavoriteDB.favoriteSongs,
            builder: (context, List<SongModel> favlist, child) =>
                ListView.builder(
                    itemCount: FavoriteDB.favoriteSongs.value.length,
                    itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NowPlaying(
                                        songModel: favlist[index],
                                        songs: const [],
                                        index: index)));
                          },
                          leading: QueryArtworkWidget(
                            id: favlist[index].id,
                            type: ArtworkType.AUDIO,
                          ),
                          title: Text(favlist[index].title,
                              maxLines: 1,
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Text(
                            favlist[index].title,
                            maxLines: 1,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                FavoriteDB.favoriteSongs.notifyListeners();
                                FavoriteDB.delete(favlist[index].id);
                              },
                              icon: const Icon(
                                Icons.favorite_outlined,
                                color: Colors.white,
                              )),
                        ))),
      ),
    );
  }
}
