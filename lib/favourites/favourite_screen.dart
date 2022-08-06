import 'package:flutter/material.dart';

import 'package:music_player_app/favourites/favourite_database.dart';
import 'package:music_player_app/screens/nowplaying.dart';
import 'package:music_player_app/screens/song_page.dart';
import 'package:music_player_app/songstorage.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 8, 0, 11),
              Color.fromARGB(255, 16, 3, 89),
              Color.fromARGB(255, 103, 24, 46)
            ]),
      ),
      child: ValueListenableBuilder(
          valueListenable: FavoriteDB.favoriteSongs,
          builder:
              (BuildContext ctx, List<SongModel> favorData, Widget? child) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: const Text(
                    'Favorites ',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  //centerTitle: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: FavoriteDB.favoriteSongs.value.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'No favorites yet!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ))
                      : ListView(children: [
                          ValueListenableBuilder(
                            valueListenable: FavoriteDB.favoriteSongs,
                            builder: (BuildContext ctx,
                                List<SongModel> favorData, Widget? child) {
                              return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (ctx, index) {
                                    return ListTile(
                                      onTap: () {
                                        // FavoriteDB.favoriteSongs
                                        //     .notifyListeners();
                                        List<SongModel> newlist = [
                                          ...favorData
                                        ];
                                        setState(() {});
                                        Songstorage.player.stop();
                                        Songstorage.player.setAudioSource(
                                            Songstorage.createSongList(newlist),
                                            initialIndex: index);
                                        Songstorage.player.play();
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (ctx) => NowPlaying(
                                                     
                                                      songs: newlist,
                                                    )));
                                      },
                                      leading: QueryArtworkWidget(
                                        id: favorData[index].id,
                                        type: ArtworkType.AUDIO,
                                        nullArtworkWidget: const Icon(
                                          Icons.music_note_outlined,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      ),
                                      title: Text(
                                        favorData[index].title,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 15),
                                      ),
                                      subtitle: Text(
                                        favorData[index].album!,
                                         maxLines: 1,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {
                                            // FavoriteDB.favoriteSongs.value
                                            //     .removeAt(index);
                                            FavoriteDB.favoriteSongs
                                                .notifyListeners();
                                            FavoriteDB.delete(
                                                favorData[index].id);
                                            setState(() {});
                                            const snackbar = SnackBar(
                                                backgroundColor: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                content: Text(
                                                  'Song deleted from favorite',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                duration: Duration(
                                                    microseconds: 190));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackbar);
                                          },
                                          icon: const Icon(
                                            Icons.heart_broken_sharp,
                                            color: Colors.white,
                                            size: 30,
                                          )),
                                    );
                                  },
                                  separatorBuilder: (ctx, index) {
                                    return const Divider();
                                  },
                                  itemCount: favorData.length);
                            },
                          ),
                        ]),
                ),
              ),
            );
          }),
    );
  }
}
