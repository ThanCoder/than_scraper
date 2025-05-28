import 'package:than_scraper/my_libs/fetcher/services/map_services.dart';
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

  factory FetcherQuery.fromMap(Map<String, dynamic> map) {
    final attrType = MapServices.get<String>(map, ['attr'], defaultValue: '');
    final selectorTypes =
        MapServices.get<String>(map, ['selectorTypes'], defaultValue: '');
    final dataType =
        MapServices.get<String>(map, ['dataType'], defaultValue: '');

    return FetcherQuery(
      title: MapServices.get<String>(map, ['title'], defaultValue: ''),
      query: MapServices.get<String>(map, ['query'], defaultValue: ''),
      attr: MapServices.get<String>(map, ['attr'], defaultValue: ''),
      attrType: FetcherQueryAttrTypes.getType(attrType),
      selectorTypes: FetcherQuerySelectorTypes.getType(selectorTypes),
      dataType: FetcherDataTypes.getType(dataType),
      isUsedForwardProxy: MapServices.get<bool>(map, ['isUsedForwardProxy'],
          defaultValue: false),
      isNotEmptyAble:
          MapServices.get<bool>(map, ['isNotEmptyAble'], defaultValue: false),
    );
  }

  Map<String, dynamic> get toMap => {
        'title': title,
        'query': query,
        'attr': attr,
        'attrType': attrType.name,
        'selectorTypes': selectorTypes.name,
        'dataType': dataType.name,
        'isUsedForwardProxy': isUsedForwardProxy,
        'isNotEmptyAble': isNotEmptyAble,
      };
}
