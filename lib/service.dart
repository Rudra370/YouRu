import 'package:AudioPlayer/model/youtube_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<List<String>> getUrls(String searchText) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String regEx = prefs.getString('regex') == null
        ? r'watch\?v=(\S{11})'
        : prefs.getString('regex');
    final response = await http.get(Uri(
        path: "/results",
        host: "https://www.youtube.com",
        query: "search_query=${searchText.replaceAll(' ', '+')}"));
    print(searchText.replaceAll(' ', '+'));
    RegExp regExp = RegExp(regEx);
    final listUrl = regExp.allMatches(response.body).toList();
    final List<String> listUrls = [];
    for (var item in listUrl) {
      listUrls.add(item.group(0));
    }
    return listUrls;
  }

  Future<Youtube> getVideo(String videoPath) async {
    final url = videoPath;
    final header = {
      'content-type': 'application/json',
      'accept': 'application/json, text/plain, */*'
    };
    final body = json.encode({'url': "https://www.youtube.com/$url"});
    final response = await http.post(
        Uri(
          host: 'https://y2mate.guru',
          path: '/api/convert',
        ),
        headers: header,
        body: body);
    if (response.body.contains("!!DOCTYPE html")) {
      return null;
    }
    final jsonData = json.decode(response.body);
    final videoData = Youtube.fromJson(jsonData);
    return videoData;
  }
}
