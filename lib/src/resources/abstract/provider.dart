import 'dart:async';
import '../../models/item_model.dart' as im;

abstract class Source {
  Future<List<int>> fetchTopIds();

  Future<im.ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(im.ItemModel item);
}