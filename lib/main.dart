import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player_app/core/provider/favoutrites_db.dart';
import 'package:music_player_app/core/model/playlist_model.dart';
import 'package:music_player_app/core/provider/playlist_addsong.dart';
import 'package:music_player_app/core/provider/provider_nowplaying.dart';
import 'package:music_player_app/core/provider/provider_permission.dart';
import 'package:music_player_app/core/provider/provider_playllist.dart';
import 'package:music_player_app/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';

String favouritesBox = "favourites_box";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(MusicModelAdapter().typeId)) {
    Hive.registerAdapter(MusicModelAdapter());
    await Hive.openBox<int>('favoriteDB');
    await Hive.openBox<MusicModel>('playlistDB');
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => PlaylistProvider())),
        ChangeNotifierProvider(create: ((context) => PermissionProvider())),
        ChangeNotifierProvider(create: ((context) => ProviderNowplaying())),
        ChangeNotifierProvider(create: ((context) => ProviderNowplaying())),
        ChangeNotifierProvider(create: ((context) => FavoriteDB())),
        ChangeNotifierProvider(create: ((context) => PlayListDb())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(
          fontFamily: 'Schyler',
          primaryColor: Colors.white,
        ),
      ),
    );
  }
}
