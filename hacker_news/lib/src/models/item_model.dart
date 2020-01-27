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

  //Named Constructor + initializer lists
  //Json coming from Api を　ItemModelのinstanceに変換している

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'],
        type = parsedJson['type'],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'],
        dead = parsedJson['dead'],
        parent = parsedJson['parent'],
        kids = parsedJson['kids'],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

  //Named Constructor + initializer lists
  //Map coming from Db　を　ItemModelに変換している　boolean型をもたない　
  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        //parsedJson['deleted']が1だったらtrue,0だったらfalseを代入という意味
        deleted = parsedJson['deleted'] == 1,
        type = parsedJson['type'],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'],
        dead = parsedJson['dead'] == 1,
        parent = parsedJson['parent'],
        //jsonのStringとしてのintのLIstを実際のList<int>に変換する
        kids = jsonDecode(parsedJson['kids']),
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

  //ItemModelのinstanceをMapに変換する
  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      "id": id,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "parent": parent,
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
      //sqliteのDbに加えるにはbooleanを1か0にしてやらないといけない
      "dead": dead ? 1 : 0,
      "deleted": deleted ? 1 : 0,
      //Jsonに戻してやる
      "kids": jsonEncode(kids),
    };
  }
}
