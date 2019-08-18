import 'dart:async';
import 'package:rxdart/rxdart.dart' as rx;
import '../models/item_model.dart' as im;
import '../resources/repository.dart' as repo;

class StoriesBloc {
  final repo.Repository _repository = repo.Repository();

  // ignore: close_sinks
  final rx.PublishSubject<List<int>> _topIds = rx.PublishSubject<List<int>>();

  // ignore: close_sinks
  final rx.BehaviorSubject<Map<int, Future<im.ItemModel>>> _itemsOutput =
      rx.BehaviorSubject<Map<int, Future<im.ItemModel>>>();

  // ignore: close_sinks
  final rx.PublishSubject<int> _itemsFetcher = rx.PublishSubject<int>();

  StoriesBloc() {
    this
        ._itemsFetcher
        .stream
        .transform(this._itemsTransformer())
        .pipe(this._itemsOutput);
  }

  void fetchIds() async {
    final List<int> ids = await this._repository.fetchTopIds();
    this._topIds.sink.add(ids);
  }

  rx.Observable<List<int>> get topIds => this._topIds.stream;

  rx.Observable<Map<int, Future<im.ItemModel>>> get items =>
      this._itemsOutput.stream;

  dynamic _itemsTransformer() {
    return rx.ScanStreamTransformer(
        (Map<int, Future<im.ItemModel>> cache, int id, int index) {
      cache[id] = this._repository.fetchItem(id);
      return cache;
    }, <int, Future<im.ItemModel>>{});
  }

  Function(int) get fetchItem => this._itemsFetcher.sink.add;

  void dispose() {
    this._topIds.close();
    this._itemsOutput.close();
    this._itemsFetcher.close();
  }
}
