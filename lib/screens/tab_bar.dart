import 'package:flutter/material.dart';
import 'package:music_player_app/screens/albums_screen.dart';
import 'package:music_player_app/screens/folder_screen.dart';
import 'package:music_player_app/screens/playlist.dart';
import 'package:music_player_app/screens/song_page.dart';
import 'package:music_player_app/searchpage.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

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
        key: _key,
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 2, 0, 10),
          child: Column(
            children: [
              Image.asset('assets/image/beach-morning-minimal-art-4k-dp.jpg'),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.settings,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Settings',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.ac_unit_outlined,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'About',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => _key.currentState!.openDrawer(),
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Music Player',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    IconButton(
                        onPressed: (() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => StreamBuilder<Object>(
                                  stream: null,
                                  builder: (context, snapshot) {
                                    return  SearchScreen();
                                  }))));
                        }),
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.white,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                TabBar(
                    controller: tabController,
                    labelColor: Colors.yellow,
                    unselectedLabelColor: Colors.white,
                    isScrollable: false,
                    tabs: const [
                      Tab(
                        child: Text(
                          'SONGS',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'PLAYLIST',
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
                  child: TabBarView(controller: tabController, children: const [
                    SongsScreen(),
                    PlaylistScreen(),
                    FolderScreen(),
                    AlbumScreen(),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
