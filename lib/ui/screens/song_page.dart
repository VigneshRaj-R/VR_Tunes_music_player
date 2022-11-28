import 'package:flutter/material.dart';
import 'package:music_player_app/controller/favourite_database.dart';
import 'package:music_player_app/core/provider/favoutrites_db.dart';
import 'package:music_player_app/core/provider/provider_permission.dart';
import 'package:music_player_app/ui/screens/favourites_button.dart';
import 'package:music_player_app/ui/screens/nowplaying.dart';
import 'package:music_player_app/ui/widgets/songstorage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SongsScreen extends StatelessWidget {
  SongsScreen({Key? key}) : super(key: key);
  static List<SongModel> songs = [];

  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PermissionProvider>(context, listen: false)
          .requestPermission();
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<SongModel>>(
                future: _audioQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true),
                builder: (context, item) {
                  if (item.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (item.data!.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 250),
                      child: Column(
                        children: const [
                          Center(
                            child: Text(
                              "No songs found!",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  SongsScreen.songs = item.data!;
                  if (!FavoriteDB.isInitialized) {
                    FavoriteDB.initialise(item.data!);
                  }
                  Songstorage.songCopy = item.data!;

                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (ctx, index) {
                        return ListTile(
                            onTap: (() {
                              Songstorage.player.setAudioSource(
                                  Songstorage.createSongList(item.data!),
                                  initialIndex: index);
                              Songstorage.player.play();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NowPlaying(
                                        songs: item.data!,
                                      )));
                            }),
                            leading: const Icon(
                              Icons.music_note,
                              color: Color.fromARGB(255, 255, 254, 253),
                            ),
                            title: Text(
                              item.data![index].displayNameWOExt,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 254, 253),
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "${item.data![index].artist}",
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 4, 211, 230),
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing:
                                FavoriteBut(song: SongsScreen.songs[index]));
                      },
                      separatorBuilder: (ctx, index) {
                        return const Divider();
                      },
                      itemCount: item.data!.length);
                }),
          ],
        ),
      ),
    );
  }
}
