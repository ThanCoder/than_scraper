import 'package:than_scraper/my_libs/fetcher/types/fetcher_query_attr_types.dart';

import 'fetcher_data_types.dart';
import 'fetcher_query_selector_types.dart';

class FetcherQuery {
  String title;
  String query;
  String attr;
  FetcherQueryAttrTypes attrType;
  FetcherDataTypes dataType;
  FetcherQuerySelectorTypes selectorTypes;
  bool isUsedForwardProxy;
  bool isNotEmptyAble;

  FetcherQuery({
    this.title = 'Untitled',
    required this.query,
    this.attr = '',
    this.attrType = FetcherQueryAttrTypes.text,
    this.selectorTypes = FetcherQuerySelectorTypes.single,
    this.dataType = FetcherDataTypes.text,
    this.isUsedForwardProxy = false,
    this.isNotEmptyAble = false,
  });

  factory FetcherQuery.create(String query) {
    return FetcherQuery(query: query);
  }
}
