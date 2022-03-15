import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:incredibclap/models/models.dart';

class AudiosProvider with ChangeNotifier {

  final List<Audio> _audiosConst = [
    Audio( id: 0, pathAudio: 'assets/audios/1_Base_cajon.mp3', pathIcon: "1", pathMusicSheet: "assets/sheets/1r.jpg"),
    Audio( id: 1, pathAudio: 'assets/audios/2_Base_palmas.mp3', pathIcon: "2", pathMusicSheet: "assets/sheets/2r.jpg"),
    Audio( id: 2, pathAudio: 'assets/audios/3_Acento_base_palmas.mp3', pathIcon: "3", pathMusicSheet: "assets/sheets/3r.jpg"),
    Audio( id: 3, pathAudio: 'assets/audios/4_Contra_1.mp3', pathIcon: "4", pathMusicSheet: "assets/sheets/4r.jpg"),
    Audio( id: 4, pathAudio: 'assets/audios/5_Contra_2.mp3', pathIcon: "5", pathMusicSheet: "assets/sheets/5r.jpg"),
    Audio( id: 5, pathAudio: 'assets/audios/6_Contra_3.mp3', pathIcon: "6", pathMusicSheet: "assets/sheets/6r.jpg"),
    Audio( id: 6, pathAudio: 'assets/audios/7_Contra_4.mp3', pathIcon: "7", pathMusicSheet:"assets/sheets/7r.jpg"),
    Audio( id: 7, pathAudio: 'assets/audios/8_Tresillo_taconeo_1.mp3', pathIcon: "8", pathMusicSheet: "assets/sheets/8r.jpg"),
    Audio( id: 8, pathAudio: 'assets/audios/9_Tresillo_taconeo_2.mp3', pathIcon: "9", pathMusicSheet: "assets/sheets/9r.jpg"),
    Audio( id: 9, pathAudio:'assets/audios/10_Cierre.mp3', pathIcon: "10", pathMusicSheet: "assets/sheets/10r.jpg"),
  ];

  late List<Audio> _audios;

  AudiosProvider() {
    _audios = _audiosConst.toList();
  }


  List<Audio> get audios => _audios;
  set audios( List<Audio> value ) {
    _audios = value;
    notifyListeners();
  }

  final List<AudioTab> _audiosTab = [
    AudioTab( id: 10, pathAudio: 'assets/audios/Tabs/Palma_01.wav', pathIcon: "Palma1"),
    AudioTab( id: 11, pathAudio: 'assets/audios/Tabs/Palma_02.wav', pathIcon: "Palma2"),
    AudioTab( id: 12, pathAudio: 'assets/audios/Tabs/Palma_03.wav', pathIcon: "Palma3"),
    AudioTab( id: 13, pathAudio: 'assets/audios/Tabs/Palma_04.wav', pathIcon: "Palma4"),
    AudioTab( id: 14, pathAudio: 'assets/audios/Tabs/Tacon_01.wav', pathIcon: "Tacon1"),
    AudioTab( id: 15, pathAudio: 'assets/audios/Tabs/Tacon_02.wav', pathIcon: "Tacon2"),
  ];

  List<AudioTab> get audiostab => _audiosTab;

  List<Audio> dragAudio = List.generate(8, (index) => Audio(id: -1));

  List<Audio> _dragAudioPaused = List.empty(growable: true);

  bool dragContaintAudio( int ind ) {
    return dragAudio[ind].id != -1 ? true : false;
  }

  void addAudioInDrag( Audio audio, int indDrag ) {
    audio.indDrag = indDrag;
    dragAudio[indDrag] = audio;
    notifyListeners();
  }

  void removeAudioInDrag( Audio value) {
    dragAudio = dragAudio.mapIndexed( (index, element) => index == value.indDrag ? Audio(id: -1) : element ).toList();
    value.indDrag = -1;
    notifyListeners();
  }

  void resetAudiosProvider() {
    for (var item in dragAudio) {
      if( item.id != -1){
        item.player.setVolume(0.0);
      }
    }
    dragAudio = List.generate(8, (index) => Audio(id: -1));
    notifyListeners();
  }

  bool isDragAudiosEmpty() {

    int cont = 0;

    for (var a in dragAudio) {
      a.id == -1 ? cont++ : null;
    }
    
    return cont == 8 ? true : false;

  }
  
  void audiosInDragPause() {
    for( Audio audio in dragAudio ) {
      if( audio.player.volume > 0 ) {
        audio.player.setVolume(0.0);
        _dragAudioPaused.add(audio);
      }
    }
  }

  void audiosInDragPlay() {
    for( Audio audio in _dragAudioPaused ) {
      for( Audio a in dragAudio ) {
        if( audio == a ) { 
          a.player.setVolume(1);
        }
      }
    }
    _dragAudioPaused = [];
  }

  void playAll(){
    for (var audio in _audios) {
      audio.player.play();
    }
  }

  void stopAll(){
    for (var audio in _audios) {
      // audio.player.setVolume(0);
      audio.player.dispose();
    }
  }
}