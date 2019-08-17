import 'package:http/http.dart' as http;
import 'package:flutter_hacker_news/src/models/item_model.dart' as im;
import 'dart:convert';
import 'dart:async';

final String _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  http.Client _client = http.Client();

  Future<List<int>> fetchTopIds() async {
    final http.Response response =
        await this._client.get('$_root/topstories.json');
    final List<dynamic> ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<im.ItemModel> fetchItem(int id) async {
    final http.Response response =
        await this._client.get('$_root/item/$id.json');
    final Map<String, dynamic> parsedJson = json.decode(response.body);
    return im.ItemModel.fromJson(parsedJson);
  }

  set client(http.Client client) => this._client = client;
}
