import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:music_player_app/ui/screens/playlist_screen.dart';
import 'package:music_player_app/ui/screens/albums_screen.dart';
import 'package:music_player_app/ui/screens/folder_screen.dart';
import 'package:music_player_app/ui/screens/song_page.dart';
import 'package:music_player_app/ui/screens/searchpage.dart';
import 'package:music_player_app/ui/widgets/common_color.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/drawer_widget.dart';

class TabBarPage extends StatelessWidget {
  TabBarPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: CommonColor(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Center(
              child: Text(
                'Music Player',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => StreamBuilder<Object>(
                            stream: null,
                            builder: (context, snapshot) {
                              return SearchScreen();
                            }))));
                  }),
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.white,
                  )),
            ],
          ),
          key: _key,
          drawer: const Drawer(
            child: DrawerWidget(),
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: Column(
                children: [
                  const TabBar(
                      labelColor: Colors.yellow,
                      unselectedLabelColor: Colors.white,
                      isScrollable: false,
                      tabs: [
                        Tab(
                          child: Text(
                            'SONGS',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'PLALIST',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'FOLDERS',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'ALBUMS',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                  Expanded(
                    child: TabBarView(children: [
                      SongsScreen(),
                      const PlaylistScreen(),
                      const FolderScreen(),
                      const AlbumScreen(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // )
  }
}

Future<void> mailToMe() async {
  String urls = 'mailto:vigneshraj.r007@gmail.com';
  final parseurl = Uri.parse(urls);
  try {
    if (!await launchUrl(parseurl)) {
      throw 'could not launch';
    }
  } catch (e) {
    log(e.toString());
  }
}
