import 'package:flutter/material.dart';
import 'package:music_player_app/ui/screens/tab_bar.dart';
import 'package:music_player_app/ui/widgets/common_color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      gotohome(context);
    });
    return CommonColor(
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
                      color: Color.fromARGB(255, 6, 240, 240)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> gotohome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => TabBarPage()));
  }
}
