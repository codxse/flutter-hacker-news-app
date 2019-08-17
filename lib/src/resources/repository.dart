import 'dart:async';
import 'news_api_provider.dart' as api_prov;
import 'news_db_provider.dart' as db_prov;
import '../models/item_model.dart' as im;

class Repository {
  db_prov.NewsDbProvider _dbProvider = db_prov.NewsDbProvider();
  api_prov.NewsApiProvider _apiProvider = api_prov.NewsApiProvider();

  Future<List<int>> fetchTopId() async {
    return this._apiProvider.fetchTopIds();
  }

  Future<im.ItemModel> fetchItem(int id) async {
    im.ItemModel item = await this._dbProvider.fetchItem(id);

    if (item != null) {
      return item;
    }

    item = await this._apiProvider.fetchItem(id);
    this._dbProvider.addItem(item);

    return item;
  }
}
