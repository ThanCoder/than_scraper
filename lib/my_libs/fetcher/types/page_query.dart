import 'package:than_scraper/my_libs/fetcher/types/fetcher_query.dart';
import 'package:than_scraper/my_libs/fetcher/types/page_query_types.dart';
import 'package:uuid/uuid.dart';

import '../services/map_services.dart';

class PageQuery {
  String id;
  String desc;
  String minVersion;
  int date;
  String forwardProxy;

  String title;
  String url;
  PageQueryTypes type;
  //loop
  FetcherQuery mainLoopQuery;
  FetcherQuery nextUrlQuery;
  //inner query
  FetcherQuery titleQuery;
  FetcherQuery urlQuery;
  FetcherQuery coverUrlQuery;

  List<FetcherQuery> contentQueryList;

  PageQuery({
    required this.title,
    required this.url,
    required this.id,
    this.desc = '',
    this.minVersion = '1',
    this.forwardProxy = '',
    required this.date,
    this.type = PageQueryTypes.grid,
    required this.mainLoopQuery,
    required this.nextUrlQuery,
    required this.titleQuery,
    required this.urlQuery,
    required this.coverUrlQuery,
    required this.contentQueryList,
  });

  factory PageQuery.create() {
    return PageQuery(
      title: 'Untitled',
      url: '',
      id: Uuid().v4(),
      date: DateTime.now().millisecond,
      mainLoopQuery: FetcherQuery(query: ''),
      nextUrlQuery: FetcherQuery(query: ''),
      titleQuery: FetcherQuery(query: ''),
      urlQuery: FetcherQuery(query: ''),
      coverUrlQuery: FetcherQuery(query: ''),
      contentQueryList: [],
    );
  }

  factory PageQuery.fromMap(Map<String, dynamic> map) {
    final mainLoopQuery = MapServices.get<Map<String, dynamic>>(
        map, ['mainLoopQuery'],
        defaultValue: {});
    final nextUrlQuery = MapServices.get<Map<String, dynamic>>(
        map, ['nextUrlQuery'],
        defaultValue: {});
    final titleQuery = MapServices.get<Map<String, dynamic>>(
        map, ['titleQuery'],
        defaultValue: {});
    final urlQuery = MapServices.get<Map<String, dynamic>>(map, ['urlQuery'],
        defaultValue: {});
    final coverUrlQuery = MapServices.get<Map<String, dynamic>>(
        map, ['coverUrlQuery'],
        defaultValue: {});
    final contentQueryList = MapServices.get<List<dynamic>>(
        map, ['contentQueryList'],
        defaultValue: []);

    return PageQuery(
      title: MapServices.get<String>(map, ['title'], defaultValue: ''),
      url: MapServices.get<String>(map, ['url'], defaultValue: ''),
      id: MapServices.get<String>(map, ['id'], defaultValue: ''),
      date: MapServices.get<int>(map, ['date'], defaultValue: 0),
      mainLoopQuery: FetcherQuery.fromMap(mainLoopQuery),
      nextUrlQuery: FetcherQuery.fromMap(nextUrlQuery),
      titleQuery: FetcherQuery.fromMap(titleQuery),
      urlQuery: FetcherQuery.fromMap(urlQuery),
      coverUrlQuery: FetcherQuery.fromMap(coverUrlQuery),
      contentQueryList:
          contentQueryList.map((e) => FetcherQuery.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> get toMap => {
        'id': id,
        'title': title,
        'url': url,
        'minVersion': minVersion,
        'desc': desc,
        'forwardProxy': forwardProxy,
        'type': type.name,
        'mainLoopQuery': mainLoopQuery.toMap,
        'nextUrlQuery': nextUrlQuery.toMap,
        'titleQuery': titleQuery.toMap,
        'urlQuery': urlQuery.toMap,
        'coverUrlQuery': coverUrlQuery.toMap,
        'contentQueryList': contentQueryList.map((e) => e.toMap).toList(),
      };

  @override
  String toString() {
    return title;
  }
}
