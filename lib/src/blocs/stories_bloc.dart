import 'dart:async';
import 'package:rxdart/rxdart.dart' as rx;
import '../models/item_model.dart' as im;
import '../resources/repository.dart' as repo;

class StoriesBloc {
  final repo.Repository _repository = repo.Repository();
  final rx.PublishSubject<List<int>> _topIds = rx.PublishSubject<List<int>>(); // ignore: close_sinks
  final rx.BehaviorSubject<int> _items = rx.BehaviorSubject<int>(); // ignore: close_sinks
  rx.Observable<Map<int, Future<im.ItemModel>>> items;

  StoriesBloc() {
    this.items = this._items.stream.transform(this._itemsTransformer());
  }

  void fetchIds() async {
    final List<int> ids = await this._repository.fetchTopIds();
    this._topIds.sink.add(ids);
  }

  rx.Observable<List<int>> get topIds => this._topIds.stream;

  dynamic _itemsTransformer() {
    return rx.ScanStreamTransformer(
      (Map<int, Future<im.ItemModel>> cache, int id, int index) {
        cache[id] = this._repository.fetchItem(id);
        return cache;
      },
      <int, Future<im.ItemModel>>{});
  }

  Function(int) get fetchItem => this._items.sink.add;

  void dispose() {
    this._topIds.close();
    this._items.close();
  }
}
