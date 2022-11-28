import 'package:flutter/material.dart';
import 'package:music_player_app/core/provider/provider_playllist.dart';
import 'package:music_player_app/ui/screens/favourite_screen.dart';
import 'package:music_player_app/ui/screens/playlist_inside.dart';
import 'package:provider/provider.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<PlaylistProvider>(context, listen: false).getAllDetails();
    return Consumer<PlaylistProvider>(
        builder: (context, value, _) => Scaffold(
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
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Playlist Name"),
                            content: TextField(
                              controller: Provider.of<PlaylistProvider>(context,
                                      listen: false)
                                  .nameController,
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
                                    Provider.of<PlaylistProvider>(context,
                                            listen: false)
                                        .whenButtonClicked();
                                    Navigator.of(context).pop();
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
              ),
              Consumer<PlaylistProvider>(builder: (context, value, _) {
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      final data = value.musicListNotifier[index];
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
                                            context
                                                .read<PlaylistProvider>()
                                                .deletePlaylist(index);
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
                    itemCount: value.musicListNotifier.length);
              }),
            ]))));
  }
}
