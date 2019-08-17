import 'package:flutter/material.dart';
import 'screens/news_list.dart' as nl;
import 'blocs/stories_provider.dart' as prov;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return prov.StoriesProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hacker News',
        home: nl.NewsList(),
      ),
    );
  }
}
