import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart' as im;
import '../blocs/stories_provider.dart' as prov;

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final prov.StoriesBloc bloc = prov.StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context, AsyncSnapshot<Map<int, Future<im.ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('stream items loading');
        }
        return FutureBuilder(
          future: snapshot.data[this.itemId],
          builder: (BuildContext context, AsyncSnapshot<im.ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('loading ${this.itemId}');
            }
            return Text(itemSnapshot.data.title);
          },
        );
      }
    );
  }
}