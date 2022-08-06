import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player_app/favourites/favourite_screen.dart';
import 'package:music_player_app/playlist/playlist_model.dart';
import 'package:music_player_app/playlist/playlist_functions.dart';
import 'package:music_player_app/playlist/playlist_inside.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

final nameController = TextEditingController();

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Playlists ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Playlist Name"),
                        content: TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                        actions: [
                          TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          TextButton(
                              child: const Text('Save'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                whenButtonClicked();
                                nameController.clear();
                              })
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const FavoriteScreen())));
              },
              leading: const Icon(
                Icons.favorite_outline_outlined,
                color: Colors.white,
              ),
              title: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Favourites',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const FavoriteScreen())));
                },
                icon: const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.transparent,
                ),
              )),
          ValueListenableBuilder(
              valueListenable: Hive.box<MusicModel>('playlistDB').listenable(),
              builder: (BuildContext context, Box<MusicModel> playlistDb,
                  Widget? child) {
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, index) {
                      final data = playlistDb.values.toList()[index];
                      return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => OnPlayllsit(
                                          playlistname: data,
                                          folderindex: index,
                                        ))));
                          },
                          leading: const Icon(
                            Icons.library_music,
                            color: Colors.white,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data.name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        "Are you sure you want to delete the playlist"),
                                    actions: [
                                      TextButton(
                                          child: const Text('NO'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }),
                                      TextButton(
                                          child: const Text('YES'),
                                          onPressed: () {
                                            deletePlaylist(index);
                                            Navigator.of(context).pop();
                                          })
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ));
                    },
                    separatorBuilder: (ctx, index) {
                      return const Divider();
                    },
                    itemCount: playlistDb.length);
              }),
        ])));
  }
}

Future<void> whenButtonClicked() async {
  final name = nameController.text.trim();
  if (name.isEmpty) {
    return;
  } else {
    final music = MusicModel(name: name, songData: []);
    addPlaylist(music);
  }
}
