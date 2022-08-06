import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/screens/favourite_database.dart';
import 'package:music_player_app/screens/favourites_button.dart';
import 'package:music_player_app/screens/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class SongsScreen extends StatefulWidget {
  const SongsScreen({Key? key}) : super(key: key);
  static List<SongModel> songs = [];

  @override
  State<SongsScreen> createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  final _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  playSong(String? uri) {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioPlayer.play();
    } on Exception {
      log("Error parsing song!");
    }
  }

  @override
  Widget build(BuildContext context) {
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

                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (ctx, index) {
                        return ListTile(
                            onTap: (() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NowPlaying(
                                      songModel: item.data![index],
                                      songs: item.data!,
                                      index: index)));
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
                                //  const Icon(Icons.more_vert_rounded,
                                //     color: Colors.white),
                                FavoriteBut(song: item.data![index]));
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
