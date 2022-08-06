import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player_app/playlist/playlist_model.dart';
import 'package:music_player_app/screens/splash_screen.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
        fontFamily: 'Schyler',
        primaryColor: Colors.white,
      ),
    );
  }
}
