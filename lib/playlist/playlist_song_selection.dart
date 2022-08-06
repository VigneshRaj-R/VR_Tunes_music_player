import 'package:flutter/material.dart';
import 'package:music_player_app/playlist/playlist_functions.dart';
import 'package:music_player_app/playlist/playlist_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistSongSelection extends StatefulWidget {
  const PlaylistSongSelection({Key? key, required this.playlist})
      : super(key: key);

  final MusicModel playlist;
  @override
  State<PlaylistSongSelection> createState() => _PlaylistSongSelectionState();
}

final _audioQuery = OnAudioQuery();

class _PlaylistSongSelectionState extends State<PlaylistSongSelection> {
  final OnAudioQuery audioQuery = OnAudioQuery();
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
                    setState(() {});
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
                              artworkBorder:
                                  const BorderRadius.all(Radius.circular(30)),
                            ),
                            title: Text(item.data![index].displayNameWOExt),
                            subtitle: Text("${item.data![index].artist}"),
                            trailing: IconButton(
                                onPressed: () {
                                  playlistCheck(item.data![index]);
                                  musicListNotifier.notifyListeners();
                                },
                                icon: const Icon(Icons.add)),
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider();
                        },
                        itemCount: item.data!.length);
                  })
            ]),
          ),
        ));
  }

  void playlistCheck(SongModel data) {
    if (!widget.playlist.isValueIn(data.id)) {
      widget.playlist.add(data.id);
      const snackbar = SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'Added to Playlist',
            style: TextStyle(color: Colors.white),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
