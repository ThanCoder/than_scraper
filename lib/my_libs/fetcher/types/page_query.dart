import 'package:than_scraper/my_libs/fetcher/types/fetcher_query.dart';
import 'package:than_scraper/my_libs/fetcher/types/page_query_types.dart';
import 'package:uuid/uuid.dart';

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
}
