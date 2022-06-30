
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.segment,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text(
                        'Music Player',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'SONGS',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.yellow,
                        ),
                      ),
                      Text(
                        'PLAYLIST',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        'FOLDERS',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        'ALBUMS',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
