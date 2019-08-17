import 'package:flutter_hacker_news/src/resources/news_api_provider.dart'
    as news_api;
import 'package:flutter_hacker_news/src/models/item_model.dart' as im;
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;

void main() {
  test('FetchTopIds must return a list of ids', () async {
    final news_api.NewsApiProvider newsApi = news_api.NewsApiProvider();
    final http.Client newsApiMockClient =
        http_testing.MockClient((http.Request request) async {
      return http.Response(json.encode([1, 2, 3, 4]), 200);
    });

    newsApi.client = newsApiMockClient;

    final List<dynamic> ids = await newsApi.fetchTopIds();


    expect(ids, [1, 2, 3, 4]);
  });

  test('Fetch item must return item model', () async {
    final news_api.NewsApiProvider newsApi = news_api.NewsApiProvider();
    final http.Client newsAPiMockClient =
        http_testing.MockClient((http.Request request) async {
      final Map<String, dynamic> jsonItem = {'id': 123};
      return http.Response(json.encode(jsonItem), 200);
    });

    newsApi.client = newsAPiMockClient;
    final im.ItemModel item = await newsApi.fetchItem(666);

    expect(item.id, 123);
  });
}
