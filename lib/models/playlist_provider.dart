import 'package:audioplayers/audioplayers.dart';
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
  A U D I O   P L A Y E R
  */

  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  PlayListProvider() {
    listenToDuration();
  }

  // initially not playing
  bool _isPlaying = false;

  // play the song
  void play() async {
    final String path = _playlist[currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // stop current song
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // seek to specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < playlist.length - 1) {
        // go to the next song it's not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        // if it's the last song, loop back to the first song
        currentSongIndex = 0;
      }
    }
  }

  // play previous song
  void playPreviousSong() {
    // if more than the 2 seconds have passed, restart the current song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      // if it's within first 2 seconds of the song, go to the previous song
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        // if it's the first song, loop back to the last song
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  // listen to duration
  void listenToDuration() {
    // listen for total Duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    // listen for current Duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });
    // listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // dispose audio player

  /*
  G E T T E R S
  */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /*
  S E T T E R S
  */

  set currentSongIndex(int? newIndex) {
    // update current song Index
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play(); // play the song at the new index
    }
    // update the UI
    notifyListeners();
  }
}
