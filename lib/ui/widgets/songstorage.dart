import 'package:just_audio/just_audio.dart';

import 'package:on_audio_query/on_audio_query.dart';

class Songstorage {
  static AudioPlayer player = AudioPlayer();
  static int currentIndexx = 0;
  static List<SongModel> songCopy = [];
  static List<SongModel> playingSongs = [];
  static ConcatenatingAudioSource createSongList(List<SongModel> songs) {
    List<AudioSource> source = [];
    playingSongs = songs;
    for (var song in songs) {
      source.add(AudioSource.uri(
        Uri.parse(song.uri!),
        // tag: MediaItem(id: song.id.toString(), title: song.title,
        // album:song.album ,artist: song.artist)
      ));
    }
    return ConcatenatingAudioSource(children: source);
  }
}
