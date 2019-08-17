import 'package:flutter/material.dart';
import 'dart:async';
import '../blocs/stories_provider.dart' as prov;
import '../widgets/news_list_tile.dart' as news_list;

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov.StoriesBloc bloc = prov.StoriesProvider.of(context);

    bloc.fetchIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: this._buildList(bloc),
    );
  }

  Widget _buildList(prov.StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            bloc.fetchItem(snapshot.data[index]);
            return news_list.NewsListTile(itemId: snapshot.data[index]);
          },
        );
      },
    );
  }
}
