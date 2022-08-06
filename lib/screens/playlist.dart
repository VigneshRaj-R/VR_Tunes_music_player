import 'package:flutter/material.dart';
import 'package:music_player_app/screens/favourite_screen.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

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
                      builder: ((context) => const FavouriteScreen())));
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
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_outlined,
                color: Colors.white,
              ),
            )),
      ])),
    );
  }
}
