import 'dart:convert';

import 'package:AudioPlayer/components/Colors.dart';
import 'package:AudioPlayer/components/TextStyleComponent.dart';
import 'package:AudioPlayer/model/youtube_model.dart';
import 'package:AudioPlayer/screens/settings.dart';
import 'package:AudioPlayer/service.dart';
import 'package:AudioPlayer/widget/video_details.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:http/http.dart' as http;

class CustomPlayer extends StatefulWidget {
  @override
  _CustomPlayerState createState() => _CustomPlayerState();
}

class _CustomPlayerState extends State<CustomPlayer>
    with SingleTickerProviderStateMixin {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  BottomBarController _bottomBarController;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  bool _searching = false;
  bool showResults = false;
  bool _playing = false;
  bool _songStarted = false;
  bool _loop = true;
  bool _buffering = false;
  double _currentSongPosition = 0.0;
  double _volume = 1.0;
  String _title;
  String _image;
  String _developerImage;
  final Api api = Api();
  List<String> links;
  List<Widget> resultsList = [];

  @override
  void initState() {
    _getDeveloperImage();
    _bottomBarController =
        BottomBarController(vsync: this, dragLength: 400, snap: true);
    assetsAudioPlayer.currentPosition.listen((event) {
      setState(() {
        _currentSongPosition = event.inSeconds.toDouble();
      });
    });
    assetsAudioPlayer.isPlaying.listen((isPlaying) {
      if (isPlaying) {
        setState(() {
          _playing = true;
        });
      }
      if (!isPlaying) {
        setState(() {
          _playing = false;
        });
      }
    });
    assetsAudioPlayer.isBuffering.listen((isBuffering) {
      setState(() {
        _buffering = isBuffering;
      });
    });
    assetsAudioPlayer.playlistAudioFinished.listen((Playing playing) {
      if (!_loop) {
        setState(() {
          _songStarted = false;
          _playing = false;
        });
      }
    });

    super.initState();
  }

  void _getDeveloperImage() async {
    final response = await http.get(Uri(
      host: "https://www.instagram.com",
      path: "/rudra._",
      query: "__a=1"
    ));
    final jsonData = json.decode(response.body);
    _developerImage = jsonData["graphql"]["user"]["profile_pic_url_hd"];
  }

  void _start(String url, String title, String image) async {
    try {
      final audio = Audio.network(
        url,
        metas: Metas(
          title: title,
          image: MetasImage.network(image),
        ),
      );
      print('Started');

      await assetsAudioPlayer.open(
        audio,
        volume: _volume,
        showNotification: true,
        audioFocusStrategy: AudioFocusStrategy.none(),
        notificationSettings: NotificationSettings(
          stopEnabled: false,
          customNextAction: (player) {
            player.seekBy(
              Duration(seconds: 5),
            );
          },
          customPrevAction: (player) {
            player.seekBy(
              -Duration(seconds: 5),
            );
          },
        ),
        forceOpen: true,
        respectSilentMode: false,
        loopMode: LoopMode.single,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
      );
      setState(() {
        _image = image;
        _title = title;
        _playing = true;
        _songStarted = true;
      });
    } catch (t) {
      setState(() {
        assetsAudioPlayer.stop();
        _playing = false;
      });
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }

  void _getUrls(String searchText) async {
    setState(() {
      _searching = false;
    });
    links = await api.getUrls(searchText);
    setState(() {
      showResults = true;
    });
    resultsList = [];
    // final info = await api.getVideo(links[0]);
    // setState(() {
    //   resultsList.add(VideoDetails(
    //     title: info.meta.title,
    //     imageUrl: info.thumb,
    //     duration: info.meta.duration,
    //   ));
    // });
    links.forEach((element) async {
      final Youtube videoInfo = await api.getVideo(element);
      if (videoInfo == null) return;
      if (videoInfo.meta != null) {
        setState(() {
          resultsList.add(GestureDetector(
            onTap: () {
              _start(videoInfo.url.firstWhere((item) => item.audio == true).url,
                  videoInfo.meta.title, videoInfo.thumb);
            },
            child: VideoDetails(
              title: videoInfo.meta.title,
              imageUrl: videoInfo.thumb,
              duration: videoInfo.meta.duration,
            ),
          ));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: _searching
            ? TextField(
                style: TextStyleComponent.v2normalWhite18,
                autofocus: true,
                focusNode: _focusNode,
                cursorColor: Colors.white,
                controller: _textEditingController,
                decoration: InputDecoration(
                  suffix: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        if (_textEditingController.value.text.isEmpty) {
                          _focusNode.unfocus();
                          setState(() {
                            _searching = false;
                          });
                          return;
                        }
                        _textEditingController.clear();
                      }),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onSubmitted: (searchText) {
                  if (searchText == null) return;
                  _getUrls(searchText);
                },
              )
            : Text('YouRu'),
        leading: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Settings(
                  developerImageUrl: _developerImage,
                ),
              ));
            }),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search_rounded,
                color: ColorCodes.cOffWhite,
              ),
              onPressed: () {
                if (!_focusNode.hasFocus ||
                    _textEditingController.value.text.length <= 2) {
                  setState(() {
                    _searching = !_searching;
                  });
                  return;
                }
                _getUrls(_textEditingController.value.text);
              })
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: showResults
              ? Column(
                  children: [
                    if (resultsList.length == 0)
                      Container(
                        height: size.height * 0.8,
                        width: size.width,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(ColorCodes.cOffWhite),
                          ),
                        ),
                      ),
                    ...resultsList,
                    SizedBox(
                      height: size.height * 0.15,
                    )
                  ],
                )
              : Container(
                  width: size.width,
                  height: size.height * 0.9,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'Hey ! Go search a song',
                      style: TextStyleComponent.boldWhite20,
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        // Set onVerticalDrag event to drag handlers of controller for swipe effect
        onVerticalDragUpdate: _bottomBarController.onDrag,
        onVerticalDragEnd: _bottomBarController.onDragEnd,
        child: FloatingActionButton(
          backgroundColor: ColorCodes.cOffWhite,
          child: _buffering
              ? Container(
                  width: size.width * 0.07,
                  height: size.width * 0.07,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(ColorCodes.cBackground),
                  ),
                )
              : Icon(
                  _playing ? Icons.pause : Icons.play_arrow,
                  color: ColorCodes.cBackground,
                  size: size.width * 0.07,
                ),
          onPressed: () async {
            if (await assetsAudioPlayer.current.isEmpty) return;
            try {
              await assetsAudioPlayer.playOrPause();
              // setState(() {
              //   _playing = !_playing;
              // });
            } on Exception catch (_) {
              return;
            }
          },
        ),
      ),

      // Actual expandable bottom bar
      bottomNavigationBar: BottomExpandableAppBar(
          controller: _bottomBarController,
          expandedHeight: size.height / 2,
          horizontalMargin: 5,
          shape: AutomaticNotchedShape(
              RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),
          expandedBackColor: ColorCodes.cBackground,
          bottomAppBarColor: ColorCodes.cNavBar,
          bottomAppBarBody: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.fast_rewind,
                      color: ColorCodes.cOffWhite,
                    ),
                    onPressed: () async {
                      if (await assetsAudioPlayer.current.isEmpty) return;
                      try {
                        await assetsAudioPlayer.seekBy(
                          -Duration(seconds: 5),
                        );
                      } on Exception catch (_) {
                        return;
                      }
                    },
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.fast_forward,
                      color: ColorCodes.cOffWhite,
                    ),
                    onPressed: () async {
                      if (await assetsAudioPlayer.current.isEmpty) return;
                      try {
                        await assetsAudioPlayer.seekBy(
                          Duration(seconds: 5),
                        );
                      } on Exception catch (_) {
                        return;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          expandedBody: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: size.height / 1.8,
              padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: size.height / 2 * 0.1,
                  top: size.height / 2 * 0.05),
              child: assetsAudioPlayer.current.hasValue
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                icon: Icon(
                                  _loop
                                      ? Icons.repeat_one_rounded
                                      : Icons.repeat_outlined,
                                  size: size.width * 0.1,
                                  color: _loop
                                      ? Colors.pink[700]
                                      : ColorCodes.cNavBar,
                                ),
                                onPressed: () {
                                  if (_loop) {
                                    assetsAudioPlayer
                                        .setLoopMode(LoopMode.none);
                                  } else {
                                    assetsAudioPlayer
                                        .setLoopMode(LoopMode.single);
                                  }
                                  setState(() {
                                    _loop = !_loop;
                                  });
                                }),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: size.width * 0.2,
                                  backgroundImage: NetworkImage(_image),
                                ),
                                SleekCircularSlider(
                                  initialValue: _currentSongPosition,
                                  min: 0,
                                  max: !assetsAudioPlayer.current.hasValue
                                      ? 0
                                      : assetsAudioPlayer.current.valueWrapper.value.audio
                                              .duration.inSeconds *
                                          1.0,
                                  onChange: (double value) {
                                    assetsAudioPlayer.seek(Duration(
                                      seconds: value.toInt(),
                                    ));
                                  },
                                  onChangeStart: (double startValue) {
                                    assetsAudioPlayer.pause();
                                  },
                                  onChangeEnd: (double endValue) {
                                    assetsAudioPlayer.play();
                                  },
                                  innerWidget: (percentage) {
                                    return Container();
                                  },
                                  appearance: CircularSliderAppearance(
                                    startAngle: 270,
                                    angleRange: 360,
                                    size: size.width * 0.5,
                                    customWidths: CustomSliderWidths(
                                        progressBarWidth: size.width * 0.04),
                                  ),
                                ),
                              ],
                            ),
                            RotatedBox(
                              quarterTurns: -1,
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 2,
                                ),
                                child: Slider(
                                  value: _volume,
                                  activeColor: Colors.pink[700],
                                  inactiveColor: ColorCodes.cNavBar,
                                  onChanged: (value) {
                                    setState(() {
                                      _volume = value;
                                    });
                                    assetsAudioPlayer.setVolume(_volume);
                                  },
                                  max: 1,
                                  min: 0,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          _title.length >= 51
                              ? _title.substring(0, 50) + '...'
                              : _title,
                          style: TextStyleComponent.boldWhite20,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          (Duration(seconds: _currentSongPosition.toInt())
                                  .inMinutes
                                  .remainder(60)
                                  .toString()
                                  .padLeft(2, "0") +
                              ':' +
                              Duration(seconds: _currentSongPosition.toInt())
                                  .inSeconds
                                  .remainder(60)
                                  .toString()
                                  .padLeft(2, "0") +
                              '/' +
                              assetsAudioPlayer
                                  .current.valueWrapper.value.audio.duration.inMinutes
                                  .remainder(60)
                                  .toString()
                                  .padLeft(2, "0") +
                              ':' +
                              assetsAudioPlayer
                                  .current.valueWrapper.value.audio.duration.inSeconds
                                  .remainder(60)
                                  .toString()
                                  .padLeft(2, "0")),
                          style: TextStyleComponent.normalDisabledGrey16,
                        ),
                      ],
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "Song details will be shown here",
                          style: TextStyleComponent.boldWhite20,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
          )),
    );
  }
}
