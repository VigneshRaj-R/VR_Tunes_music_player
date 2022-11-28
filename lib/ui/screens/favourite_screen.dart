import 'package:flutter/material.dart';

import 'package:music_player_app/controller/favourite_database.dart';
import 'package:music_player_app/core/provider/favoutrites_db.dart';
import 'package:music_player_app/ui/screens/nowplaying.dart';
import 'package:music_player_app/ui/widgets/songstorage.dart';
import 'package:music_player_app/ui/widgets/common_color.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

//  @override
//   Widget build(BuildContext context) {
//     return Consumer<FavoriteDB>(builder: (context, value, child) {
//       return IconButton(
//         onPressed: () {
//           if (value.isfavor(song)) {
//             value.delete(song.id);

//             Provider.of<FavoriteDB>(context, listen: false).notifyListeners();
//             const snackBar = SnackBar(
//               content: Text(
//                 'Removed From Favorite',
//                 style: TextStyle(color: Color.fromARGB(255, 247, 247, 247)),
//               ),
//               duration: Duration(milliseconds: 1500),
//             );
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           } else {
//             value.add(song);
//             Provider.of<FavoriteDB>(context, listen: false).notifyListeners();

//             const snackbar = SnackBar(
//               backgroundColor: Colors.black,
//               content: Text(
//                 'Song Added to Favorite',
//                 style: TextStyle(color: Colors.white),
//               ),
//               duration: Duration(milliseconds: 350),
//             );
//             ScaffoldMessenger.of(context).showSnackBar(snackbar);
//           }

//           Provider.of<FavoriteDB>(context, listen: false).notifyListeners();
//         },
//         icon: value.isfavor(song)
//             ? Icon(
//                 Icons.favorite,
//                 color: Colors.red[900],
//               )
//             : const Icon(
//                 Icons.favorite_border,
//                 color: Color.fromARGB(255, 255, 255, 255),
//               ),
//       );
//     });
//   }

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();

    return CommonColor(
      child: Consumer<FavoriteDB>(
        builder: (context, value, child) {
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
                child: FavoriteDB.favoriteSongs.isEmpty
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
                        Consumer<FavoriteDB>(
                          builder: (context, value, child) {
                            return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (ctx, index) {
                                  return ListTile(
                                    onTap: () {
                                      // FavoriteDB.favoriteSongs
                                      //     .notifyListeners();
                                      // List<SongModel> newlist = [
                                      FavoriteDB.favoriteSongs;
                                      //  ];

                                      // setState(() {});
                                      Songstorage.player.stop();
                                      Songstorage.player.setAudioSource(
                                          Songstorage.createSongList(
                                              FavoriteDB.favoriteSongs),
                                          initialIndex: index);
                                      Songstorage.player.play();
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (ctx) => NowPlaying(
                                                    songs: FavoriteDB
                                                        .favoriteSongs,
                                                  )));
                                    },
                                    leading: QueryArtworkWidget(
                                      id: FavoriteDB.favoriteSongs[index].id,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: const Icon(
                                        Icons.music_note_outlined,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                    title: Text(
                                      FavoriteDB.favoriteSongs[index].title,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 15),
                                    ),
                                    subtitle: Text(
                                      FavoriteDB.favoriteSongs[index].album!,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          // FavoriteDB.favoriteSongs.value
                                          //     .removeAt(index);
                                          // FavoriteDB.favoriteSongs
                                          //     .notifyListeners();
                                          value.notifyListeners();
                                          FavoriteDB.delete(FavoriteDB
                                              .favoriteSongs[index].id);
                                          const snackbar = SnackBar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              content: Text(
                                                'Song deleted from favorite',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              duration: Duration(seconds: 1));
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
                                itemCount: FavoriteDB.favoriteSongs.length);
                          },
                        ),
                      ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
