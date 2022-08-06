import 'package:flutter/material.dart';
import 'package:music_player_app/screens/nowplaying.dart';
import 'package:music_player_app/screens/song_page.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  ValueNotifier<List<SongModel>> temp = ValueNotifier([]);
  SearchScreen({Key? key}) : super(key: key);
  final controller10 = TextEditingController();

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
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: controller10,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.white30),
                    hintText: 'Search here',
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller10.clear();

                          temp.value.clear();
                          temp.notifyListeners();
                        },
                        icon: const Icon(Icons.clear)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    filled: true),
                onChanged: (String value) {
                  searchFilter(value);
                }),
          ),
        ),
        body: SingleChildScrollView(
          child: ValueListenableBuilder(
            valueListenable: temp,
            builder: (BuildContext context, List<SongModel> songdata,
                Widget? child) {
              return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: ((context, index) {
                    final data = songdata[index];
                    return ListTile(
                        leading: QueryArtworkWidget(
                            artworkWidth: 60,
                            artworkFit: BoxFit.cover,
                            id: data.id,
                            type: ArtworkType.AUDIO),
                        title: Text(
                          data.title,
                          style: const TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => NowPlaying(
                                    songs: SongsScreen.songs,
                                    songModel: data,
                                    index: index,
                                  )));
                        });
                  }),
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: temp.value.length);
            },
          ),
        ),
      ),
    );
  }

  searchFilter(String value) {
    if (value.isEmpty) {
      temp.value = SongsScreen.songs;
    } else {
      temp.value = SongsScreen.songs
          .where((song) =>
              song.title.toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    }
    temp.notifyListeners();
  }
}
