import 'package:AudioPlayer/components/Colors.dart';
import 'package:AudioPlayer/components/TextStyleComponent.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  final String developerImageUrl;

  const Settings({this.developerImageUrl});
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController _regexController = TextEditingController();
  String _developerImage;
  void _launchURL() async {
    const url = 'https://www.instagram.com/rudra._/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    _developerImage = widget.developerImageUrl == null
        ? "https://scontent-del1-1.cdninstagram.com/v/t51.2885-19/s320x320/140770913_1793610287468609_5905819693870997126_n.jpg?_nc_ht=scontent-del1-1.cdninstagram.com&_nc_ohc=SVzgrrIHgSoAX_Qf9ZK&tp=1&oh=09e9acef6a61c057cb4c22668ebe7d54&oe=60378711"
        : widget.developerImageUrl;
    super.initState();
  }

  dynamic _dialog(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: ColorCodes.cTransparent,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04, vertical: size.height * 0.01),
            // height: size.height * 0.3,
            width: size.width * 0.8,
            decoration: BoxDecoration(
              color: ColorCodes.cBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    cursorColor: ColorCodes.cOffWhite,
                    style: TextStyleComponent.v2normalWhite16,
                    controller: _regexController,
                    decoration: InputDecoration(
                      hintText: 'New Regex',
                      hintStyle: TextStyleComponent.normalDarkGrey14,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorCodes.cDarkGrey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorCodes.cDarkGrey),
                      ),
                    ),
                  ),
                  Text(
                    "Changing regex may crash the app.\nRestart app after change",
                    style: TextStyleComponent.normalRed12,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FlatButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove('regex');
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Reset',
                          style: TextStyleComponent.normalWhite14,
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          if (_regexController.value.text.isEmpty) {
                            Navigator.of(context).pop();
                          } else {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString(
                                'regex', _regexController.value.text);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          'Change',
                          style: TextStyleComponent.normalWhite14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var _gap = Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      height: size.height * 0.001,
      color: ColorCodes.cGrey,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02, vertical: size.height * 0.02),
          decoration: BoxDecoration(
            color: ColorCodes.cNavBar.withOpacity(0.7),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: ColorCodes.cTransparent,
                    radius: size.width * 0.1,
                    backgroundImage: NetworkImage(
                      _developerImage,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width * 0.66,
                        child: Text(
                          "Connect with the developer",
                          style: TextStyleComponent.v2normalWhite18,
                        ),
                      ),
                      InkWell(
                        enableFeedback: true,
                        onTap: _launchURL,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Instagram",
                              style: TextStyleComponent.v2LinkBlue16,
                            ),
                            Icon(
                              Icons.exit_to_app,
                              size: size.width * 0.05,
                              color: Colors.lightBlue[900],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              _gap,
              InkWell(
                enableFeedback: true,
                onTap: () {
                  _dialog(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  child: Text(
                    "Change RegEx",
                    style: TextStyleComponent.v2SettingList,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
