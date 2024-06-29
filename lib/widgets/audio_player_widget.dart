import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_storo/controllers/storage_controller.dart';
import 'package:cloud_storo/widgets/storage_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;

  const AudioPlayerWidget({super.key, required this.url});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {

  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration(); // Stores total audio duration
  Duration position = Duration(); // Stores current playback position

  bool playing = false;

  @override
  void initState() {
    super.initState();
    handleAudio();
  }

  handleAudio() async {
    if (playing) {
      audioPlayer.pause().catchError((error) {
        print("Error pausing audio: $error");
      });
      setState(() {
        playing = false;
      });
    } else {
      audioPlayer.play(UrlSource(widget.url)).catchError((error) {
        print("Error playing audio: $error");
      });
      setState(() {
        playing = true;
      });
    }

    // Update duration only once after audio loads (optional)
    audioPlayer.onDurationChanged.listen((Duration dd) {
      if (mounted && duration.inSeconds == 0) {
        setState(() {
          duration = dd;
        });
      }
    });

    // Update position continuously as audio plays
    audioPlayer.onPositionChanged.listen((Duration dd) {
      if (mounted) {
        setState(() {
          position = dd;
        });
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/mp3.png'),
            height: 64,
            width: 64,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 80,
          ),
          Slider.adaptive(
              min: 0.0,
              max: duration.inSeconds.toDouble(), // Use duration for max value
              value: position.inSeconds.toDouble(), // Use position for current value
              onChanged: (double value) {
                setState(() {
                  audioPlayer.seek(
                    Duration(
                      seconds: value.toInt(),
                    ),
                  );
                });
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  audioPlayer.seek(
                    Duration(
                      seconds: position.inSeconds - 15,
                    ),
                  );
                },
                icon: Icon(
                  Icons.fast_rewind_rounded,
                  color: Colors.white,
                ),
                iconSize: 32,
              ),
              IconButton(
                onPressed: () {
                  handleAudio();
                },
                icon: Icon(
                  playing == false ? Icons.play_circle : Icons.pause_circle,
                  color: Colors.white,
                ),
                iconSize: 56,
              ),
              IconButton(
                onPressed: () {
                  audioPlayer.seek(
                    Duration(
                      seconds: position.inSeconds + 15,
                    ),
                  );
                },
                icon: Icon(
                  Icons.fast_forward_rounded,
                  color: Colors.white,
                ),
                iconSize: 32,
              ),
            ],
          )
        ],
      ),
    );
  }
}
