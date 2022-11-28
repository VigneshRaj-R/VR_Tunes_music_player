import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/core/provider/provider_nowplaying.dart';
import 'package:music_player_app/ui/screens/favourites_button.dart';
import 'package:music_player_app/ui/widgets/songstorage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class NowPlaying extends StatelessWidget {
  NowPlaying({
    Key? key,
    required this.songs,
  }) : super(key: key);

  final List<SongModel> songs;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final providerNowplaying =
        Provider.of<ProviderNowplaying>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderNowplaying>(context, listen: false).mountedfunc();
    });

    return Consumer<ProviderNowplaying>(
        builder: (context, value, child) => Container(
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
                                  icon: const Icon(
                                      Icons.arrow_drop_down_circle_outlined),
                                  color: Colors.white,
                                ),
                                FavoriteBut(
                                    song:
                                        songs[providerNowplaying.currentindex])
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
                                  id: songs[providerNowplaying.currentindex].id,
                                  type: ArtworkType.AUDIO),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Text(
                                  songs[providerNowplaying.currentindex]
                                      .displayNameWOExt,
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
                                songs[providerNowplaying.currentindex]
                                            .artist
                                            .toString() ==
                                        '<unknown>'
                                    ? 'Unknown Artist'
                                    : songs[providerNowplaying.currentindex]
                                        .artist
                                        .toString(),
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
                            StreamBuilder<DurationState>(
                                stream: _durationStateStream,
                                builder: (context, snapshot) {
                                  final durationState = snapshot.data;
                                  final progress =
                                      durationState?.position ?? Duration.zero;
                                  final total =
                                      durationState?.total ?? Duration.zero;
                                  return ProgressBar(
                                      timeLabelTextStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 6, 52, 121),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      progress: progress,
                                      total: total,
                                      barHeight: 5.0,
                                      thumbRadius: 7,
                                      progressBarColor: Colors.white,
                                      thumbColor: Colors.white,
                                      baseBarColor: Colors.yellow[400],
                                      bufferedBarColor: Colors.yellow[400],
                                      buffered:
                                          const Duration(milliseconds: 2000),
                                      onSeek: (duration) {
                                        Songstorage.player.seek(duration);
                                      });
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (Songstorage.player.hasPrevious) {
                                      Songstorage.player.seekToPrevious();
                                      Songstorage.player.play();
                                    } else {
                                      Songstorage.player.play();
                                    }
                                    Songstorage.player.play();
                                  },
                                  icon: const Icon(
                                    Icons.skip_previous,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.green, backgroundColor: Colors.white, shape: const CircleBorder()),
                                  onPressed: () async {
                                    if (Songstorage.player.playing) {
                                      await Songstorage.player.pause();
                                      //  setState(() {});
                                      providerNowplaying;
                                    } else {
                                      await Songstorage.player.play();
                                      //setState(() {});
                                      providerNowplaying;
                                    }
                                  },
                                  child: StreamBuilder<bool>(
                                    stream: Songstorage.player.playingStream,
                                    builder: (context, snapshot) {
                                      bool? playingStage = snapshot.data;
                                      if (playingStage != null &&
                                          playingStage) {
                                        return const Icon(
                                          Icons.pause_circle_outline,
                                          size: 60,
                                        );
                                      } else {
                                        return const Icon(
                                          Icons.play_circle_outline,
                                          size: 60,
                                        );
                                      }
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    {
                                      if (Songstorage.player.hasNext) {
                                        Songstorage.player.seekToNext();
                                        Songstorage.player.play();
                                      } else {
                                        Songstorage.player.play();
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
            ));
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    _audioPlayer.seek(duration);
  }

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          Songstorage.player.positionStream,
          Songstorage.player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
