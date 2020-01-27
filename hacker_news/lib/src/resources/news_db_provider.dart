import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  //コンストラクタでinitを呼ぶようにする
  NewsDbProvider() {
    init();
  }

  //abstractを継承するための要件を満たすためのpretend
  Future<List<int>> fetchTopIds() => null;

  void init() async {
    //mobile debice上のファイルの保存先のディレクトリのreferenceを取得
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //取得したディレクトリへのパスとitem.dbをjoin関数で結合させて実際にデータベースを作るファイルパスをdbに代入
    final path = join(documentsDirectory.path, "item.db");
    //openDatabaseで初めてならDbを作り、二回目以降なら再度DBを開いて接続
    db = await openDatabase(path,
        //データベースの構造などの状態が変わった時などに加算されていく
        version: 1,
        //最初にDbを作るときに呼ばれる関数プロパティ
        onCreate: (Database newDb, int version) {
      //テーブルを作りcolumnを設定
      newDb.execute("""
          CREATE TABLE Items
                (
                  id INTEGER PRIMARY KEY,
                  type TEXT,
                  by TEXT,
                  time INTEGER,
                  text TEXT,
                  parent INTEGER,
                  kids BLOB,
                  dead INTEGER,
                  deleted INTEGER,
                  url TEXT,
                  score INTEGER,
                  title TEXT,
                  descendants INTEGER
                )
            """);
    });
  }

  Future<ItemModel> fetchItem(int id) async {
    //query:接続したDbのテーブルなどを検索し見つけ次第返す
    final maps = await db.query(
      //探すテーブル名
      "Items",
      //検索する場所（column?）を指定できる　例["title"]など　この場合全体を取ってきたいのでnull
      columns: null,
      //クエリで条件に合った場所を探すよう指定できる。？にはwhereArgsで指定したfetchItemの引数のidが入る
      where: "id = ?",
      //悪意あるユーザーの攻撃を避けるために後置的に条件の値を指定する　listの最初の要素？
      whereArgs: [id],
    );

    if (maps.length > 0) {
      //List<Map<String, dynamic>> queryを実行して帰ってきたマップたちのリストから最初のmapを渡す
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  //DbにItemがなかった時にapiから取ってきたItemを登録する
  Future<int> addItem(ItemModel item) {
    //追加する場所のテーブル名と登録するためにItemModelのinstanceをMapに変換して渡す
    return db.insert("Items", item.toMapForDb());
  }
}

//sqlite Dbは同じDbに何度も接続しアクセスされるのを良しとしないのでここでinstanceを作り使いまわす
final newsDbProvider = NewsDbProvider();
