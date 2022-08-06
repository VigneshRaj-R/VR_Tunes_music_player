import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/screens/favourites_button.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying extends StatefulWidget {
  NowPlaying(
      {Key? key,
      required this.songModel,
      required this.songs,
      required this.index})
      : super(key: key);

  final SongModel songModel;
  final List<SongModel> songs;

  int index;

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

AudioPlayer _audioPlayer = AudioPlayer();

bool _isPlaying = false;
int currentindex = 0;

class _NowPlayingState extends State<NowPlaying> {
  Duration _duration = const Duration();
  Duration _position = const Duration();

  @override
  void initState() {
    super.initState();
    playSong();
  }

  void playSong() {
    try {
      _audioPlayer
          .setAudioSource(AudioSource.uri(Uri.parse(widget.songModel.uri!)));
      _audioPlayer.play();
      _isPlaying = true;
    } on Exception {
      log("File not supported.");
    }
    _audioPlayer.durationStream.listen((d) {
      setState(() {
        _duration = d!;
      });
    });
    _audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 24, 101, 164),
            Color.fromARGB(255, 19, 183, 93),
            Color.fromRGBO(197, 210, 11, 1)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon:
                              const Icon(Icons.arrow_drop_down_circle_outlined),
                          color: Colors.white,
                        ),
                        FavoriteBut(song: widget.songModel)
                      ],
                    ),
                    Container(
                      height: 100,
                    ),
                    SizedBox(
                      height: 200,
                      width: 300,
                      child: QueryArtworkWidget(
                          keepOldArtwork: true,
                          artworkWidth: 200,
                          artworkHeight: 200,
                          nullArtworkWidget: const Icon(
                            Icons.image_not_supported_rounded,
                            size: 100,
                          ),
                          id: widget.songModel.id,
                          type: ArtworkType.AUDIO),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text(
                          widget.songModel.displayNameWOExt,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        widget.songModel.artist.toString() == '<unknown>'
                            ? 'Unknown Artist'
                            : widget.songModel.artist.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Container(
                      height: 120.0,
                    ),
                    Row(
                      children: [
                        Text(_position.toString().split(".")[0]),
                        Expanded(
                          child: Slider(
                              min: const Duration(microseconds: 0)
                                  .inSeconds
                                  .toDouble(),
                              value: _position.inSeconds.toDouble(),
                              max: _duration.inSeconds.toDouble(),
                              onChanged: (value) {
                                changeToSeconds(value.toInt());
                                value = value;
                              }),
                        ),
                        Text(_duration.toString().split(".")[0]),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_audioPlayer.hasPrevious) {
                              _audioPlayer.seekToPrevious();
                            } else {
                              playSong();
                            }
                            playSong();
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            size: 40.0,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_isPlaying) {
                                _audioPlayer.pause();
                              } else {
                                _audioPlayer.play();
                              }
                              _isPlaying = !_isPlaying;
                            });
                          },
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 40.0,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // setState(() {
                            //   if (_audioPlayer.hasNext) {
                            //     _audioPlayer.seekToNext();
                            //     playSong();
                            //   } else {
                            //     playSong();
                            //   }
                            // });
                            {
                              if (_audioPlayer.hasNext) {
                                _audioPlayer.seekToNext();
                                playSong();
                              } else {
                                playSong();
                              }
                            }
                          },
                          icon: const Icon(
                            Icons.skip_next,
                            size: 40.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    _audioPlayer.seek(duration);
  }
}
