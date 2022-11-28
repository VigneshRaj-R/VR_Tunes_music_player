import 'package:flutter/material.dart';
import 'package:music_player_app/core/model/playlist_model.dart';
import 'package:music_player_app/core/provider/playlist_addsong.dart';
import 'package:music_player_app/ui/widgets/common_color.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../core/provider/provider_playllist.dart';

class PlaylistSongSelection extends StatelessWidget {
  PlaylistSongSelection({Key? key, required this.playlist}) : super(key: key);

  final MusicModel playlist;
  final audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    final provideraddsong = Provider.of<PlayListDb>(context, listen: false);
    return Consumer<PlaylistProvider>(
        builder: (context, value, child) => CommonColor(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text(
                    'All Songs',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(children: [
                    const Center(
                      child: Text(
                        'Add Songs ',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 190,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          provideraddsong;
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Color.fromARGB(255, 250, 248, 248),
                          size: 20,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    FutureBuilder<List<SongModel>>(
                        future: audioQuery.querySongs(
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
                            return const Center(
                              child: Text(
                                'NO Songs Found',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 247, 245, 245)),
                              ),
                            );
                          }
                          return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (ctx, index) {
                                return ListTile(
                                    onTap: () {},
                                    iconColor: Colors.white,
                                    textColor: Colors.white,
                                    leading: QueryArtworkWidget(
                                      id: item.data![index].id,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget:
                                          const Icon(Icons.music_note_outlined),
                                      artworkFit: BoxFit.fill,
                                      artworkBorder: const BorderRadius.all(
                                          Radius.circular(30)),
                                    ),
                                    title: Text(
                                        item.data![index].displayNameWOExt),
                                    subtitle:
                                        Text("${item.data![index].artist}"),
                                    trailing: Consumer<PlayListDb>(
                                      builder: (context, value, child) =>
                                          IconButton(
                                              onPressed: () {
                                                playlistCheck(
                                                    item.data![index], context);
                                                provideraddsong;
                                              },
                                              icon: const Icon(Icons.add)),
                                    )
                                    // Consumer<PlaylistProvider>(
                                    //   builder: (context, value, child) => ,
                                    //    IconButton(
                                    //       onPressed: () {
                                    //         playlistCheck(
                                    //             item.data![index], context);
                                    //         provideraddsong;

                                    //       },
                                    //       icon: const Icon(Icons.add)),
                                    // ),
                                    );
                              },
                              separatorBuilder: (ctx, index) {
                                return const Divider();
                              },
                              itemCount: item.data!.length);
                        })
                  ]),
                ),
              ),
            ));
  }

  void playlistCheck(SongModel data, BuildContext context) {
    if (!playlist.isValueIn(data.id)) {
      playlist.add(data.id);
      const snackbar = SnackBar(
          backgroundColor: Colors.yellowAccent,
          content: Text(
            'Added to Playlist',
            style: TextStyle(color: Colors.black),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
