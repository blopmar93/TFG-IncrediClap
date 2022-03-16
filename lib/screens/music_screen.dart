import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:incredibclap/services/services.dart';
import 'package:incredibclap/widgets/music/music_draggable.dart';
import 'package:incredibclap/widgets/shared/app_bar_custom.dart';
import 'package:provider/provider.dart';

import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/providers/audio_provider.dart';
import 'package:incredibclap/widgets/music/music_widgets.dart';

class MusicScreen extends StatefulWidget {

static const String routeName = 'Music';

  const MusicScreen({Key? key}) : super(key: key);
  
  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {

  late AudiosProvider ap;
  @override
  void initState() {
    ap = Provider.of<AudiosProvider>(context, listen: false);
    // ap.isMusicScreen = true; 
    super.initState();
  }

  


  @override
  Widget build(BuildContext context) {

    const durationAnima = Duration(milliseconds: 800);
    final size = MediaQuery.of(context).size;
    bool firstPlay = true;
    const soundEnable = IconButton(onPressed: null, icon: Icon(Icons.bubble_chart));
    
    AudiosProvider ap = Provider.of<AudiosProvider>(context);
    DurationModel dm = Provider.of<DurationModel>(context);
    RecordService rs = Provider.of<RecordService>(context);

    List<AudioTab> audiosTab = ap.audiostab;
   
    const textStyleTab = TextStyle( color: Colors.black87);
    
    return WillPopScope( // Acciones al retroceder
      onWillPop: () async{ 
        ap.resetAudiosProvider();
        dm.playing = false;
        firstPlay = true;
        rs.isRecord = false;
        ap.isMusicScreen = false;
        dm.current = const Duration(seconds: 0);
        return true;
      },

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppBarCustom(
          title: "IncrediClap",
          elevation: 2,
        ),
        body:Column(
          children: [
       
            FadeInDown(
              duration: durationAnima,
              child: Column( // Drags Container
                children: [
                  
                  SizedBox(height: size.height*.04),
            
                  SizedBox(  
                    height: 70,
                    width: 70,
                    child: RadialProgress(
                      primaryColor: rs.isRecord ? Colors.red : Colors.black87 ,
                      percentage: dm.porcentaje,
                      percentageString: dm.currentSecond,
                      strokeWidthBack: 2,
                      strokeWidthFront: 3,
                    )
                  ),
            
                  SizedBox(
                    width: size.width,
                    child: Row( // Drags 1
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      
                        DragTarget<Audio>( // Audio 0
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          
                          ) => DragCustom( dragIndx: 0 ),
                          
                          onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 0, firstPlay)
                        ),
                        
                        DragTarget<Audio>( // Audio 1
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          
                          ) => DragCustom(  dragIndx: 1 ),
                          
                          onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 1, firstPlay)
                        ),
                          
                        DragTarget<Audio>( // Audio 2
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          
                          ) => DragCustom(dragIndx: 2,  ),
                                    
                          onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 2, firstPlay)
                                    
                        ),
                                    
                        DragTarget<Audio>( // Audio 3
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          
                          ) => DragCustom(dragIndx: 3 ),
                          
                          onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 3, firstPlay)
                                    
                        ),
                      ],
                    ),
                  ),
                
                  SizedBox(height: size.height*.01),
                
                  Row( // Drags 2
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                          
                      DragTarget<Audio>( // Audio 4
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        
                        ) => DragCustom( dragIndx: 4 ),
                        
                        onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 4, firstPlay)
                      ),
                      
                      DragTarget<Audio>( // Audio 5
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        
                        ) => DragCustom(  dragIndx: 5 ),
                        
                        onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 5, firstPlay)
                      ),
                        
                      DragTarget<Audio>( // Audio 6
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        
                        ) => DragCustom(dragIndx: 6),
                
                        onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 6, firstPlay)
                
                      ),
                
                      DragTarget<Audio>( // Audio 7
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        
                        ) => DragCustom(dragIndx: 7 ),
                        
                        onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 7, firstPlay)
                
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: size.height*.03),
      
        
            Column( // Draggables Container
              children: [
                FadeInLeft(
                  duration: durationAnima,
                  child: Row( // Contenedores de sonidos
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                          
                      !ap.dragAudio.contains(ap.audios[0]) 
                        ? MusicDraggable(data: ap.audios[0], child: Image(image: AssetImage(ap.audios[0].icon)) ) 
                        : _ImageDisable(path: ap.audios[0].iconDisable),
                          
                      !ap.dragAudio.contains(ap.audios[1]) 
                        ? MusicDraggable(data: ap.audios[1], child: Image(image: AssetImage(ap.audios[1].icon)))
                        :_ImageDisable(path: ap.audios[1].iconDisable),
                          
                      !ap.dragAudio.contains(ap.audios[2])  
                        ? MusicDraggable(data: ap.audios[2], child: Image(image: AssetImage(ap.audios[2].icon)) ) 
                        : _ImageDisable(path:ap.audios[2].iconDisable),
                          
                      !ap.dragAudio.contains(ap.audios[3])  
                        ? MusicDraggable(data: ap.audios[3], child: Image(image: AssetImage(ap.audios[3].icon)) ) 
                        : _ImageDisable(path:ap.audios[3].iconDisable),
                          
                      !ap.dragAudio.contains(ap.audios[4]) 
                        ? MusicDraggable(data: ap.audios[4], child: Image(image: AssetImage(ap.audios[4].icon)) ) 
                        : _ImageDisable(path:ap.audios[4].iconDisable),
                    ],
                  ),
                ),
                
                const SizedBox(height:20),
                
                FadeInRight(
                  duration: durationAnima,                
                  child: Row( // Contenedores de sonidos
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                          
                      !ap.dragAudio.contains(ap.audios[5]) 
                        ? MusicDraggable(data: ap.audios[5], child: Image(image: AssetImage(ap.audios[5].icon)) ) 
                        : _ImageDisable(path: ap.audios[5].iconDisable),
                          
                      !ap.dragAudio.contains(ap.audios[6]) 
                        ? MusicDraggable(data: ap.audios[6], child: Image(image: AssetImage(ap.audios[6].icon))) 
                        : _ImageDisable(path:ap.audios[6].iconDisable),
                          
                      !ap.dragAudio.contains(ap.audios[7])  
                        ? MusicDraggable(data: ap.audios[7], child: Image(image: AssetImage(ap.audios[7].icon)) ) 
                        : _ImageDisable(path: ap.audios[7].iconDisable),
                          
                      !ap.dragAudio.contains(ap.audios[8])  
                        ? MusicDraggable(data: ap.audios[8], child: Image(image: AssetImage(ap.audios[8].icon))) 
                        : _ImageDisable(path:ap.audios[8].iconDisable),
                          
                      !ap.dragAudio.contains(ap.audios[9]) 
                        ? MusicDraggable(data: ap.audios[9], child: Image(image: AssetImage(ap.audios[9].icon)) ) 
                        : _ImageDisable(path:ap.audios[9].iconDisable),
                    ],
                  ),
                ),
              ],
            ),
      
            SizedBox(height: size.height*.04),
        
            FadeInUp(
              duration: durationAnima,
              child: Row( // Tabs
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _TabAudio(audioTab: audiosTab[0], rs: rs, dm: dm, textStyleTab: textStyleTab),
                  _TabAudio(audioTab: audiosTab[1], rs: rs, dm: dm, textStyleTab: textStyleTab),
                  _TabAudio(audioTab: audiosTab[2], rs: rs, dm: dm, textStyleTab: textStyleTab),
                  _TabAudio(audioTab: audiosTab[3], rs: rs, dm: dm, textStyleTab: textStyleTab),
                  _TabAudio(audioTab: audiosTab[4], rs: rs, dm: dm, textStyleTab: textStyleTab),
                  _TabAudio(audioTab: audiosTab[5], rs: rs, dm: dm, textStyleTab: textStyleTab),
                ],
              ),
            ),
      
            SizedBox(height: size.height*.05),
        
            FadeIn(
              duration: durationAnima,
              child: _MusicMenuLocation()
            )
          ],
        )
      ),
    );
  }

  void _onAccept(AudiosProvider ap, Audio audio, DurationModel dm, RecordService rs, int ind, bool firstPlay) { 
     
    if( !ap.dragContaintAudio(ind) ){
      
      setState(() {
        ap.addAudioInDrag(audio, ind);
        audio.player.setVolume(1);

        if(firstPlay) {
          ap.playAll();
          dm.soundDuration = audio.player.duration!;
          audio.player.createPositionStream().listen((event) {dm.currentSheets = event;});
          firstPlay = false;
        }

        rs.addPoint(dm.current, audio);
      });

    }
  }


}

class _ImageDisable extends StatelessWidget {
  const _ImageDisable({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(path),height: 50);
  }
}

class _TabAudio extends StatelessWidget {
  const _TabAudio({
    Key? key,
    required this.audioTab,
    required this.textStyleTab,
    required this.rs,
    required this.dm
  }) : super(key: key);

  final AudioTab audioTab;
  final TextStyle textStyleTab;
  final RecordService rs;
  final DurationModel dm;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        IconButton(
          onPressed: () { 
            audioTab.play();
            rs.isRecord ? rs.addPoint( dm.current , audioTab.audio ) : null;
          }, 
          icon: const Icon(Icons.touch_app),
        ),
        Text(audioTab.icon, style: textStyleTab,)
      ],
    );
  }
}

class _MusicMenuLocation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      child: const Center(
        child: MusicMenu()
      )
    );
  }
}



