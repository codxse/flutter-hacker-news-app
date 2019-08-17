import 'package:flutter/material.dart';
import 'stories_bloc.dart' as sb;
export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final sb.StoriesBloc bloc;

  StoriesProvider({Key key, Widget child})
      : bloc = sb.StoriesBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static sb.StoriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider) as StoriesProvider).bloc;
  }
}
