import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player_app/core/provider/provider_playllist.dart';
import 'package:music_player_app/ui/screens/favourites_button.dart';
import 'package:music_player_app/core/model/playlist_model.dart';
import 'package:music_player_app/ui/screens/playlist_song_selection.dart';
import 'package:music_player_app/ui/screens/nowplaying.dart';
import 'package:music_player_app/ui/screens/song_page.dart';
import 'package:music_player_app/ui/widgets/songstorage.dart';
import 'package:music_player_app/ui/widgets/common_color.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class OnPlayllsit extends StatelessWidget {
  const OnPlayllsit(
      {Key? key, required this.playlistname, required this.folderindex})
      : super(key: key);

  final MusicModel playlistname;
  final int folderindex;

  @override
  Widget build(BuildContext context) {
    //context.read<PlaylistProvider>().getAllDetails();

    return Consumer<PlaylistProvider>(
      builder: (context, value, child) => CommonColor(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(playlistname.name),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: SafeArea(
                  child: Column(
                children: [
                  Text(playlistname.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => PlaylistSongSelection(
                                  playlist: playlistname,
                                )));
                      },
                      child: const Text('Add Songs')),
                  ValueListenableBuilder(
                    valueListenable:
                        Hive.box<MusicModel>('playlistDB').listenable(),
                    builder: (BuildContext context, Box<MusicModel> value,
                        Widget? child) {
                      final playlistsong = listPlaylist(
                          value.values.toList()[folderindex].songData);
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (ctx, index) {
                            return ListTile(
                                onTap: () {
                                  List<SongModel> newlist = [...playlistsong];
                                  Songstorage.player.stop();
                                  Songstorage.player.setAudioSource(
                                      Songstorage.createSongList(newlist),
                                      initialIndex: index);
                                  Songstorage.player.play();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => NowPlaying(
                                            songs: playlistsong,
                                          )));
                                },
                                leading: QueryArtworkWidget(
                                  id: playlistsong[index].id,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: const Icon(
                                    Icons.music_note,
                                    color: Colors.white,
                                  ),
                                  errorBuilder: (context, excepion, gdb) {
                                    return Image.asset('');
                                  },
                                ),
                                title: Text(
                                  playlistsong[index].title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                                subtitle: Text(
                                  playlistsong[index].artist!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 100, 182, 13)),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (builder) {
                                            return Container(
                                              decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 99, 6, 133),
                                                      Color.fromARGB(255, 0, 0, 0)
                                                    ],
                                                    stops: [0.5, 1],
                                                  ),
                                                  borderRadius: BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(25.0),
                                                      topRight:
                                                          Radius.circular(25.0))),
                                              child: SizedBox(
                                                height: 350,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      height: 150,
                                                      width: 150,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: Colors
                                                                  .transparent),
                                                      child: QueryArtworkWidget(
                                                          artworkBorder:
                                                              BorderRadius
                                                                  .circular(1),
                                                          artworkWidth: 100,
                                                          artworkHeight: 400,
                                                          nullArtworkWidget:
                                                              const Icon(
                                                            Icons.music_note,
                                                            size: 100,
                                                          ),
                                                          id: playlistsong[index]
                                                              .id,
                                                          type:
                                                              ArtworkType.AUDIO),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        playlistsong[index].title,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ElevatedButton.icon(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white),
                                                              onPressed: () {
                                                                playlistname.deleteData(
                                                                    playlistsong[
                                                                            index]
                                                                        .id);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .delete_outline_outlined,
                                                                size: 25,
                                                              ),
                                                              label: const Text(
                                                                'Remove Song',
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20,
                                                                ),
                                                              )),
                                                          Row(
                                                            children: [
                                                              FavoriteBut(
                                                                song:
                                                                    playlistsong[
                                                                        index],
                                                              ),
                                                              const Text(
                                                                'Add to Favorite',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: 20),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.more_vert_sharp,
                                      color: Colors.white,
                                    )));
                          },
                          separatorBuilder: (ctx, index) {
                            return const Divider();
                          },
                          itemCount: playlistsong.length);
                    },
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }

  List<SongModel> listPlaylist(List<int> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < Songstorage.songCopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (SongsScreen.songs[i].id == data[j]) {
          plsongs.add(Songstorage.songCopy[i]);
        }
      }
    }
    return plsongs;
  }
}
