import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

//差配役
class Repository {
  List<Source> sources = <Source>[
    //news_db_providerの変数
    newsDbProvider,
    NewsApiProvider(),
  ];
  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    //必要なNewsApiProviderのfetchTopIdsだけを実行させる
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    //ここで宣言しておくことでfor文の中からスコープを広げられる
    ItemModel item;
    Source source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      cache.addItem(item);
    }

    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}
