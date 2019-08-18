import 'dart:async';
import 'news_api_provider.dart' as api_prov;
import 'news_db_provider.dart' as db_prov;
import '../models/item_model.dart' as im;
import 'abstract/provider.dart' as prov;

class Repository {
  List<prov.Source> sources = <prov.Source>[
    db_prov.newsDbProvider,
    api_prov.NewsApiProvider(),
  ];

  List<prov.Cache> caches = <prov.Cache>[
    db_prov.newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() async {
    return this.sources[1].fetchTopIds();
  }

  Future<im.ItemModel> fetchItem(int id) async {
    //    im.ItemModel item = await this._dbProvider.fetchItem(id);
    //
    //    if (item != null) {
    //      return item;
    //    }
    //
    //    item = await this._apiProvider.fetchItem(id);
    //    this._dbProvider.addItem(item);
    //
    //    return item;
    im.ItemModel item;
    prov.Source source;

    for (source in this.sources) {
      item = await source.fetchItem(id);

      if (item != null) {
        break;
      }
    }

    for (prov.Cache cache in this.caches) {
      // ignore: unrelated_type_equality_checks
      if (cache != source) {
        cache.addItem(item);
      }
    }

    return item;

  }
}
