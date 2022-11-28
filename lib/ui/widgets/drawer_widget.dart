import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../screens/tab_bar.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[900],
        child: CustomScrollView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              elevation: 0,
              stretch: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              flexibleSpace: FlexibleSpaceBar(
                title: RichText(
                  text: const TextSpan(
                    text: 'VR Tunes',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'v0.0.1',
                        style: TextStyle(
                            fontSize: 7.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.end,
                ),
                titlePadding: const EdgeInsets.only(bottom: 40),
                centerTitle: true,
                background: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.1),
                      ],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ListTile(
                    title: const Text('Home'),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading: const Icon(Icons.home_rounded),
                    selected: true,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('About App',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading:
                        const Icon(Icons.info_rounded, color: Colors.white),
                    onTap: () {
                      showAboutDialog(
                          context: context,
                          applicationName: 'VR Tunes Music Player',
                          applicationVersion: '0.0.1',
                          applicationIcon: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/image/Logo.png'),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.circle,
                              )),
                          applicationLegalese:
                              '© 2020-2021 All rights reserved.',
                          children: [
                            const Text(' Beats is a music player app '
                                'that plays music from your device.'),
                            const Text(
                              'This app is made with ❤️ by Vignesh',
                            ),
                          ]);
                    },
                  ),
                  ListTile(
                    title: const Text('Share App',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading:
                        const Icon(Icons.share_rounded, color: Colors.white),
                    onTap: () {
                      Share.share(
                          'https://play.google.com/store/apps/details?id=com.fouvty.beats');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Feedback',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading:
                        const Icon(Icons.feedback_rounded, color: Colors.white),
                    onTap: () {
                      mailToMe();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Reset App',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading:
                        const Icon(Icons.restore_rounded, color: Colors.white),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Reset App"),
                              content: const Text(
                                  "Are you sure wnat to reset the app?"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("cancel")),
                                ElevatedButton(
                                    onPressed: () {
                                     //  appReset(context);
                                    },
                                    child: const Text("Reset"))
                              ],
                            );
                          });
                    },
                  ),
                  ListTile(
                    title: const Text('About Developer',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading: const Icon(Icons.person, color: Colors.white),
                    onTap: () {
                      showAboutDialog(
                          context: context,
                          applicationName: 'VR Tunes music player',
                          applicationVersion: 'v0.0.1',
                          applicationIcon: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/image/Logo.png'),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.circle,
                              )),
                          applicationLegalese:
                              'VR Tunes is a local musical player which enables you to listen songs in your device for free. Enjoy your music.');
                    },
                  ),
                  ListTile(
                    title: const Text('Rate this App',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading: const Icon(Icons.star_border_outlined,
                        color: Colors.white),
                    onTap: () {
                      // ratingApp();
                    },
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 30, 5, 20),
                    child: Center(
                      child: Column(
                        children: const [
                          Text(
                            'made with ❤️ by Vignesh',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          Text(
                            '0.0.1',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}