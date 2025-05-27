import 'package:html/dom.dart' as html;
import 'package:than_scraper/my_libs/fetcher/types/fetcher_data_types.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_query.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_query_attr_types.dart';


import '../types/fetcher_query_selector_types.dart';
import 'html_dom_services.dart';

class FetcherQueryServices {
  static String getQuery(
    html.Element? ele,
    FetcherQuery query, {
    String forwardProxy = '',
  }) {
    if (ele == null) return '';
    var res = '';

    if (query.selectorTypes == FetcherQuerySelectorTypes.listLast &&
        query.attrType == FetcherQueryAttrTypes.attr) {
      final list = ele.querySelectorAll(query.query);
      if (list.isNotEmpty) {
        res = list.last.attributes[query.attr] ?? '';
      }
    } else if (query.selectorTypes == FetcherQuerySelectorTypes.listFirst &&
        query.attrType == FetcherQueryAttrTypes.attr) {
      final list = ele.querySelectorAll(query.query);
      if (list.isNotEmpty) {
        res = list.first.attributes[query.attr] ?? '';
      }
    } else if (query.attrType == FetcherQueryAttrTypes.attr) {
      res = HtmlDomServices.getQuerySelectorAttr(ele, query.query, query.attr);
    } else {
      if (query.dataType == FetcherDataTypes.html) {
        //html
        res = HtmlDomServices.getQuerySelectorHtml(ele, query.query);
      } else {
        res = HtmlDomServices.getQuerySelectorHtml(ele, query.query);
        res = HtmlDomServices.getNewLine(res);
      }
    }
    if (query.isUsedForwardProxy && forwardProxy.isNotEmpty) {
      res = '$forwardProxy?url=$res';
    }
    return res;
  }
}
