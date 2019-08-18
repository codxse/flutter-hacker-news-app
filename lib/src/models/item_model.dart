import 'dart:convert';

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'],
        this.deleted = parsedJson['deleted'] == 1 ? true : false,
        this.type = parsedJson['type'],
        this.by = parsedJson['by'],
        this.time = parsedJson['time'],
        this.text = parsedJson['text'],
        this.dead = parsedJson['dead'] == 1 ? true : false,
        this.parent = parsedJson['parent'],
        this.kids = parsedJson['kids'],
        this.url = parsedJson['url'],
        this.score = parsedJson['score'],
        this.title = parsedJson['title'],
        this.descendants = parsedJson['decendents'];

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'],
        this.deleted = parsedJson['deleted'] == 1,
        this.type = parsedJson['type'],
        this.by = parsedJson['by'],
        this.time = parsedJson['time'],
        this.text = parsedJson['text'],
        this.dead = parsedJson['dead'] == 1,
        this.parent = parsedJson['parent'],
        this.kids = jsonDecode(parsedJson['kids']),
        this.url = parsedJson['url'],
        this.score = parsedJson['score'],
        this.title = parsedJson['title'],
        this.descendants = parsedJson['decendents'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this.id,
      'deleted': this.deleted,
      'type': this.type,
      'by': this.by,
      'time': this.time,
      'text': this.text,
      'dead': this.dead,
      'parent': this.parent,
      'kids': this.kids,
      'url': this.url,
      'score': this.score,
      'title': this.title,
      'descendants': this.descendants
    };
  }

  Map<String, dynamic> toMapFordDb() {
    Map<String, dynamic> originMap = this.toMap();

    originMap['dead'] = this.dead == null ? 1 : 0;
    originMap['deleted'] = this.deleted == null ? 1 : 0;
    originMap['kids'] = jsonEncode(this.kids);
    originMap['type'] = this.type == null ? '' : this.type;
    originMap['by'] = this.by == null ? '' : this.by;
    originMap['time'] = this.time == null ? 0 : this.time;
    originMap['text'] = this.text == null ? '' : this.text;
    originMap['url'] = this.url == null ? 'https://www.google.com' : this.url;
    originMap['score'] = this.score == null ? 0 : this.score;
    originMap['title'] = this.title == null ? '' : this.title;

    return originMap;
  }

}
