import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  @override
  _DemoPage createState() => _DemoPage();
}

class _DemoPage extends State<Demo> {

  late VideoPlayerController vidcontroller;
  late Future<void> _initializeVideoPlayerFuture;


  @override
  void initState(){
    super.initState();
    vidcontroller = VideoPlayerController.asset('assets/videos/cprdemo.mp4');
    vidcontroller.initialize().then((_) => setState(() {}));
    vidcontroller.setLooping(true);
    //_initializeVideoPlayerFuture = vidcontroller.initialize(); //first frame will be shown after video initialized
    vidcontroller.play(); //start playing by default, user does not need to click play button
  }
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(
          children: [
            Align(
              child:AspectRatio(
                  aspectRatio: vidcontroller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child:

                  VideoPlayer(vidcontroller)
                // Column(
                //   children:[
                //     VideoPlayer(vidcontroller),
                //     FloatingActionButton(
                //         child: Icon(Icons.timer),
                //         backgroundColor: Color.fromARGB(255, 9, 48, 83),
                //         foregroundColor: Colors.white,
                //         onPressed: () => Navigator.pushNamed(context, '/GeneratedFrame2Widget')
                //     ),
                //   ]
                // )
              )
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                  elevation:12,
                  label: Text('Skip'),
                  icon: Icon(Icons.skip_next),
                  backgroundColor: Color.fromARGB(255, 9, 48, 83),
                  foregroundColor: Colors.white,
                  onPressed:
                      () => Navigator.popAndPushNamed(context, '/GeneratedFrame2Widget'))
            )

          ]
        )

     );
  }





  @override
  void dispose() {
    super.dispose();
    vidcontroller.dispose();
  }
}