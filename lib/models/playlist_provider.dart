import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class PlayListProvider extends ChangeNotifier {
  // playlist of songs

  final List<Song> _playlist = [
    // songs
    Song(
      songName: "Hamdard",
      artistName: "Arijit Singh",
      albumImagePath: "assets/images/hamdard.png",
      audioPath: "assets/audio/Humdard.mp3",
    ),
    Song(
        songName: "Bolna",
        artistName: "Arijit Singh",
        albumImagePath: "assets/images/bolna.png",
        audioPath: "assets/audio/02 - Bolna.mp3"),
    Song(
      songName: "Ek Tarfa",
      artistName: "Arijit Singh",
      albumImagePath: "assets/images/ek_tarfa.png",
      audioPath: "assets/audio/- Ek Tarfa (320 Kbps) - DownloadMing.ME.mp3",
    ),
    Song(
      songName: "Enna Sona",
      artistName: "Arijit Singh",
      albumImagePath: "assets/images/enna_sona.png",
      audioPath: "assets/audio/Enna_Sona.mp3",
    ),
    Song(
      songName: "Mileya",
      artistName: "Arijit Singh",
      albumImagePath: "assets/images/mileya.png",
      audioPath:
          "assets/audio/01 Mileya Mileya  - Happy Ending (Rekha Bhardwaj) 190Kbps.mp3",
    ),
  ];

  // current song playing index
  int? _currentSongIndex;

  /*
  G E T T E R S
  */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  /*
  S E T T E R S
  */

  set currentSongIndex(int? newIndex) {
    // update current song Index
    _currentSongIndex = newIndex;
    // update the UI
    notifyListeners();
  }
}
