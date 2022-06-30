import 'package:flutter/material.dart';
import 'package:music_player_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotohome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 39, 8, 212),
            Color.fromARGB(255, 39, 8, 212),
            Colors.white
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 70),
                  child: Text(
                    'VR tunes',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 100,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 1),
                    child: Text(
                      'Music Player',
                      style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Image(
                      image: AssetImage(
                          'assets/image/pngtree-3d-purple-head-mounted-eh-set-png-image_2187586-removebg-preview.png')),
                ),
                Text(
                  'Feel it....',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 62, 61, 61)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> gotohome() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => const HomeScreen()));
  }
}
